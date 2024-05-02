import 'dart:io';

import '../../backend/backend_utils/custom_snackbar.dart';
import '../../backend/backend_utils/logger.dart';
import '../../backend/local_storage/local_storage.dart';
import '../../backend/models/auth/kyc_model.dart';
import '../../backend/models/common/common_success_model.dart';
import '../../backend/services/kyc_api_service.dart';
import '../../routes/routes.dart';
import '../../utils/basic_screen_imports.dart';
import '../../views/confirm_screen.dart';
import '../../widgets/custom_dropdown_widget/custom_dropdown_widget.dart';
import '../../widgets/others/custom_upload_file_widget.dart';

final log = logger(KYCFormController);

class KYCFormController extends GetxController with KycApiService{
  final formKey = GlobalKey<FormState>();

  void onSubmitProcess(BuildContext context) {
    if (formKey.currentState!.validate()) {
      if(totalFile == listFieldName.length) {
        kycSubmitApiProcess().then((value) => Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => ConfirmScreen(
                    message: Strings.kycFormConfirmationMSG,
                    onApproval: true,
                    onOkayTap: (){
                      LocalStorage.isLoginSuccess(isLoggedIn: true);
                      Get.offAllNamed(Routes.dashboardScreen);
                    }
                  ))));
      }
      else{
        CustomSnackBar.error("Select File");
      }
    }
  }

  @override
  void onInit() {
    kycInfoFetch();
    super.onInit();
  }

  List<TextEditingController> inputFieldControllers = [];
  RxList inputFields = [].obs;
  RxList inputFileFields = [].obs;

  final selectedIDType = "".obs;
  List<IdTypeModel> idTypeList = [];

  int totalFile = 0;
  List<String> listImagePath = [];
  List<String> listFieldName = [];
  RxBool hasFile = false.obs;

  final _isLoading = false.obs;
  bool get isLoading => _isLoading.value;

  final _isSubmitLoading = false.obs;
  bool get isSubmitLoading => _isSubmitLoading.value;

  late KycModel _kycModel;
  KycModel get kycModel => _kycModel;

  Future<KycModel> kycInfoFetch() async {
    _isLoading.value = true;
    inputFields.clear();
    inputFileFields.clear();
    listImagePath.clear();
    idTypeList.clear();
    listFieldName.clear();
    inputFieldControllers.clear();
    update();

    await kycFieldAPi().then((value) {
      _kycModel = value!;

      final data = _kycModel.data.inputFields;
      _getDynamicInputField(data);

      update();
    }).catchError((onError) {
      log.e(onError);
    });
    _isLoading.value = false;
    update();

    return _kycModel;
  }

  void _getDynamicInputField(List<InputField> data) {
    for (int item = 0; item < data.length; item++) {
      // make the dynamic controller
      var textEditingController = TextEditingController();
      inputFieldControllers.add(textEditingController);
      // make dynamic input widget
      if (data[item].type.contains('select')) {
        hasFile.value = true;
        selectedIDType.value = data[item].validation.options.first.toString();
        inputFieldControllers[item].text = selectedIDType.value;
        for (var element in data[item].validation.options) {
          idTypeList.add(IdTypeModel(element, element));
        }
        inputFields.add(
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Obx(() => CustomDropDown<IdTypeModel>(
                  items: idTypeList,
                  title: data[item].label,
                  hint: selectedIDType.value.isEmpty
                      ? Strings.selectIDType
                      : selectedIDType.value,
                  onChanged: (value) {
                    selectedIDType.value = value!.title;
                  },
                  padding: EdgeInsets.symmetric(
                    horizontal: Dimensions.paddingSizeHorizontal * 0.25,
                  ),
                  titleTextColor:
                      CustomColor.primaryLightTextColor.withOpacity(.2),
                  borderEnable: true,
                  dropDownFieldColor: Colors.transparent,
                  dropDownIconColor:
                      CustomColor.primaryLightTextColor.withOpacity(.2))),
              verticalSpace(Dimensions.marginBetweenInputBox * .8),
            ],
          ),
        );
      }
      else if (data[item].type.contains('file')) {
        totalFile++;
        hasFile.value = true;
        inputFileFields.add(
          Column(
            mainAxisAlignment: mainStart,
            crossAxisAlignment: crossStart,
            children: [
              CustomUploadFileWidget(
                labelText: data[item].label,
                hint: data[item].validation.mimes.join(","),
                onTap: (File value) {
                  updateImageData(data[item].name, value.path);
                },
              ),
            ],
          ),
        );
      }
      else if (data[item].type.contains('text')) {
        inputFields.add(
          Column(
            mainAxisAlignment: mainStart,
            crossAxisAlignment: crossStart,
            children: [
              PrimaryTextInputWidget(
                controller: inputFieldControllers[item],
                labelText: data[item].label,
              ),
              verticalSpace(Dimensions.marginBetweenInputBox * .8),
            ],
          ),
        );
      }
    }
  }

  updateImageData(String fieldName, String imagePath) {
    if (listFieldName.contains(fieldName)) {
      int itemIndex = listFieldName.indexOf(fieldName);
      listImagePath[itemIndex] = imagePath;
    } else {
      listFieldName.add(fieldName);
      listImagePath.add(imagePath);
    }
    update();
  }

  /// >>> set and get model for kyc submit
  late CommonSuccessModel _commonSuccessModel;
  CommonSuccessModel get commonSuccessModel => _commonSuccessModel;

  ///* Kyc submit api process
  Future<CommonSuccessModel> kycSubmitApiProcess() async {
    _isSubmitLoading.value = true;
    Map<String, String> inputBody = {};

    final data = kycModel.data.inputFields;

    for (int i = 0; i < data.length; i += 1) {
      if (data[i].type != 'file') {
        inputBody[data[i].name] = inputFieldControllers[i].text;
      }
    }

    await kycSubmitProcessApi(
            body: inputBody, fieldList: listFieldName, pathList: listImagePath)
        .then((value) {
      _commonSuccessModel = value!;
      // onConfirmProcess(
      //     message: _commonSuccessModel.message.success.first.toString());
      inputFields.clear();
      listImagePath.clear();
      listFieldName.clear();
      inputFieldControllers.clear();
      _isLoading.value = false;
      update();
    }).catchError((onError) {
      log.e(onError);
    });
    _isSubmitLoading.value = false;
    update();
    return _commonSuccessModel;
  }
}

class IdTypeModel implements DropdownModel {
  final String mId;
  final String name;

  IdTypeModel(this.mId, this.name);

  @override
  // TODO: implement code
  String get mcode => throw UnimplementedError();

  @override
  // TODO: implement img
  String get img => throw UnimplementedError();

  @override
  // TODO: implement title
  String get title => name;

  @override
  // TODO: implement currencyCode
  String get currencyCode => throw UnimplementedError();

  @override
  // TODO: implement currencySymbol
  String get currencySymbol => throw UnimplementedError();


  @override
  // TODO: implement type
  String get type => throw UnimplementedError();

  @override
  // TODO: implement fCharge
  double get fCharge => throw UnimplementedError();

  @override
  // TODO: implement max
  double get max => throw UnimplementedError();

  @override
  // TODO: implement min
  double get min => throw UnimplementedError();

  @override
  // TODO: implement pCharge
  double get pCharge => throw UnimplementedError();

  @override
  // TODO: implement rate
  double get rate => throw UnimplementedError();

  @override
  // TODO: implement id
  String get id => throw UnimplementedError();
}
