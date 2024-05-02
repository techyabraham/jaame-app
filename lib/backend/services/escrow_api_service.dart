import '../../language/language_controller.dart';
import '../../utils/basic_screen_imports.dart';
import '../backend_utils/api_method.dart';
import '../backend_utils/custom_snackbar.dart';
import '../backend_utils/logger.dart';
import '../models/tatum/tatum_model.dart';
import '../models/common/common_success_model.dart';
import '../models/escrow/escrow_automatic_payment_model.dart';
import '../models/escrow/escrow_create_model.dart';
import '../models/escrow/escrow_index_model.dart';
import '../models/escrow/escrow_manual_payment_model.dart';
import '../models/escrow/escrow_paypal_payment_model.dart';
import '../models/escrow/escrow_submit_model.dart';
import '../models/escrow/user_check_model.dart';
import 'api_endpoint.dart';

final log = logger(EscrowApiService);

mixin EscrowApiService {

  // escrow fetch
  Future<EscrowIndexModel?> escrowIndexAPi() async {
    Map<String, dynamic>? mapResponse;
    try {
      mapResponse = await ApiMethod(isBasic: false).get(
        "${ApiEndpoint.escrowIndexURL}?lang=${languageSettingsController.selectedLanguage.value}",
        code: 200,
        showResult: false,
      );
      if (mapResponse != null) {
        EscrowIndexModel modelData = EscrowIndexModel.fromJson(mapResponse);

        return modelData;
      }
    } catch (e) {
      log.e('🐞🐞🐞 err from Escrow Index Model api service ==> $e 🐞🐞🐞');
      CustomSnackBar.error('Something went Wrong!');
      return null;
    }
    return null;
  }

  Future<EscrowCreateModel?> escrowCreateAPi() async {
    Map<String, dynamic>? mapResponse;
    try {
      mapResponse = await ApiMethod(isBasic: false).get(
        "${ApiEndpoint.escrowCreateURL}?lang=${languageSettingsController.selectedLanguage.value}",
        code: 200,
        showResult: false,
      );
      if (mapResponse != null) {
        EscrowCreateModel modelData = EscrowCreateModel.fromJson(mapResponse);

        return modelData;
      }
    } catch (e) {
      log.e('🐞🐞🐞 err from Escrow Create Model api service ==> $e 🐞🐞🐞');
      CustomSnackBar.error('Something went Wrong!');
      return null;
    }
    return null;
  }

  // user check
  Future<UserCheckModel?> escrowUserCheckAPi(String user) async {
    Map<String, dynamic>? mapResponse;
    debugPrint("-------");
    debugPrint(user);
    try {
      mapResponse = await ApiMethod(isBasic: false).get(
        "${ApiEndpoint.escrowUserCheckURL}$user&lang=${languageSettingsController.selectedLanguage.value}",
        code: 200,
        showResult: false,
      );
      if (mapResponse != null) {
        UserCheckModel modelData = UserCheckModel.fromJson(mapResponse);

        return modelData;
      }
    } catch (e) {
      log.e('🐞🐞🐞 err from Escrow Index Model api service ==> $e 🐞🐞🐞');
      CustomSnackBar.error('Something went Wrong!');
      return null;
    }
    return null;
  }

  // escrow submit with file and without file
  Future<EscrowSubmitModel?> escrowSubmitWithoutFileApi(
      {required Map<String, dynamic> body}) async {
    Map<String, dynamic>? mapResponse;
    try {
      mapResponse = await ApiMethod(isBasic: false).post(
        "${ApiEndpoint.escrowSubmitURL}?lang=${languageSettingsController.selectedLanguage.value}",
        body,
        code: 200,
        duration: 15,
        showResult: true,
      );
      if (mapResponse != null) {
        EscrowSubmitModel escrowSubmitModel =
        EscrowSubmitModel.fromJson(mapResponse);

        return escrowSubmitModel;
      }
    } catch (e) {
      log.e('🐞🐞🐞 err from escrow submit api service ==> $e 🐞🐞🐞');
      CustomSnackBar.error('Something went Wrong!');
      return null;
    }
    return null;
  }

  Future<EscrowSubmitModel?> escrowSubmitWithFileApi(
      {required Map<String, String> body, required String filePath}) async {
    Map<String, dynamic>? mapResponse;
    try {
      mapResponse = await ApiMethod(isBasic: false).multipart(
        "${ApiEndpoint.escrowSubmitURL}?lang=${languageSettingsController.selectedLanguage.value}",
        body,
        filePath,
        "file[]",
        code: 200,
        showResult: true,
      );
      if (mapResponse != null) {
        EscrowSubmitModel escrowSubmitModel =
        EscrowSubmitModel.fromJson(mapResponse);

        return escrowSubmitModel;
      }
    } catch (e) {
      log.e('🐞🐞🐞 err from escrow submit api service ==> $e 🐞🐞🐞');
      CustomSnackBar.error('Something went Wrong!');
      return null;
    }
    return null;
  }

  // escrow confirm for seller and from wallet
  Future<CommonSuccessModel?> escrowConfirmApi(
      {required Map<String, dynamic> body}) async {
    Map<String, dynamic>? mapResponse;
    try {
      mapResponse = await ApiMethod(isBasic: false).post(
        "${ApiEndpoint.escrowConfirmURL}?lang=${languageSettingsController.selectedLanguage.value}",
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
  Future<EscrowPaypalPaymentModel?> escrowPaypalApi(
      {required Map<String, dynamic> body}) async {
    Map<String, dynamic>? mapResponse;
    try {
      mapResponse = await ApiMethod(isBasic: false).post(
        "${ApiEndpoint.escrowConfirmURL}?lang=${languageSettingsController.selectedLanguage.value}",
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
  Future<EscrowAutomaticPaymentModel?> escrowAutomaticApi(
      {required Map<String, dynamic> body}) async {
    Map<String, dynamic>? mapResponse;
    try {
      mapResponse = await ApiMethod(isBasic: false).post(
        ApiEndpoint.escrowConfirmURL,
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

  // escrow confirm for tatum
  Future<TatumModel?> escrowTatumApi(
      {required Map<String, dynamic> body}) async {
    Map<String, dynamic>? mapResponse;
    try {
      mapResponse = await ApiMethod(isBasic: false).post(
        "${ApiEndpoint.escrowConfirmURL}?lang=${languageSettingsController.selectedLanguage.value}",
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
      log.e('🐞🐞🐞 err from escrow tatum api service ==> $e 🐞🐞🐞');
      CustomSnackBar.error('Something went Wrong!');
      return null;
    }
    return null;
  }

  // escrow confirm for tatum
  Future<CommonSuccessModel?> escrowTatumSubmitApi({
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
  Future<EscrowManualPaymentModel?> escrowManualApi(
      {required Map<String, dynamic> body}) async {
    Map<String, dynamic>? mapResponse;
    try {
      mapResponse = await ApiMethod(isBasic: false).post(
        "${ApiEndpoint.escrowConfirmURL}?lang=${languageSettingsController.selectedLanguage.value}",
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


  ///* escrow manual submit process api
  Future<CommonSuccessModel?> escrowManualSubmitApi({
    required Map<String, String> body,
    required List<String> pathList,
    required List<String> fieldList,
  }) async {

    Map<String, dynamic>? mapResponse;
    try {
      mapResponse = await ApiMethod(isBasic: false).multipartMultiFile(
        "${ApiEndpoint.escrowManualSubmitURL}?lang=${languageSettingsController.selectedLanguage.value}",
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
