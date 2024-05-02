import '../../language/language_controller.dart';
import '../models/common/common_success_model.dart';
import '../models/dashboard/profile_model.dart';
import 'api_endpoint.dart';
import '../backend_utils/api_method.dart';
import '../backend_utils/custom_snackbar.dart';
import '../backend_utils/logger.dart';

final log = logger(ProfileApiService);

mixin ProfileApiService {

  //! profile get
  Future<ProfileModel?> profileApi() async {
    Map<String, dynamic>? mapResponse;
    try {
      mapResponse = await ApiMethod(isBasic: false).get(
        "${ApiEndpoint.profileURL}?lang=${languageSettingsController.selectedLanguage.value}",
        code: 200,
        duration: 15,
        showResult: true,
      );
      if (mapResponse != null) {
        ProfileModel profileModel = ProfileModel.fromJson(mapResponse);
        // CustomSnackBar.success(profileModel.message.success.first.toString());
        return profileModel;
      }
    } catch (e) {
      log.e('🐞🐞🐞 err from profile api service ==> $e 🐞🐞🐞');
      CustomSnackBar.error('Something went Wrong! in Profile Model.');
      return null;
    }
    return null;
  }

  //! profile switch
  Future<CommonSuccessModel?> profileSwitchApi() async {
    Map<String, dynamic>? mapResponse;
    try {
      mapResponse = await ApiMethod(isBasic: false).get(
        "${ApiEndpoint.profileTypeUpdateURL}?lang=${languageSettingsController.selectedLanguage.value}",
        code: 200,
        duration: 15,
        showResult: true,
      );
      if (mapResponse != null) {
        CommonSuccessModel model = CommonSuccessModel.fromJson(mapResponse);
        CustomSnackBar.success(model.message!.success!.first.toString());
        return model;
      }
    } catch (e) {
      log.e('🐞🐞🐞 err from profile switch api service ==> $e 🐞🐞🐞');
      CustomSnackBar.error('Something went Wrong! in Profile Switch Model.');
      return null;
    }
    return null;
  }

// !  profile update Api method no image
  Future<CommonSuccessModel?> updateProfileWithoutImageApi(
      {required Map<String, dynamic> body}) async {
    Map<String, dynamic>? mapResponse;
    try {
      mapResponse = await ApiMethod(isBasic: false)
          .post("${ApiEndpoint.profileUpdateURL}?lang=${languageSettingsController.selectedLanguage.value}", body, code: 200);
      if (mapResponse != null) {
        CommonSuccessModel updateProfileModel =
            CommonSuccessModel.fromJson(mapResponse);
        CustomSnackBar.success(
            updateProfileModel.message!.success!.first.toString());
        return updateProfileModel;
      }
    } catch (e) {
      log.e('err from profile update api service ==> $e');
      CustomSnackBar.error('Something went Wrong!');
      return null;
    }
    return null;
  }

  //! profile update api
  Future<CommonSuccessModel?> updateProfileWithImageApi(
      {required Map<String, String> body, required String filepath}) async {
    Map<String, dynamic>? mapResponse;
    try {
      mapResponse = await ApiMethod(isBasic: false).multipart(
        "${ApiEndpoint.profileUpdateURL}?lang=${languageSettingsController.selectedLanguage.value}",
        body,
        filepath,
        'image',
        code: 200,
      );

      if (mapResponse != null) {
        CommonSuccessModel profileUpdateModel =
            CommonSuccessModel.fromJson(mapResponse);
        CustomSnackBar.success(
            profileUpdateModel.message!.success!.first.toString());
        return profileUpdateModel;
      }
    } catch (e) {
      log.e('err from profile update api service ==> $e');
      CustomSnackBar.error('Something went Wrong!');
      return null;
    }
    return null;
  }

}