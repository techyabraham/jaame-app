import '../../language/language_controller.dart';
import '../backend_utils/api_method.dart';
import '../backend_utils/custom_snackbar.dart';
import '../backend_utils/logger.dart';
import '../models/auth/kyc_model.dart';
import '../models/common/common_success_model.dart';
import 'api_endpoint.dart';

final log = logger(KycApiService);

mixin KycApiService {

  Future<KycModel?> kycFieldAPi() async {
    Map<String, dynamic>? mapResponse;
    try {
      mapResponse = await ApiMethod(isBasic: false).get(
        "${ApiEndpoint.kycFieldsURL}?lang=${languageSettingsController.selectedLanguage.value}",
        code: 200,
        showResult: false,
      );
      if (mapResponse != null) {
        KycModel modelData = KycModel.fromJson(mapResponse);

        return modelData;
      }
    } catch (e) {
      log.e('🐞🐞🐞 err from KYC Model api service ==> $e 🐞🐞🐞');
      CustomSnackBar.error(
          'Something went Wrong!');
      return null;
    }
    return null;
  }


  ///* Kyc submit process api
  Future<CommonSuccessModel?> kycSubmitProcessApi({
    required Map<String, String> body,
    required List<String> pathList,
    required List<String> fieldList,
  }) async {

    Map<String, dynamic>? mapResponse;
    try {
      mapResponse = await ApiMethod(isBasic: false).multipartMultiFile(
        "${ApiEndpoint.kycSubmitURL}?lang=${languageSettingsController.selectedLanguage.value}",
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
      log.e('🐞🐞🐞 err from Kyc submit process api service ==> $e 🐞🐞🐞');
      CustomSnackBar.error('Something went Wrong! in _kycSubmitApiProcess');
      return null;
    }
    return null;
  }
}
