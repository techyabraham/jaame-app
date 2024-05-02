import '../../language/language_controller.dart';
import '../backend_utils/api_method.dart';
import '../backend_utils/custom_snackbar.dart';
import '../backend_utils/logger.dart';
import '../models/tatum/tatum_model.dart';
import '../models/common/common_success_model.dart';
import '../models/escrow/buyer_payment_index_model.dart';
import '../models/escrow/escrow_automatic_payment_model.dart';
import '../models/escrow/escrow_manual_payment_model.dart';
import '../models/escrow/escrow_paypal_payment_model.dart';
import 'api_endpoint.dart';

final log = logger(BuyerPaymentApiService);

mixin BuyerPaymentApiService {
  // escrow fetch
  Future<BuyerPaymentIndexModel?> buyerPaymentIndexAPi(String id) async {
    Map<String, dynamic>? mapResponse;
    try {
      mapResponse = await ApiMethod(isBasic: false).get(
        "${ApiEndpoint.buyerPaymentIndexURL}$id?lang=${languageSettingsController.selectedLanguage.value}",
        code: 200,
        showResult: false,
      );
      if (mapResponse != null) {
        BuyerPaymentIndexModel modelData = BuyerPaymentIndexModel.fromJson(mapResponse);

        return modelData;
      }
    } catch (e) {
      log.e('🐞🐞🐞 err from Buyer Escrow Index Model api service ==> $e 🐞🐞🐞');
      CustomSnackBar.error('Something went Wrong!');
      return null;
    }
    return null;
  }


  // escrow confirm for seller and from wallet
  Future<CommonSuccessModel?> buyerPaymentConfirmApi(String id,
      {required Map<String, dynamic> body}) async {
    Map<String, dynamic>? mapResponse;
    try {
      mapResponse = await ApiMethod(isBasic: false).post(
        "${ApiEndpoint.buyerPaymentSubmitURL}$id?lang=${languageSettingsController.selectedLanguage.value}",
        body,
        code: 200,
        duration: 15,
        showResult: true,
      );
      if (mapResponse != null) {
        CommonSuccessModel escrowSubmitModel =
        CommonSuccessModel.fromJson(mapResponse);

        return escrowSubmitModel;
      }
    } catch (e) {
      log.e('🐞🐞🐞 err from escrow confirm api service ==> $e 🐞🐞🐞');
      CustomSnackBar.error('Something went Wrong!');
      return null;
    }
    return null;
  }


  // escrow confirm for paypal
  Future<EscrowPaypalPaymentModel?> buyerPaymentPaypalApi(String id,
      {required Map<String, dynamic> body}) async {
    Map<String, dynamic>? mapResponse;
    try {
      mapResponse = await ApiMethod(isBasic: false).post(
        "${ApiEndpoint.buyerPaymentSubmitURL}$id?lang=${languageSettingsController.selectedLanguage.value}",
        body,
        code: 200,
        duration: 15,
        showResult: true,
      );
      if (mapResponse != null) {
        EscrowPaypalPaymentModel escrowSubmitModel =
        EscrowPaypalPaymentModel.fromJson(mapResponse);

        return escrowSubmitModel;
      }
    } catch (e) {
      log.e('🐞🐞🐞 err from escrow paypal api service ==> $e 🐞🐞🐞');
      CustomSnackBar.error('Something went Wrong!');
      return null;
    }
    return null;
  }

  // escrow confirm for automatic
  Future<EscrowAutomaticPaymentModel?> buyerPaymentAutomaticApi(String id,
      {required Map<String, dynamic> body}) async {
    Map<String, dynamic>? mapResponse;
    try {
      mapResponse = await ApiMethod(isBasic: false).post(
        "${ApiEndpoint.buyerPaymentSubmitURL}$id?lang=${languageSettingsController.selectedLanguage.value}",
        body,
        code: 200,
        duration: 15,
        showResult: true,
      );
      if (mapResponse != null) {
        EscrowAutomaticPaymentModel escrowSubmitModel =
        EscrowAutomaticPaymentModel.fromJson(mapResponse);

        return escrowSubmitModel;
      }
    } catch (e) {
      log.e('🐞🐞🐞 err from escrow automatic api service ==> $e 🐞🐞🐞');
      CustomSnackBar.error('Something went Wrong!');
      return null;
    }
    return null;
  }


  // escrow confirm for manual
  Future<TatumModel?> buyerPaymentTatumApi(String id,
      {required Map<String, dynamic> body}) async {
    Map<String, dynamic>? mapResponse;
    try {
      mapResponse = await ApiMethod(isBasic: false).post(
        "${ApiEndpoint.buyerPaymentSubmitURL}$id?lang=${languageSettingsController.selectedLanguage.value}",
        body,
        code: 200,
        duration: 15,
        showResult: true,
      );
      if (mapResponse != null) {
        TatumModel modelData =
        TatumModel.fromJson(mapResponse);

        return modelData;
      }
    } catch (e) {
      log.e('🐞🐞🐞 err from escrow automatic api service ==> $e 🐞🐞🐞');
      CustomSnackBar.error('Something went Wrong!');
      return null;
    }
    return null;
  }


  // escrow confirm for tatum
  Future<CommonSuccessModel?> buyerPaymentTatumSubmitApi({
    required Map<String, String> body,
    required String url,
  }) async {

    Map<String, dynamic>? mapResponse;
    try {
      mapResponse = await ApiMethod(isBasic: false).post(
          "$url?lang=${languageSettingsController.selectedLanguage.value}~",
          body,
          code: 200
      );
      if (mapResponse != null) {
        CommonSuccessModel result = CommonSuccessModel.fromJson(mapResponse);
        return result;
      }
    } catch (e) {
      log.e('🐞🐞🐞 err from add money tatum confirm api service ==> $e 🐞🐞🐞');
      CustomSnackBar.error('Something went Wrong!');
      return null;
    }
    return null;
  }

  // escrow confirm for manual
  Future<EscrowManualPaymentModel?> buyerPaymentManualApi(String id,
      {required Map<String, dynamic> body}) async {
    Map<String, dynamic>? mapResponse;
    try {
      mapResponse = await ApiMethod(isBasic: false).post(
        "${ApiEndpoint.buyerPaymentSubmitURL}$id?lang=${languageSettingsController.selectedLanguage.value}",
        body,
        code: 200,
        duration: 15,
        showResult: true,
      );
      if (mapResponse != null) {
        EscrowManualPaymentModel modelData =
        EscrowManualPaymentModel.fromJson(mapResponse);

        return modelData;
      }
    } catch (e) {
      log.e('🐞🐞🐞 err from escrow automatic api service ==> $e 🐞🐞🐞');
      CustomSnackBar.error('Something went Wrong!');
      return null;
    }
    return null;
  }


  ///* escrow manual submit process api todo
  Future<CommonSuccessModel?> buyerPaymentManualSubmitApi({
    required Map<String, String> body,
    required List<String> pathList,
    required List<String> fieldList,
  }) async {

    Map<String, dynamic>? mapResponse;
    try {
      mapResponse = await ApiMethod(isBasic: false).multipartMultiFile(
        "${ApiEndpoint.buyerPaymentManualConfirmURL}?lang=${languageSettingsController.selectedLanguage.value}",
        body,
        code: 200,
        fieldList: fieldList,
        pathList: pathList,
      );
      if (mapResponse != null) {
        CommonSuccessModel result = CommonSuccessModel.fromJson(mapResponse);

        return result;
      }
    } catch (e) {
      log.e('🐞🐞🐞 err from escrow manual submit process api service ==> $e 🐞🐞🐞');
      CustomSnackBar.error('Something went Wrong!');
      return null;
    }
    return null;
  }
}
