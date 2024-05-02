import 'dart:io';

import 'package:adescrow_app/backend/models/common/common_success_model.dart';
import 'package:adescrow_app/utils/basic_screen_imports.dart';

import '../../../backend/backend_utils/logger.dart';
import '../../../backend/models/tatum/tatum_model.dart' as tatum;
import '../../../backend/models/escrow/buyer_payment_index_model.dart';
import '../../../backend/models/escrow/escrow_automatic_payment_model.dart';
import '../../../backend/models/escrow/escrow_create_model.dart';
import '../../../backend/models/escrow/escrow_manual_payment_model.dart';
import '../../../backend/models/escrow/escrow_paypal_payment_model.dart';
import '../../../backend/services/buyer_payment_api_service.dart';
import '../../../routes/routes.dart';
import '../../../views/confirm_screen.dart';
import '../../../views/web_view/web_view_screen.dart';
import '../../../widgets/custom_dropdown_widget/custom_dropdown_widget.dart';
import '../../../widgets/others/custom_upload_file_widget.dart';
import '../../auth/kyc_form_controller.dart';
import '../btm_navs_controller/my_escrow_controller.dart';

final log = logger(BuyerPaymentController);

class BuyerPaymentController extends GetxController
    with BuyerPaymentApiService {
  final formKey = GlobalKey<FormState>();
  final formManualKey = GlobalKey<FormState>();

  final selectedPaymentMethod = "".obs;
  final selectedPaymentMethodAlias = "".obs;
  final selectedPaymentMethodId = "".obs;
  final selectedPaymentMethodTypeId = "".obs;
  final selectedPaymentMethodType = "".obs;
  List<GatewayCurrency> selectedPaymentList = [];

  ///  ---------------- fetch and submit and confirm apis
  @override
  void onInit() {
    buyerPaymentIndexFetch();
    super.onInit();
  }

  final _isLoading = false.obs;
  bool get isLoading => _isLoading.value;

  final _isSubmitLoading = false.obs;
  bool get isSubmitLoading => _isSubmitLoading.value;

  // fetch info
  late BuyerPaymentIndexModel _buyerPaymentIndexModel;
  BuyerPaymentIndexModel get buyerPaymentIndexModel => _buyerPaymentIndexModel;

  Future<BuyerPaymentIndexModel> buyerPaymentIndexFetch() async {
    _isLoading.value = true;
    update();

    await buyerPaymentIndexAPi(
            Get.find<MyEscrowController>().escrowData.id.toString())
        .then((value) {
      _buyerPaymentIndexModel = value!;

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

      for (var element in _buyerPaymentIndexModel.data.gatewayCurrencies) {
        selectedPaymentList.add(element);
      }

      update();
    }).catchError((onError) {
      log.e(onError);
    });

    _isLoading.value = false;
    update();

    return _buyerPaymentIndexModel;
  }

  /// -------------- confirm and payment apis ---------
  void onConfirmProcess(BuildContext context) async {
    if (selectedPaymentMethod.value.isEmpty) {
      buyerPaymentConfirm().then((value) => Navigator.push(
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
  }

  _onPayment(BuildContext context) async {
    /// for automatic payment
    if (selectedPaymentMethodType.value == "AUTOMATIC") {
      if (selectedPaymentMethodAlias.value.contains("tatum")) {
        await buyerPaymentTatumPayment();
      } else if (selectedPaymentMethodTypeId.value == "1") {
        await buyerPaymentPaypal(context);
      } else {
        await buyerPaymentAutomatic(context);
      }
    }

    /// for manual payment
    else if (selectedPaymentMethodType.value == "MANUAL") {
      await buyerPaymentManualPayment();
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
                                        Strings.addNewEscrowConfirmationMSG,
                                    // onApproval: true,
                                    onOkayTap: () =>
                                        Get.offAllNamed(Routes.dashboardScreen),
                                  )));
                    }
                  },
                )));
    debugPrint("Success");
  }

  late CommonSuccessModel _commonSuccessModel;
  CommonSuccessModel get commonSuccessModel => _commonSuccessModel;

  late EscrowPaypalPaymentModel _buyerPaymentPaypalPaymentModel;
  EscrowPaypalPaymentModel get buyerPaymentPaypalPaymentModel =>
      _buyerPaymentPaypalPaymentModel;

  late EscrowAutomaticPaymentModel _buyerPaymentAutomaticPaymentModel;
  EscrowAutomaticPaymentModel get buyerPaymentAutomaticPaymentModel =>
      _buyerPaymentAutomaticPaymentModel;

  late tatum.TatumModel _buyerPaymentTatumPaymentModel;
  tatum.TatumModel get buyerPaymentTatumPaymentModel =>
      _buyerPaymentTatumPaymentModel;

  late EscrowManualPaymentModel _buyerPaymentManualPaymentModel;
  EscrowManualPaymentModel get buyerPaymentManualPaymentModel =>
      _buyerPaymentManualPaymentModel;

  Future<CommonSuccessModel> buyerPaymentConfirm() async {
    _isSubmitLoading.value = true;
    update();

    Map<String, String> inputBody = {"payment_gateway": "myWallet"};

    await buyerPaymentConfirmApi(
            buyerPaymentIndexModel.data.escrowInformation.id.toString(),
            body: inputBody)
        .then((value) {
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

  Future<EscrowPaypalPaymentModel?> buyerPaymentPaypal(
      BuildContext context) async {
    _isSubmitLoading.value = true;
    update();

    Map<String, String> inputBody = {
      "payment_gateway": selectedPaymentMethodId.value,
    };

    await buyerPaymentPaypalApi(
            buyerPaymentIndexModel.data.escrowInformation.id.toString(),
            body: inputBody)
        .then((value) {
      _buyerPaymentPaypalPaymentModel = value!;

      _webPayment(context,
          webUrl: _buyerPaymentPaypalPaymentModel.data.url[1].href,
          title: selectedPaymentMethod.value);
      _isSubmitLoading.value = false;
      update();
    }).catchError((onError) {
      log.e(onError);
    });

    _isSubmitLoading.value = false;
    update();
    return _buyerPaymentPaypalPaymentModel;
  }

  Future<EscrowAutomaticPaymentModel?> buyerPaymentAutomatic(
      BuildContext context) async {
    _isSubmitLoading.value = true;
    update();

    Map<String, String> inputBody = {
      "payment_gateway": selectedPaymentMethodId.value,
    };

    await buyerPaymentAutomaticApi(
            buyerPaymentIndexModel.data.escrowInformation.id.toString(),
            body: inputBody)
        .then((value) {
      _buyerPaymentAutomaticPaymentModel = value!;
      _webPayment(context,
          webUrl: _buyerPaymentAutomaticPaymentModel.data.url,
          title: selectedPaymentMethod.value);
      _isSubmitLoading.value = false;
      update();
    }).catchError((onError) {
      log.e(onError);
    });

    _isSubmitLoading.value = false;
    update();
    return _buyerPaymentAutomaticPaymentModel;
  }

  /// for tatum payment
  Future<tatum.TatumModel?> buyerPaymentTatumPayment() async {
    inputFields.clear();
    inputFieldControllers.clear();
    update();

    _isSubmitLoading.value = true;
    update();

    Map<String, String> inputBody = {
      "payment_gateway": selectedPaymentMethodId.value,
    };

    await buyerPaymentTatumApi(
        buyerPaymentIndexModel.data.escrowInformation.id.toString(),
        body: inputBody)
        .then((value) {
      _buyerPaymentTatumPaymentModel = value!;
      var data = _buyerPaymentTatumPaymentModel.data.addressInfo.inputFields;

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


      Get.toNamed(Routes.buyerPaymentTatumScreen);
      _isSubmitLoading.value = false;
      update();
    }).catchError((onError) {
      log.e(onError);
    });

    _isSubmitLoading.value = false;
    update();
    return _buyerPaymentTatumPaymentModel;
  }


  /// for manual payment
  Future<EscrowManualPaymentModel?> buyerPaymentManualPayment() async {
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
      "payment_gateway": selectedPaymentMethodId.value,
    };

    await buyerPaymentManualApi(
            buyerPaymentIndexModel.data.escrowInformation.id.toString(),
            body: inputBody)
        .then((value) {
      _buyerPaymentManualPaymentModel = value!;
      _getDynamicInputField(_buyerPaymentManualPaymentModel.data.inputFields);

      Get.toNamed(Routes.buyerPaymentManualScreen);
      _isSubmitLoading.value = false;
      update();
    }).catchError((onError) {
      log.e(onError);
    });

    _isSubmitLoading.value = false;
    update();
    return _buyerPaymentManualPaymentModel;
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
      "trx": _buyerPaymentManualPaymentModel.data.paymentInformations.trx,
    };

    final data = _buyerPaymentManualPaymentModel.data.inputFields;

    for (int i = 0; i < data.length; i += 1) {
      if (data[i].type != 'file') {
        inputBody[data[i].name] = inputFieldControllers[i].text;
      }
    }

    await buyerPaymentManualSubmitApi(
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


  ///* tatum submit api process
  Future<CommonSuccessModel> tatumSubmitApiProcess() async {
    _isLoading.value = true;
    Map<String, String> inputBody = {};

    final data = _buyerPaymentTatumPaymentModel.data.addressInfo.inputFields;

    for (int i = 0; i < data.length; i += 1) {
        inputBody[data[i].name] = inputFieldControllers[i].text;
    }

    await buyerPaymentTatumSubmitApi(
        body: inputBody, url: _buyerPaymentTatumPaymentModel.data.addressInfo.submitUrl)
        .then((value) {
      _commonSuccessModel = value!;

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
