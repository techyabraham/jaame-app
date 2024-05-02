import 'dart:io';

import 'package:adescrow_app/backend/models/common/common_success_model.dart';
import 'package:adescrow_app/utils/basic_screen_imports.dart';

import '../../../backend/backend_utils/logger.dart';
import '../../../backend/models/tatum/tatum_model.dart' as tatum;
import '../../../backend/models/escrow/escrow_automatic_payment_model.dart';
import '../../../backend/models/escrow/escrow_create_model.dart';
import '../../../backend/models/escrow/escrow_manual_payment_model.dart';
import '../../../backend/models/escrow/escrow_paypal_payment_model.dart';
import '../../../backend/models/escrow/escrow_submit_model.dart';
import '../../../backend/models/escrow/user_check_model.dart';
import '../../../backend/services/escrow_api_service.dart';
import '../../../routes/routes.dart';
import '../../../views/confirm_screen.dart';
import '../../../views/web_view/web_view_screen.dart';
import '../../../widgets/custom_dropdown_widget/custom_dropdown_widget.dart';
import '../../../widgets/others/custom_upload_file_widget.dart';
import '../../auth/kyc_form_controller.dart';

final log = logger(AddNewEscrowController);

class AddNewEscrowController extends GetxController with EscrowApiService {
  final formKey = GlobalKey<FormState>();
  final formManualKey = GlobalKey<FormState>();

  final titleController = TextEditingController();
  final emailController = TextEditingController();
  final amountController = TextEditingController();
  final remarksController = TextEditingController();

  final selectedCategory = "".obs;
  final selectedCategoryId = "".obs;

  final selectedMyRole = "".obs;
  final selectedOppositeRole = "".obs;
  List<EscrowStaticModel> myRoleList = [
    EscrowStaticModel("1", "Buyer"),
    EscrowStaticModel("2", "Seller"),
  ];

  final selectedPayBy = "Me".obs;
  List<EscrowStaticModel> payByList = [
    EscrowStaticModel("1", "Me"),
    EscrowStaticModel("2", ""),
    EscrowStaticModel("3", "50% - 50%"),
  ];

  final selectedCurrency = "".obs;
  final selectedCurrencyBalance = "".obs;
  final selectedCurrencyType = "".obs;

  final selectedPaymentMethod = "".obs;
  final selectedPaymentMethodAlias = "".obs;
  final selectedPaymentMethodId = "".obs;
  final selectedPaymentMethodTypeId = "".obs;
  final selectedPaymentMethodType = "".obs;
  List<GatewayCurrency> selectedPaymentList = [];

  @override
  void dispose() {
    titleController.dispose();
    emailController.dispose();
    amountController.dispose();
    remarksController.dispose();

    super.dispose();
  }

  ///  ---------------- fetch and submit and confirm apis
  @override
  void onInit() {
    escrowIndexFetch();
    super.onInit();
  }

  final _isLoading = false.obs;
  bool get isLoading => _isLoading.value;

  final _isSubmitLoading = false.obs;
  bool get isSubmitLoading => _isSubmitLoading.value;

  // fetch info
  late EscrowCreateModel _escrowIndexModel;
  EscrowCreateModel get escrowIndexModel => _escrowIndexModel;

  Future<EscrowCreateModel> escrowIndexFetch() async {
    _isLoading.value = true;
    update();

    await escrowCreateAPi().then((value) {
      _escrowIndexModel = value!;
      selectedCategory.value =
          _escrowIndexModel.data.escrowCategories.first.name;
      selectedCategoryId.value =
          _escrowIndexModel.data.escrowCategories.first.mId.toString();

      selectedCurrency.value =
          _escrowIndexModel.data.userWallet.first.mCurrencyCode;
      selectedCurrencyType.value =
          _escrowIndexModel.data.userWallet.first.currencyType;
      selectedCurrencyBalance.value = _escrowIndexModel
          .data.userWallet.first.balance
          .toStringAsFixed(selectedCurrencyType.value == "FIAT" ? 2 : 6);

      selectedPaymentList.add(GatewayCurrency(
          mId: -1,
          paymentGatewayId: -1,
          mType: "",
          name: "",
          alias: "",
          mCurrencyCode: "",
          mCurrencySymbol: "",
          image: "",
          minLimit: -1,
          maxLimit: -1,
          percentCharge: -1,
          fixedCharge: -1,
          mRate: -1));

      for (var element in _escrowIndexModel.data.gatewayCurrencies) {
        selectedPaymentList.add(element);
      }

      selectedMyRole.value =
          _escrowIndexModel.data.userType == "seller" ? "Seller" : "Buyer";
      selectedOppositeRole.value =
          _escrowIndexModel.data.userType == "seller" ? "Buyer" : "Seller";

      update();
    }).catchError((onError) {
      log.e(onError);
    });

    _isLoading.value = false;
    update();

    return _escrowIndexModel;
  }

  // check user info
  late UserCheckModel _userCheckModel;
  UserCheckModel get userCheckModel => _userCheckModel;

  RxBool isValidUser = false.obs;
  RxString user = "".obs;

  Future<UserCheckModel> escrowUserCheck(String value) async {
    // _isLoading.value = true;
    // update();
    user.value = emailController.text;

    debugPrint("********");
    debugPrint(user.value);

    if (user.value.isNotEmpty) {
      await escrowUserCheckAPi(user.value).then((value) {
        _userCheckModel = value!;
        isValidUser.value = _userCheckModel.data.userCheck;
        update();
      }).catchError((onError) {
        log.e(onError);
      });
    }

    return _userCheckModel;
  }

  RxString selectedFilePath = "".obs;
  late EscrowSubmitModel _escrowSubmitModel;
  EscrowSubmitModel get escrowSubmitModel => _escrowSubmitModel;

  void onAddNewEscrowProcess() async {
    if (formKey.currentState!.validate()) {
      if (selectedFilePath.value.isEmpty) {
        await escrowWithoutFileSubmit();
      } else {
        await escrowWithFileSubmit();
      }
    }
  }

  Future<EscrowSubmitModel> escrowWithoutFileSubmit() async {
    _isSubmitLoading.value = true;
    update();

    Map<String, String> inputBody = {
      "title": titleController.text,
      "buyer_seller_identify": emailController.text,
      "amount": amountController.text,
      "remarks": remarksController.text,
      "escrow_category": selectedCategoryId.value,
      "role": selectedMyRole.value == "Buyer" ? "buyer" : "seller",
      "who_will_pay_options": selectedPayBy.value.isEmpty
          ? (selectedOppositeRole.value == "Buyer" ? "buyer" : "seller")
          : selectedPayBy.value == "50% - 50%"
              ? "half"
              : "me",
      "escrow_currency": selectedCurrency.value,
      "payment_gateway": selectedPaymentMethod.value.isEmpty
          ? "myWallet"
          : selectedPaymentMethodId.value,
    };

    await escrowSubmitWithoutFileApi(body: inputBody).then((value) {
      _escrowSubmitModel = value!;
      isValidUser.value = _userCheckModel.data.userCheck;
      Get.toNamed(Routes.addNewEscrowPreviewScreen);
      update();
    }).catchError((onError) {
      log.e(onError);
    });

    _isSubmitLoading.value = false;
    update();
    return _escrowSubmitModel;
  }

  Future<EscrowSubmitModel> escrowWithFileSubmit() async {
    _isSubmitLoading.value = true;
    update();

    Map<String, String> inputBody = {
      "title": titleController.text,
      "buyer_seller_identify": emailController.text,
      "amount": amountController.text,
      "remarks": remarksController.text,
      "escrow_category": selectedCategoryId.value,
      "role": selectedMyRole.value == "Buyer" ? "buyer" : "seller",
      "who_will_pay_options": selectedPayBy.value.isEmpty
          ? (selectedOppositeRole.value == "Buyer" ? "buyer" : "seller")
          : selectedPayBy.value == "50% - 50%"
              ? "half"
              : "me",
      "escrow_currency": selectedCurrency.value,
      "payment_gateway": selectedPaymentMethod.value.isEmpty
          ? "myWallet"
          : selectedPaymentMethodId.value,
    };

    await escrowSubmitWithFileApi(
            body: inputBody, filePath: selectedFilePath.value)
        .then((value) {
      _escrowSubmitModel = value!;
      isValidUser.value = _userCheckModel.data.userCheck;
      Get.toNamed(Routes.addNewEscrowPreviewScreen);
      update();
    }).catchError((onError) {
      log.e(onError);
    });

    _isSubmitLoading.value = false;
    update();
    return _escrowSubmitModel;
  }

  /// -------------- confirm and payment apis ---------
  void onConfirmProcess(BuildContext context) async {
    if (selectedMyRole.value == "Buyer") {
      // Note selectedPaymentMethod.value.isEmpty when wallet is selected
      if (selectedPaymentMethod.value.isEmpty) {
        escrowConfirm().then((value) => Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => ConfirmScreen(
                      message: value.message!.success!.first,
                      onApproval: true,
                      onOkayTap: () => Get.offAllNamed(Routes.dashboardScreen),
                    ))));
      } else {
        _onPayment(context);
      }
    } else {
      escrowConfirm().then((value) => Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => ConfirmScreen(
                    message: value.message!.success!.first,
                    onApproval: true,
                    onOkayTap: () => Get.offAllNamed(Routes.dashboardScreen),
                  ))));
    }
  }

  _onPayment(BuildContext context) async {
    /// for automatic payment
    if (selectedPaymentMethodType.value == "AUTOMATIC") {
      if (selectedPaymentMethodAlias.value.contains("tatum")) {
        await escrowTatumPayment();
      } else if (selectedPaymentMethodTypeId.value == "1") {
        await escrowPaypal(context);
      } else {
        await escrowAutomatic(context);
      }
    }

    /// for manual payment
    else if (selectedPaymentMethodType.value == "MANUAL") {
      await escrowManualPayment();
    }
  }

  _webPayment(BuildContext context, {required String webUrl, title}) {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => WebViewScreen(
                  appTitle: title,
                  link: webUrl,
                  onFinished: (url) {
                    debugPrint("---------------------------------");
                    debugPrint("URL    --------------------------");
                    debugPrint(url.toString());
                    if (url.toString().contains('success/response') ||
                        url.toString().contains('sslcommerz/success') ||
                        url.toString().contains('payment/confirmed') ||
                        url.toString().contains('payment/callback') ||
                        url.toString().contains('razor-pay/callback') ||
                        url.toString().contains('api-razor/callback') ||
                        url.toString().contains('razor-pay-api/callback') ||
                        url.toString().contains(
                            'escrow-payment-api/callback?razorpay_order_id') ||
                        url.toString().contains('payment/success')) {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ConfirmScreen(
                                    message:
                                        Strings.addNewEscrowConfirmationMSG,
                                    // onApproval: true,
                                    onOkayTap: () =>
                                        Get.offAllNamed(Routes.dashboardScreen),
                                  )));
                    }
                  },
                )));
  }

  late CommonSuccessModel _commonSuccessModel;
  CommonSuccessModel get commonSuccessModel => _commonSuccessModel;

  late EscrowPaypalPaymentModel _escrowPaypalPaymentModel;
  EscrowPaypalPaymentModel get escrowPaypalPaymentModel =>
      _escrowPaypalPaymentModel;

  late EscrowAutomaticPaymentModel _escrowAutomaticPaymentModel;
  EscrowAutomaticPaymentModel get escrowAutomaticPaymentModel =>
      _escrowAutomaticPaymentModel;

  late EscrowManualPaymentModel _escrowManualPaymentModel;
  EscrowManualPaymentModel get escrowManualPaymentModel =>
      _escrowManualPaymentModel;

  late tatum.TatumModel _escrowTatumPaymentModel;
  tatum.TatumModel get escrowTatumPaymentModel =>
      _escrowTatumPaymentModel;

  Future<CommonSuccessModel> escrowConfirm() async {
    _isSubmitLoading.value = true;
    update();

    Map<String, String> inputBody = {
      "trx": escrowSubmitModel.data.escrowInformation.trx,
    };

    await escrowConfirmApi(body: inputBody).then((value) {
      _commonSuccessModel = value!;
      _isSubmitLoading.value = false;
      update();
    }).catchError((onError) {
      log.e(onError);
    });

    _isSubmitLoading.value = false;
    update();
    return _commonSuccessModel;
  }

  Future<EscrowPaypalPaymentModel?> escrowPaypal(BuildContext context) async {
    _isSubmitLoading.value = true;
    update();

    Map<String, String> inputBody = {
      "trx": escrowSubmitModel.data.escrowInformation.trx,
    };

    await escrowPaypalApi(body: inputBody).then((value) {
      _escrowPaypalPaymentModel = value!;

      _webPayment(context,
          webUrl: value.data.url[1].href,
          title: selectedPaymentMethod.value);

      _isSubmitLoading.value = false;
      update();
    }).catchError((onError) {
      log.e(onError);
    });

    _isSubmitLoading.value = false;
    update();
    return _escrowPaypalPaymentModel;
  }

  Future<EscrowAutomaticPaymentModel?> escrowAutomatic(BuildContext context) async {
    _isSubmitLoading.value = true;
    update();

    Map<String, String> inputBody = {
      "trx": escrowSubmitModel.data.escrowInformation.trx,
    };

    await escrowAutomaticApi(body: inputBody).then((value) {
      _escrowAutomaticPaymentModel = value!;

      _webPayment(context,
          webUrl: value.data.url, title: selectedPaymentMethod.value);

      _isSubmitLoading.value = false;
      update();
    }).catchError((onError) {
      log.e(onError);
    });

    _isSubmitLoading.value = false;
    update();
    return _escrowAutomaticPaymentModel;
  }

  /// for tatum payment
  Future<tatum.TatumModel?> escrowTatumPayment() async {
    inputFields.clear();
    inputFieldControllers.clear();
    update();

    _isSubmitLoading.value = true;
    update();

    Map<String, String> inputBody = {
      "trx": escrowSubmitModel.data.escrowInformation.trx,
    };

    await escrowTatumApi(body: inputBody).then((value) {
      _escrowTatumPaymentModel = value!;

      var data = _escrowTatumPaymentModel.data.addressInfo.inputFields;
      for (int item = 0; item < data.length; item++) {
        // make the dynamic controller
        var textEditingController = TextEditingController();
        inputFieldControllers.add(textEditingController);

        if (data[item].type.contains('text')) {
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

      Get.toNamed(Routes.escrowTatumScreen);

      _isSubmitLoading.value = false;
      update();
    }).catchError((onError) {
      log.e(onError);
    });

    _isSubmitLoading.value = false;
    update();
    return _escrowTatumPaymentModel;
  }

  /// for manual payment
  Future<EscrowManualPaymentModel?> escrowManualPayment() async {
    inputFields.clear();
    inputFileFields.clear();
    listImagePath.clear();
    idTypeList.clear();
    listFieldName.clear();
    inputFieldControllers.clear();
    update();

    _isSubmitLoading.value = true;
    update();

    Map<String, String> inputBody = {
      "trx": escrowSubmitModel.data.escrowInformation.trx,
    };

    await escrowManualApi(body: inputBody).then((value) {
      _escrowManualPaymentModel = value!;
      _getDynamicInputField(_escrowManualPaymentModel.data.inputFields);

      Get.toNamed(Routes.escrowManualScreen);
      _isSubmitLoading.value = false;
      update();
    }).catchError((onError) {
      log.e(onError);
    });

    _isSubmitLoading.value = false;
    update();
    return _escrowManualPaymentModel;
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
      } else if (data[item].type.contains('file')) {
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
      } else if (data[item].type.contains('text')) {
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

  ///* manual submit submit api process
  Future<CommonSuccessModel> manualSubmitApiProcess() async {
    _isLoading.value = true;
    Map<String, String> inputBody = {
      "trx": escrowSubmitModel.data.escrowInformation.trx,
    };

    final data = _escrowManualPaymentModel.data.inputFields;

    for (int i = 0; i < data.length; i += 1) {
      if (data[i].type != 'file') {
        inputBody[data[i].name] = inputFieldControllers[i].text;
      }
    }

    await escrowManualSubmitApi(
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

  onManualSubmit(BuildContext context) {
    if (formManualKey.currentState!.validate()) {
      manualSubmitApiProcess().then((value) {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => ConfirmScreen(
                      message: value.message!.success!.first,
                      onApproval: true,
                      onOkayTap: () => Get.offAllNamed(Routes.dashboardScreen),
                    )));
      });
    }
  }

  ///* manual submit submit api process
  Future<CommonSuccessModel> tatumSubmitApiProcess() async {
    _isLoading.value = true;
    Map<String, String> inputBody = {};

    final data = _escrowTatumPaymentModel.data.addressInfo.inputFields;

    for (int i = 0; i < data.length; i += 1) {
      inputBody[data[i].name] = inputFieldControllers[i].text;
    }

    await escrowTatumSubmitApi(
            body: inputBody,
            url: _escrowTatumPaymentModel.data.addressInfo.submitUrl)
        .then((value) {
      _commonSuccessModel = value!;

      inputFields.clear();
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

  onTatumSubmit(BuildContext context) {
    if (formManualKey.currentState!.validate()) {
      tatumSubmitApiProcess().then((value) {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => ConfirmScreen(
                      message: value.message!.success!.first,
                      onApproval: true,
                      onOkayTap: () => Get.offAllNamed(Routes.dashboardScreen),
                    )));
      });
    }
  }
}

///for static drop down
class EscrowStaticModel implements DropdownModel {
  // ignore: annotate_overrides
  final String id;
  final String name;

  EscrowStaticModel(this.id, this.name);

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
}
