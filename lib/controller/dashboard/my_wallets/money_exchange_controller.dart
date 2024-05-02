import 'package:adescrow_app/utils/basic_screen_imports.dart';

import '../../../backend/backend_utils/custom_snackbar.dart';
import '../../../backend/backend_utils/logger.dart';
import '../../../backend/models/common/common_success_model.dart';
import '../../../backend/models/money_exchange/money_exchange_index_model.dart';
import '../../../backend/services/money_exchange_api_service.dart';
import '../../../routes/routes.dart';
import '../../../views/confirm_screen.dart';

final log = logger(MoneyExchangeController);

class MoneyExchangeController extends GetxController with MoneyExchangeApiService{

  final fromAmountController = TextEditingController();
  final toAmountController = TextEditingController();

  final fromSelectedCurrency = "".obs;
  final fromSelectedCurrencyType = "".obs;
  final fromSelectedCurrencyRate = 0.0.obs;

  final toSelectedCurrency = "--".obs;
  final toSelectedCurrencyType = "".obs;
  final toSelectedCurrencyRate = 0.0.obs;

  final exchangeRate = 0.0.obs;
  final min = 0.0.obs;
  final max = 0.0.obs;

  final pCharge = 0.0.obs;
  final fCharge = 0.0.obs;
  final tCharge = 0.0.obs;

  void calculateExchangeRate(){
    exchangeRate.value = toSelectedCurrencyRate.value / fromSelectedCurrencyRate.value;
    min.value = fromSelectedCurrencyRate.value * moneyExchangeModel.data.charges.minLimit;
    max.value = fromSelectedCurrencyRate.value * moneyExchangeModel.data.charges.maxLimit;

    fCharge.value = moneyExchangeModel.data.charges.fixedCharge * fromSelectedCurrencyRate.value;

    if(fromAmountController.text.isNotEmpty){
      double amount = double.parse(fromAmountController.text);
      toAmountController.text = ( amount * exchangeRate.value).toStringAsFixed(toSelectedCurrencyType.value == "FIAT" ? 2 : 6);
      pCharge.value = (amount / 100) * moneyExchangeModel.data.charges.percentCharge;
      tCharge.value = pCharge.value + fCharge.value;
    }else{
      tCharge.value = 0 + fCharge.value;
      toAmountController.clear();
    }
  }

  @override
  dispose(){
    super.dispose();
    fromAmountController.dispose();
    toAmountController.dispose();

  }

  onConfirmProcess(BuildContext context) async{

    await submitProcess().then((value) {
      if(value != null){
        Navigator.push(context, MaterialPageRoute(builder: (context) => ConfirmScreen(
          message: Strings.exchangeConfirmationMSG,
          onApproval: true,
          onOkayTap: ()=> Get.offAllNamed(Routes.dashboardScreen),
        )));
      }
    });


  }

  onExchangeBTNProcess(BuildContext context) {
    if(fromAmountController.text.isNotEmpty) {
      double amount = double.parse(fromAmountController.text);
      if(amount.isGreaterThan(max.value) || amount.isLowerThan(min.value)){
        CustomSnackBar.error(Strings.limitMSG);
      }else {
        Get.toNamed(Routes.moneyExchangeScreenPreview);
      }
    }else{
      CustomSnackBar.error(Strings.enterAmount);
    }
  }



  @override
  void onInit() {
    moneyExchangeFetch();
    super.onInit();
  }

  final _isLoading = false.obs;
  bool get isLoading => _isLoading.value;

  late MoneyExchangeIndexModel _moneyExchangeModel;
  MoneyExchangeIndexModel get moneyExchangeModel => _moneyExchangeModel;

  Future<MoneyExchangeIndexModel> moneyExchangeFetch() async {
    _isLoading.value = true;
    update();

    await moneyExchangeInfoAPi().then((value) {
      _moneyExchangeModel = value!;

      var data = _moneyExchangeModel.data.userWallet.first;

      fromSelectedCurrency.value = data.currencyCode;
      fromSelectedCurrencyType.value = data.currencyType;

      toSelectedCurrency.value = data.currencyCode;
      toSelectedCurrencyType.value = data.currencyType;

      fromSelectedCurrencyRate.value = data.rate;
      toSelectedCurrencyRate.value = data.rate;

      calculateExchangeRate();

      update();
    }).catchError((onError) {
      log.e(onError);
    });

    _isLoading.value = false;
    update();

    return _moneyExchangeModel;
  }



  late CommonSuccessModel? _successModel;
  CommonSuccessModel? get successModel => _successModel;

  Future<CommonSuccessModel?> submitProcess() async {
    _isLoading.value = true;
    update();

    Map<String, dynamic> inputBody = {
      'exchange_from_amount': fromAmountController.text,
      'exchange_from_currency': fromSelectedCurrency.value,
      'exchange_to_currency': toSelectedCurrency.value
    };

    await moneyExchangeSubmitApi(body: inputBody).then((value) async {
      _successModel = value;

      _isLoading.value = false;
      update();
      update();
    }).catchError((onError) {
      log.e(onError);
    });

    _isLoading.value = false;
    update();
    return _successModel;
  }
}