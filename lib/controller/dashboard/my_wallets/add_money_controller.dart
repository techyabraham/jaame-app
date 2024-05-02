import 'dart:io';

import 'package:adescrow_app/backend/services/api_endpoint.dart';
import 'package:adescrow_app/utils/basic_screen_imports.dart';

import '../../../backend/models/tatum/tatum_model.dart' as tatum;
import '../../../backend/models/dashboard/home_model.dart' as home;

import '../../../backend/backend_utils/logger.dart';
import '../../../backend/models/add_money/add_money_automatic_model.dart';
import '../../../backend/models/add_money/add_money_index_model.dart';
import '../../../backend/models/add_money/add_money_manual_model.dart';
import '../../../backend/models/add_money/add_money_paypal_model.dart';
import '../../../backend/models/add_money/payment_information_model.dart';
import '../../../backend/models/common/common_success_model.dart';
import '../../../backend/services/add_money_api_service.dart';
import '../../../routes/routes.dart';
import '../../../views/confirm_screen.dart';
import '../../../views/web_view/web_view_screen.dart';
import '../../../widgets/custom_dropdown_widget/custom_dropdown_widget.dart';
import '../../../widgets/others/custom_upload_file_widget.dart';
import '../../auth/kyc_form_controller.dart';

final log = logger(AddMoneyController);

class AddMoneyController extends GetxController with AddMoneyApiService {
  final amountController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  late RxString selectedCurrency;
  late RxDouble selectedCurrencyRate;
  late RxString selectedCurrencyType;
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

  exchangeCalculation() {
    exchangeRate.value =
        (1 / selectedCurrencyRate.value) * selectedMethodRate.value;
    min.value = selectedMethodMin.value / exchangeRate.value;
    max.value = selectedMethodMax.value / exchangeRate.value;
  }

  @override
  void dispose() {
    amountController.dispose();
    super.dispose();
  }

  final home.UserWallet data = Get.arguments;

  @override
  void onInit() {
    debugPrint(data.name);
    debugPrint(data.currencyCode);
    debugPrint(data.balance.toStringAsFixed(2));
    addMoneyIndexAPI();
    super.onInit();
  }

  final _isLoading = false.obs;
  bool get isLoading => _isLoading.value;

  // fetch info
  late AddMoneyIndexModel _addMoneyIndexModel;
  AddMoneyIndexModel get addMoneyIndexModel => _addMoneyIndexModel;

  Future<AddMoneyIndexModel> addMoneyIndexAPI() async {
    _isLoading.value = true;
    update();

    await addMoneyIndexAPi().then((value) {
      _addMoneyIndexModel = value!;

      // final currency = _addMoneyIndexModel.data.userWallet.first;
      selectedCurrency = data.currencyCode.obs;
      selectedCurrencyType = data.currencyType.obs;
      selectedCurrencyImage =
          "${ApiEndpoint.mainDomain}/${data.imagePath}/${data.flag}".obs;
      selectedCurrencyRate = data.rate.obs;

      final gateway = _addMoneyIndexModel.data.gatewayCurrencies.first;
      selectedMethodID = gateway.paymentGatewayId.toString().obs;
      selectedMethod = gateway.name.obs;
      selectedMethodImage = gateway.image.toString().obs;
      selectedMethodType = gateway.mType.obs;
      selectedMethodAlias = gateway.alias.obs;
      selectedMethodCurrencyCode = gateway.mCurrencyCode.obs;
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

    return _addMoneyIndexModel;
  }

  onConfirmProcess(BuildContext context) {
    if (selectedMethodType.value == "AUTOMATIC") {
      if (selectedMethodAlias.value.contains("tatum")) {
        debugPrint("Tatum -> ");
        Get.toNamed(Routes.addMoneyTatumScreen, arguments: data);
      } else if (selectedMethodID.value == "1") {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => WebViewScreen(
                      appTitle: addMoneyPaypalModel.data.gatewayCurrencyName,
                      link: webUrl,
                      onFinished: (url) {
                        debugPrint("---------------------------------");
                        debugPrint("URL    --------------------------");
                        debugPrint(url.toString());
                        if (url.toString().contains('success/response')) {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => ConfirmScreen(
                                        message:
                                            Strings.addMoneyConfirmationMSG,
                                        // onApproval: true,
                                        onOkayTap: () => Get.offAllNamed(
                                            Routes.dashboardScreen),
                                      )));
                        }
                      },
                    )));
      } else {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => WebViewScreen(
                      appTitle: addMoneyAutomaticModel.data.gatewayCurrencyName,
                      link: webUrl,
                      onFinished: (url) {
                        debugPrint("---------------------------------");
                        debugPrint("URL    --------------------------");
                        debugPrint(url.toString());
                        if (url.toString().contains('success/response') ||
                            url.toString().contains('sslcommerz/success') ||
                            url.toString().contains('payment/callback') ||
                            url.toString().contains('razor-pay/callback') ||
                            url.toString().contains('api-razor/callback') ||
                            url.toString().contains('razor-pay-api/callback') ||
                            url.toString().contains(
                                'escrow-payment-api/callback?razorpay_order_id') ||
                            url.toString().contains('payment/confirmed') ||
                            url.toString().contains('payment/success')) {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => ConfirmScreen(
                                        message:
                                            Strings.addMoneyConfirmationMSG,
                                        // onApproval: true,
                                        onOkayTap: () => Get.offAllNamed(
                                            Routes.dashboardScreen),
                                      )));
                        }

                        debugPrint("Confirmed");
                      },
                    )));
      }
    } else if (selectedMethodType.value == "MANUAL") {
      Get.toNamed(Routes.addMoneyManualScreen, arguments: data);
    }
  }

  void onManualSubmit(BuildContext context) async {
    await manualSubmitApiProcess().then((value) {
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => ConfirmScreen(
                    message: Strings.addMoneyConfirmationMSG,
                    onApproval: true,
                    onOkayTap: () => Get.offAllNamed(Routes.dashboardScreen),
                  )));
    });
  }

  void onTatumSubmit(BuildContext context) async {
    await tatumSubmitApiProcess().then((value) {
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => ConfirmScreen(
                    message: Strings.addMoneyConfirmationMSG,
                    onApproval: true,
                    onOkayTap: () => Get.offAllNamed(Routes.dashboardScreen),
                  )));
    });
  }

  late String webUrl;
  late PaymentInformations information;

  void addMoneyBTNClicked(BuildContext context) async {
    if (amountController.text.isNotEmpty) {
      if (selectedMethodType.value == "AUTOMATIC") {
        if (selectedMethodAlias.value.contains("tatum")) {
          await onTatumProcess().then((value) {
            information = value.data.paymentInformations;
            Get.toNamed(Routes.addMoneyScreenPreview);
          });
        } else if (selectedMethodID.value == "1") {
          await onPaypalProcess().then((value) {
            webUrl = value.data.url[1].href;
            information = value.data.paymentInformations;
            Get.toNamed(Routes.addMoneyScreenPreview);
          });
        } else {
          debugPrint("working");
          await onAutomaticProcess().then((value) {
            webUrl = value.data.url;
            information = value.data.paymentInformations;
            Get.toNamed(Routes.addMoneyScreenPreview);
          });
        }
      } else if (selectedMethodType.value == "MANUAL") {
        await onManualProcess();
      }
    }
  }

  final _isSubmitLoading = false.obs;
  bool get isSubmitLoading => _isSubmitLoading.value;

// add money automatic process
  late AddMoneyAutomaticModel _addMoneyAutomaticModel;
  AddMoneyAutomaticModel get addMoneyAutomaticModel => _addMoneyAutomaticModel;

  Future<AddMoneyAutomaticModel> onAutomaticProcess() async {
    _isSubmitLoading.value = true;
    update();

    Map<String, dynamic> inputBody = {
      'gateway_currency': selectedMethodAlias.value,
      'amount': amountController.text,
      'sender_currency': selectedCurrency.value,
    };

    await addMoneySubmitAutomaticApi(body: inputBody).then((value) async {
      _addMoneyAutomaticModel = value!;
      debugPrint("Working");
      debugPrint(_addMoneyAutomaticModel.data.url);

      update();
    }).catchError((onError) {
      log.e(onError);
    });
    _isSubmitLoading.value = false;
    update();
    return _addMoneyAutomaticModel;
  }

// add money automatic process
  late tatum.TatumModel _addMoneyTatumModel;
  tatum.TatumModel get addMoneyTatumModel => _addMoneyTatumModel;

  Future<tatum.TatumModel> onTatumProcess() async {
    inputFields.clear();
    inputFieldControllers.clear();

    _isSubmitLoading.value = true;
    update();

    Map<String, dynamic> inputBody = {
      'amount': amountController.text,
      'sender_currency': selectedCurrency.value,
      'gateway_currency': selectedMethodAlias.value,
    };

    await addMoneySubmitTatumApi(body: inputBody).then((value) async {
      _addMoneyTatumModel = value!;

      var data = _addMoneyTatumModel.data.addressInfo.inputFields;
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
      _isSubmitLoading.value = false;
      update();

      update();
    }).catchError((onError) {
      log.e(onError);
    });
    _isSubmitLoading.value = false;
    update();
    return addMoneyTatumModel;
  }

  ///* manual submit submit api process
  Future<CommonSuccessModel> tatumSubmitApiProcess() async {
    _isLoading.value = true;
    Map<String, String> inputBody = {};

    final data = _addMoneyTatumModel.data.addressInfo.inputFields;

    for (int i = 0; i < data.length; i += 1) {
      inputBody[data[i].name] = inputFieldControllers[i].text;
    }

    await addMoneyTatumConfirmApi(
            body: inputBody,
            url: _addMoneyTatumModel.data.addressInfo.submitUrl)
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

// add money paypal process
  late AddMoneyPaypalModel _addMoneyPaypalModel;
  AddMoneyPaypalModel get addMoneyPaypalModel => _addMoneyPaypalModel;

  Future<AddMoneyPaypalModel> onPaypalProcess() async {
    _isSubmitLoading.value = true;
    update();

    Map<String, dynamic> inputBody = {
      'amount': amountController.text,
      'sender_currency': selectedCurrency.value,
      'gateway_currency': selectedMethodAlias.value,
    };

    await addMoneySubmitPaypalApi(body: inputBody).then((value) async {
      _addMoneyPaypalModel = value!;

      debugPrint(_addMoneyPaypalModel.data.url.toString());

      update();
    }).catchError((onError) {
      log.e(onError);
    });
    _isSubmitLoading.value = false;
    update();
    return _addMoneyPaypalModel;
  }

// manual add money process
  late AddMoneyManualModel _addMoneyManualModel;
  AddMoneyManualModel get addMoneyManualModel => _addMoneyManualModel;

  Future<AddMoneyManualModel> onManualProcess() async {
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

    await addMoneySubmitManualApi(body: inputBody).then((value) async {
      _addMoneyManualModel = value!;

      final data = _addMoneyManualModel.data.inputFields;
      _getDynamicInputField(data);
      information = value.data.paymentInformations;
      Get.toNamed(Routes.addMoneyScreenPreview);

      _isSubmitLoading.value = false;
      update();
    }).catchError((onError) {
      log.e(onError);
    });
    _isSubmitLoading.value = false;
    update();
    return _addMoneyManualModel;
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

  /// >>> set and get model for kyc submit
  late CommonSuccessModel _commonSuccessModel;
  CommonSuccessModel get commonSuccessModel => _commonSuccessModel;

  ///* manual submit submit api process
  Future<CommonSuccessModel> manualSubmitApiProcess() async {
    _isLoading.value = true;
    Map<String, String> inputBody = {
      "track": _addMoneyManualModel.data.paymentInformations.trx
    };

    final data = addMoneyManualModel.data.inputFields;

    for (int i = 0; i < data.length; i += 1) {
      if (data[i].type != 'file') {
        inputBody[data[i].name] = inputFieldControllers[i].text;
      }
    }

    await addMoneyManualConfirmApi(
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
