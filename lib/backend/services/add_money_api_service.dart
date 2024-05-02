import '../../language/language_controller.dart';
import '../models/add_money/add_money_automatic_model.dart';
import '../models/add_money/add_money_manual_model.dart';
import '../models/add_money/add_money_paypal_model.dart';
import '../models/tatum/tatum_model.dart';
import 'api_endpoint.dart';
import '../backend_utils/api_method.dart';
import '../backend_utils/custom_snackbar.dart';
import '../backend_utils/logger.dart';

import '../models/add_money/add_money_index_model.dart';
import '../models/common/common_success_model.dart';

final log = logger(AddMoneyApiService);

mixin AddMoneyApiService {

  Future<AddMoneyIndexModel?> addMoneyIndexAPi() async {
    Map<String, dynamic>? mapResponse;
    try {
      mapResponse = await ApiMethod(isBasic: false).get(
        "${ApiEndpoint.addMoneyIndexURL}?lang=${languageSettingsController.selectedLanguage.value}",
        code: 200,
        showResult: false,
      );
      if (mapResponse != null) {
        AddMoneyIndexModel modelData = AddMoneyIndexModel.fromJson(mapResponse);

        return modelData;
      }
    } catch (e) {
      log.e('🐞🐞🐞 err from Add Money Index Model api service ==> $e 🐞🐞🐞');
      CustomSnackBar.error('Something went Wrong!');
      return null;
    }
    return null;
  }

  Future<AddMoneyAutomaticModel?> addMoneySubmitAutomaticApi(
      {required Map<String, dynamic> body}) async {
    Map<String, dynamic>? mapResponse;
    try {
      mapResponse = await ApiMethod(isBasic: false).post(
        "${ApiEndpoint.addMoneySubmitURL}?lang=${languageSettingsController.selectedLanguage.value}",
        body,
        code: 200,
        duration: 15,
        showResult: true,
      );
      if (mapResponse != null) {
        AddMoneyAutomaticModel modelData =
        AddMoneyAutomaticModel.fromJson(mapResponse);

        // CustomSnackBar.success(
        //     commonSuccessModel.message!.success!.first.toString());
        return modelData;
      }
    } catch (e) {
      log.e('🐞🐞🐞 err from add money submit api service ==> $e 🐞🐞🐞');
      CustomSnackBar.error('Something went Wrong!');
      return null;
    }
    return null;
  }

  Future<TatumModel?> addMoneySubmitTatumApi(
      {required Map<String, dynamic> body, String? escrocId}) async {
    Map<String, dynamic>? mapResponse;
    try {
      mapResponse = await ApiMethod(isBasic: false).post(
        escrocId == null
            ? "${ApiEndpoint.addMoneyTatumURL}/$escrocId?lang=${languageSettingsController.selectedLanguage.value}"
            : "${ApiEndpoint.addMoneySubmitURL}?lang=${languageSettingsController.selectedLanguage.value}",
        body,
        code: 200,
        duration: 15,
        showResult: true,
      );
      if (mapResponse != null) {
        TatumModel modelData =
        TatumModel.fromJson(mapResponse);

        // CustomSnackBar.success(
        //     commonSuccessModel.message!.success!.first.toString());
        return modelData;
      }
    } catch (e) {
      log.e('🐞🐞🐞 err from add money submit api service ==> $e 🐞🐞🐞');
      CustomSnackBar.error('Something went Wrong!');
      return null;
    }
    return null;
  }

  Future<CommonSuccessModel?> addMoneyTatumConfirmApi({
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

  Future<AddMoneyPaypalModel?> addMoneySubmitPaypalApi(
      {required Map<String, dynamic> body}) async {
    Map<String, dynamic>? mapResponse;
    try {
      mapResponse = await ApiMethod(isBasic: false).post(
        "${ApiEndpoint.addMoneySubmitURL}?lang=${languageSettingsController.selectedLanguage.value}",
        body,
        code: 200,
        duration: 15,
        showResult: true,
      );
      if (mapResponse != null) {
        AddMoneyPaypalModel modelData =
        AddMoneyPaypalModel.fromJson(mapResponse);

        // CustomSnackBar.success(
        //     commonSuccessModel.message!.success!.first.toString());
        return modelData;
      }
    } catch (e) {
      log.e('🐞🐞🐞 err from add money submit api service ==> $e 🐞🐞🐞');
      CustomSnackBar.error('Something went Wrong!');
      return null;
    }
    return null;
  }


  Future<AddMoneyManualModel?> addMoneySubmitManualApi(
      {required Map<String, dynamic> body}) async {
    Map<String, dynamic>? mapResponse;
    try {
      mapResponse = await ApiMethod(isBasic: false).post(
        "${ApiEndpoint.addMoneySubmitURL}?lang=${languageSettingsController.selectedLanguage.value}",
        body,
        code: 200,
        duration: 15,
        showResult: true,
      );
      if (mapResponse != null) {
        AddMoneyManualModel modelData =
        AddMoneyManualModel.fromJson(mapResponse);

        // CustomSnackBar.success(
        //     commonSuccessModel.message!.success!.first.toString());
        return modelData;
      }
    } catch (e) {
      log.e('🐞🐞🐞 err from add money submit api service ==> $e 🐞🐞🐞');
      CustomSnackBar.error('Something went Wrong!');
      return null;
    }
    return null;
  }


  Future<CommonSuccessModel?> addMoneyManualConfirmApi({
    required Map<String, String> body,
    required List<String> pathList,
    required List<String> fieldList,
  }) async {

    Map<String, dynamic>? mapResponse;
    try {
      mapResponse = await ApiMethod(isBasic: false).multipartMultiFile(
        "${ApiEndpoint.addMoneyManualConfirmURL}?lang=${languageSettingsController.selectedLanguage.value}~",
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
      log.e('🐞🐞🐞 err from add money manual confirm api service ==> $e 🐞🐞🐞');
      CustomSnackBar.error('Something went Wrong!');
      return null;
    }
    return null;
  }
}
