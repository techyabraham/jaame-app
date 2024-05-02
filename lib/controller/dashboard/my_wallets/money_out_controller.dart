import 'dart:io';

import 'package:adescrow_app/utils/basic_screen_imports.dart';

import '../../../backend/models/dashboard/home_model.dart' as home;

import '../../../backend/backend_utils/logger.dart';
import '../../../backend/models/common/common_success_model.dart';
import '../../../backend/models/money_out/money_out_index_model.dart';
import '../../../backend/models/money_out/money_out_manual_model.dart';
import '../../../backend/services/api_endpoint.dart';
import '../../../backend/services/money_out_api_service.dart';
import '../../../routes/routes.dart';
import '../../../views/confirm_screen.dart';
import '../../../widgets/custom_dropdown_widget/custom_dropdown_widget.dart';
import '../../../widgets/others/custom_upload_file_widget.dart';
import '../../auth/kyc_form_controller.dart';

final log = logger(MoneyOutController);

class MoneyOutController extends GetxController with MoneyOutApiService{

  final amountController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  late RxString selectedCurrency;
  late RxString selectedCurrencyType;
  late RxDouble selectedCurrencyRate;
  late RxString selectedCurrencyImage;

  late RxString selectedMethodID;
  late RxString selectedMethod;
  late RxString selectedMethodImage;
  late RxString selectedMethodType;
  late RxString selectedMethodAlias;
  late RxString selectedMethodCurrencyCode;
  late RxDouble selectedMethodMax;
  late RxDouble selectedMethodMin;
  late RxDouble selectedMethodPCharge;
  late RxDouble selectedMethodFCharge;
  late RxDouble selectedMethodRate;

  RxDouble exchangeRate = 0.0.obs;
  RxDouble min = 0.0.obs;
  RxDouble max = 0.0.obs;

  exchangeCalculation(){
    exchangeRate.value = (1/selectedCurrencyRate.value) * selectedMethodRate.value;
    min.value = selectedMethodMin.value / exchangeRate.value;
    max.value = selectedMethodMax.value / exchangeRate.value;

    debugPrint("exchangeCalculation");
    debugPrint(exchangeRate.value.toString());
    debugPrint(min.value.toString());
    debugPrint(max.value.toString());
  }

  @override
  void dispose() {
    amountController.dispose();
    super.dispose();
  }

  final home.UserWallet data = Get.arguments;

  @override
  onInit(){
    debugPrint(data.name);
    debugPrint(data.currencyCode);
    debugPrint(data.balance.toStringAsFixed(2));
    super.onInit();
    moneyOutInfoAPI();
  }


  final _isLoading = false.obs;
  bool get isLoading => _isLoading.value;


  // fetch info
  late MoneyOutIndexModel _moneyOutIndexModel;
  MoneyOutIndexModel get moneyOutIndexModel => _moneyOutIndexModel;

  Future<MoneyOutIndexModel> moneyOutInfoAPI() async {
    _isLoading.value = true;
    update();

    await moneyOutIndexAPi().then((value) {
      _moneyOutIndexModel = value!;

      // final currency = _moneyOutIndexModel.data.userWallet.first;
      selectedCurrency = data.currencyCode.toString().obs;
      selectedCurrencyType = data.currencyType.obs;
      selectedCurrencyImage = "${ApiEndpoint.mainDomain}/${data.imagePath}/${data.flag}".obs;
      selectedCurrencyRate = data.rate.obs;

      final gateway = _moneyOutIndexModel.data.gatewayCurrencies.first;
      selectedMethodID = gateway.paymentGatewayId.toString().obs;
      selectedMethod = gateway.name.obs;
      selectedMethodImage = gateway.image.toString().obs;
      selectedMethodType = gateway.mType.obs;
      selectedMethodAlias = gateway.alias.obs;
      selectedMethodCurrencyCode  = gateway.mCurrencyCode.obs;
      selectedMethodMax = gateway.maxLimit.obs;
      selectedMethodMin = gateway.minLimit.obs;
      selectedMethodPCharge = gateway.percentCharge.obs;
      selectedMethodFCharge = gateway.fixedCharge.obs;
      selectedMethodRate = gateway.mRate.obs;

      exchangeCalculation();

      update();
    }).catchError((onError) {
      log.e(onError);
    });

    _isLoading.value = false;
    update();

    return _moneyOutIndexModel;
  }


  onConfirmProcess(BuildContext context) {

    if(selectedMethodType.value == "AUTOMATIC"){
      // if(selectedMethodID.value == "1"){
      //   Navigator.push(
      //       context,
      //       MaterialPageRoute(
      //           builder: (context) => WebViewScreen(
      //             appTitle: addMoneyPaypalModel.data.gatewayCurrencyName,
      //             link: webUrl,
      //             onFinished: (url){
      //
      //               debugPrint("---------------------------------");
      //               debugPrint("URL    --------------------------");
      //               debugPrint(url.toString());
      //               if (url.toString().contains('success/response') ||
      //                   url.toString().contains('sslcommerz/success') ||
      //                   url.toString().contains('stripe/payment/success/')) {
      //
      //                 Navigator.push(
      //                     context,
      //                     MaterialPageRoute(
      //                         builder: (context) => ConfirmScreen(
      //                           message: Strings.addMoneyConfirmationMSG,
      //                           // onApproval: true,
      //                           onOkayTap: () => Get.offAllNamed(Routes.dashboardScreen),
      //                         )));
      //               }
      //
      //             },
      //           )));
      // }
      // else{
      //   Navigator.push(
      //       context,
      //       MaterialPageRoute(
      //           builder: (context) => WebViewScreen(
      //             appTitle: addMoneyAutomaticModel.data.gatewayCurrencyName,
      //             link: webUrl,
      //             onFinished: (url){
      //
      //               debugPrint("---------------------------------");
      //               debugPrint("URL    --------------------------");
      //               debugPrint(url.toString());
      //               if (url.toString().contains('success/response') ||
      //                   url.toString().contains('sslcommerz/success') ||
      //                   url.toString().contains('stripe/payment/confirmed/') ||
      //                   url.toString().contains('stripe/payment/success/'
      //                   )) {
      //
      //                 Navigator.push(
      //                     context,
      //                     MaterialPageRoute(
      //                         builder: (context) => ConfirmScreen(
      //                           message: Strings.addMoneyConfirmationMSG,
      //                           // onApproval: true,
      //                           onOkayTap: () => Get.offAllNamed(Routes.dashboardScreen),
      //                         )));
      //               }
      //
      //             },
      //           )));
      // }
    }
    else if(selectedMethodType.value == "MANUAL"){
      Get.toNamed(Routes.moneyOutManualScreen, arguments: data);
    }
  }

  void onManualSubmit(BuildContext context) async{
    await manualSubmitApiProcess().then((value){
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => ConfirmScreen(
                message: Strings.moneyOutConfirmationMSG,
                onApproval: true,
                onOkayTap: () => Get.offAllNamed(Routes.dashboardScreen),
              )));
    });
  }

  late String webUrl;
  late PaymentInformations information;

  void moneyOutBTNClicked(BuildContext context) async{
    if (amountController.text.isNotEmpty) {
      if(selectedMethodType.value == "AUTOMATIC"){
        // if(selectedMethodID.value == "1"){
        //   await onPaypalProcess().then((value) {
        //     webUrl = value.data.url[1].href;
        //     information = value.data.paymentInformations;
        //     Get.toNamed(Routes.addMoneyScreenPreview);
        //   });
        // }
        // else{
        //   await onAutomaticProcess().then((value) {
        //     webUrl = value.data.url;
        //     information = value.data.paymentInformations;
        //     Get.toNamed(Routes.addMoneyScreenPreview);
        //   });
        // }
      }
      else if(selectedMethodType.value == "MANUAL"){
        await onManualProcess();
      }

    }
  }


  final _isSubmitLoading = false.obs;
  bool get isSubmitLoading => _isSubmitLoading.value;

// manual money out process
  late MoneyOutManualModel _moneyOutManualModel;
  MoneyOutManualModel get moneyOutManualModel => _moneyOutManualModel;

  Future<MoneyOutManualModel> onManualProcess() async {
    inputFields.clear();
    inputFileFields.clear();
    listImagePath.clear();
    idTypeList.clear();
    listFieldName.clear();
    inputFieldControllers.clear();
    update();

    _isSubmitLoading.value = true;
    update();

    Map<String, dynamic> inputBody = {
      'amount': amountController.text,
      'sender_currency': selectedCurrency.value,
      'gateway_currency': selectedMethodAlias.value,
    };

    await moneyOutSubmitManualApi(body: inputBody).then((value) async {
      _moneyOutManualModel = value!;


      final data = _moneyOutManualModel.data.inputFields;
      _getDynamicInputField(data);
      information = value.data.paymentInformations;
      Get.toNamed(Routes.moneyOutScreenPreview);

      _isSubmitLoading.value = false;
      update();
    }).catchError((onError) {
      log.e(onError);
    });
    _isSubmitLoading.value = false;
    update();
    return _moneyOutManualModel;
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
    _isSubmitLoading.value = false;
    update();
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

  ///* manual submit submit api process
  Future<CommonSuccessModel> manualSubmitApiProcess() async {
    _isLoading.value = true;
    Map<String, String> inputBody = {
      "trx": _moneyOutManualModel.data.paymentInformations.trx
    };

    final data = _moneyOutManualModel.data.inputFields;

    for (int i = 0; i < data.length; i += 1) {
      if (data[i].type != 'file') {
        inputBody[data[i].name] = inputFieldControllers[i].text;
      }
    }

    await moneyOutManualConfirmApi(
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
    _isLoading.value = false;
    update();
    return _commonSuccessModel;
  }
}