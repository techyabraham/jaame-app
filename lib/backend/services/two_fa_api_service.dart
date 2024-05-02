import '../../language/language_controller.dart';
import '../backend_utils/api_method.dart';
import '../backend_utils/custom_snackbar.dart';
import '../backend_utils/logger.dart';
import '../models/common/common_success_model.dart';
import '../models/dashboard/two_fa_info_model.dart';
import 'api_endpoint.dart';

final log = logger(TwoFaApiService);

mixin TwoFaApiService {
  Future<TwoFaInfoModel?> twoFaInfoAPi() async {
    Map<String, dynamic>? mapResponse;
    try {
      mapResponse = await ApiMethod(isBasic: false).get(
        "${ApiEndpoint.faFetchURL}?lang=${languageSettingsController.selectedLanguage.value}",
        code: 200,
        showResult: false,
      );
      if (mapResponse != null) {
        TwoFaInfoModel modelData = TwoFaInfoModel.fromJson(mapResponse);

        return modelData;
      }
    } catch (e) {
      log.e('🐞🐞🐞 err from Two FA Info Model api service ==> $e 🐞🐞🐞');
      CustomSnackBar.error('Something went Wrong!');
      return null;
    }
    return null;
  }

  Future<CommonSuccessModel?> twoFaStatusUpdateApi(
      {required Map<String, dynamic> body}) async {
    Map<String, dynamic>? mapResponse;
    try {
      mapResponse = await ApiMethod(isBasic: false).post(
        "${ApiEndpoint.faStatusUpdateURL}?lang=${languageSettingsController.selectedLanguage.value}",
        body,
        code: 200,
        duration: 15,
        showResult: true,
      );
      if (mapResponse != null) {
        CommonSuccessModel commonSuccessModel =
            CommonSuccessModel.fromJson(mapResponse);

        CustomSnackBar.success(
            commonSuccessModel.message!.success!.first.toString());
        return commonSuccessModel;
      }
    } catch (e) {
      log.e('🐞🐞🐞 err from two fa status update api service ==> $e 🐞🐞🐞');
      CustomSnackBar.error('Something went Wrong!');
      return null;
    }
    return null;
  }


  Future<CommonSuccessModel?> twoFaVerifyApi(
      {required Map<String, dynamic> body}) async {
    Map<String, dynamic>? mapResponse;
    try {
      mapResponse = await ApiMethod(isBasic: false).post(
        "${ApiEndpoint.faVerifyURL}?lang=${languageSettingsController.selectedLanguage.value}",
        body,
        code: 200,
        duration: 15,
        showResult: true,
      );
      if (mapResponse != null) {
        CommonSuccessModel commonSuccessModel =
            CommonSuccessModel.fromJson(mapResponse);

        // CustomSnackBar.success(
        //     commonSuccessModel.message!.success!.first.toString());
        return commonSuccessModel;
      }
    } catch (e) {
      log.e('🐞🐞🐞 err from two fa status update api service ==> $e 🐞🐞🐞');
      CustomSnackBar.error('Something went Wrong!');
      return null;
    }
    return null;
  }
}
