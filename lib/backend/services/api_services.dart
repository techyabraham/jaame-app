import 'package:adescrow_app/backend/models/common/common_success_model.dart';

import '../../language/language_controller.dart';
import '../backend_utils/api_method.dart';
import '../backend_utils/custom_snackbar.dart';
import '../backend_utils/logger.dart';
import '../models/auth/forgot_send_otp_model.dart';
import '../models/auth/login_model.dart';
import '../models/auth/registration_model.dart';
import '../models/basic_settings_model.dart';
import '../models/dashboard/home_model.dart';
import 'api_endpoint.dart';

final log = logger(ApiServices);

class ApiServices {
  // static var client = http.Client();

  ///! basic setting model
  static Future<BasicSettingModel?> basicSettingApi() async {
    Map<String, dynamic>? mapResponse;
    try {
      mapResponse = await ApiMethod(isBasic: true).get(
        ApiEndpoint.appSettingsURL,
        code: 200,
        duration: 25,
        showResult: true,
      );
      if (mapResponse != null) {
        BasicSettingModel basicSettingModel =
            BasicSettingModel.fromJson(mapResponse);
        // CustomSnackBar.success(profileModel.message.success.first.toString());
        return basicSettingModel;
      }
    } catch (e) {
      log.e('🐞🐞🐞 err from  basic api service ==> $e 🐞🐞🐞');
      CustomSnackBar.error('Something went Wrong!  basic api');
      return null;
    }
    return null;
  }

  ///Login Api method
  static Future<LoginModel?> signInApi(
      {required Map<String, dynamic> body}) async {
    Map<String, dynamic>? mapResponse;
    try {
      mapResponse = await ApiMethod(isBasic: true).post(
        "${ApiEndpoint.loginURL}?lang=${languageSettingsController.selectedLanguage.value}",
        body,
        code: 200,
        duration: 15,
        showResult: true,
      );
      if (mapResponse != null) {
        LoginModel loginModel = LoginModel.fromJson(mapResponse);
        // CustomSnackBar.success(loginModel.message.success.first.toString());
        return loginModel;
      }
    } catch (e) {
      log.e('🐞🐞🐞 err from sign in api service ==> $e 🐞🐞🐞');
      CustomSnackBar.error('Something went Wrong! in LoginModel');
      return null;
    }
    return null;
  }

  ///Send OTP Api method
  static Future<ForgetSendOtpModel?> forgotPasswordSendOTPApi(
      {required Map<String, dynamic> body}) async {
    Map<String, dynamic>? mapResponse;
    try {
      mapResponse = await ApiMethod(isBasic: true).post(
        "${ApiEndpoint.forgotSendOTPURL}?lang=${languageSettingsController.selectedLanguage.value}",
        body,
        code: 200,
        duration: 15,
        showResult: true,
      );
      if (mapResponse != null) {
        ForgetSendOtpModel model = ForgetSendOtpModel.fromJson(mapResponse);
        CustomSnackBar.success(model.message.success.first.toString());
        return model;
      }
    } catch (e) {
      log.e('🐞🐞🐞 err from Forget Send Otp api service ==> $e 🐞🐞🐞');
      CustomSnackBar.error('Something went Wrong!');
      return null;
    }
    return null;
  }

  ///Verify OTP Api method
  static Future<CommonSuccessModel?> forgotPasswordVerifyOTPApi(
      {required Map<String, dynamic> body}) async {
    Map<String, dynamic>? mapResponse;
    try {
      mapResponse = await ApiMethod(isBasic: true).post(
        "${ApiEndpoint.forgotVerifyOTPURL}?lang=${languageSettingsController.selectedLanguage.value}",
        body,
        code: 200,
        duration: 15,
        showResult: true,
      );
      if (mapResponse != null) {
        CommonSuccessModel model = CommonSuccessModel.fromJson(mapResponse);
        // CustomSnackBar.success(loginModel.message.success.first.toString());
        return model;
      }
    } catch (e) {
      log.e('🐞🐞🐞 err from Forget Send Otp api service ==> $e 🐞🐞🐞');
      CustomSnackBar.error('Something went Wrong!');
      return null;
    }
    return null;
  }

  ///ResetPassword Api method
  static Future<CommonSuccessModel?> resetPasswordApi(
      {required Map<String, dynamic> body}) async {
    Map<String, dynamic>? mapResponse;
    try {
      mapResponse = await ApiMethod(isBasic: true).post(
        "${ApiEndpoint.resetPasswordURL}?lang=${languageSettingsController.selectedLanguage.value}",
        body,
        code: 200,
        duration: 15,
        showResult: true,
      );
      if (mapResponse != null) {
        CommonSuccessModel model = CommonSuccessModel.fromJson(mapResponse);
        // CustomSnackBar.success(loginModel.message.success.first.toString());
        return model;
      }
    } catch (e) {
      log.e('🐞🐞🐞 err from Forget Send Otp api service ==> $e 🐞🐞🐞');
      CustomSnackBar.error('Something went Wrong!');
      return null;
    }
    return null;
  }

//SignUp Api method
  static Future<RegistrationModel?> signUpApi(
      {required Map<String, dynamic> body}) async {
    Map<String, dynamic>? mapResponse;
    try {
      mapResponse = await ApiMethod(isBasic: true).post(
        "${ApiEndpoint.registrationURL}?lang=${languageSettingsController.selectedLanguage.value}",
        body,
        code: 200,
        duration: 15,
        showResult: true,
      );
      if (mapResponse != null) {
        RegistrationModel signUpModel = RegistrationModel.fromJson(mapResponse);
        CustomSnackBar.success(signUpModel.message.success.first.toString());
        return signUpModel;
      }
    } catch (e) {
      log.e('🐞🐞🐞 err from sign up api service ==> $e 🐞🐞🐞');
      CustomSnackBar.error('Something went Wrong! in RegistrationModel');
      return null;
    }
    return null;
  }

//! lout out api
  static Future<CommonSuccessModel?> logOutApi(
      [bool showMessage = true]) async {
    Map<String, dynamic>? mapResponse;
    try {
      mapResponse = await ApiMethod(isBasic: false).get("${ApiEndpoint.logOutURL}?lang=${languageSettingsController.selectedLanguage.value}");
      if (mapResponse != null) {
        CommonSuccessModel logoutModel =
            CommonSuccessModel.fromJson(mapResponse);
        if (showMessage) {
          CustomSnackBar.success(logoutModel.message!.success!.first);
        }

        return logoutModel;
      }
    } catch (e) {
      log.e('err from log Out api service ==> $e');
      CustomSnackBar.error('Something went Wrong!');
      return null;
    }
    return null;
  }

  static Future<CommonSuccessModel?> deleteApi() async {
    Map<String, dynamic>? mapResponse;
    try {
      mapResponse =
          await ApiMethod(isBasic: false).post("${ApiEndpoint.deleteURL}?lang=${languageSettingsController.selectedLanguage.value}", {});
      if (mapResponse != null) {
        CommonSuccessModel model = CommonSuccessModel.fromJson(mapResponse);

        CustomSnackBar.success(model.message!.success!.first);

        return model;
      }
    } catch (e) {
      log.e('err from profile delete api service ==> $e');
      CustomSnackBar.error('Something went Wrong!');
      return null;
    }
    return null;
  }

  ///   -------
  //email verification Api method
  static Future<CommonSuccessModel?> emailVerificationApi(
      {required Map<String, dynamic> body}) async {
    Map<String, dynamic>? mapResponse;
    try {
      mapResponse = await ApiMethod(isBasic: false).post(
        "${ApiEndpoint.emailVerificationURL}?lang=${languageSettingsController.selectedLanguage.value}",
        body,
        code: 200,
        duration: 15,
        showResult: true,
      );
      if (mapResponse != null) {
        CommonSuccessModel commonSuccessModel =
            CommonSuccessModel.fromJson(mapResponse);
        // if(kDebugMode){
        //   CustomSnackBar.success(
        //       commonSuccessModel.message.success.first.toString());
        // }
        return commonSuccessModel;
      }
    } catch (e) {
      log.e('🐞🐞🐞 err from email verification api service ==> $e 🐞🐞🐞');
      CustomSnackBar.error('Something went Wrong!');
      return null;
    }
    return null;
  }

  //sign up resend otp Api method
  static Future<CommonSuccessModel?> signUpResendOtpApi() async {
    Map<String, dynamic>? mapResponse;
    try {
      mapResponse = await ApiMethod(isBasic: false).post(
        "${ApiEndpoint.signUpResendOtpURL}?lang=${languageSettingsController.selectedLanguage.value}",
        {},
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
      log.e('🐞🐞🐞 err from sign Up resend otp api service ==> $e 🐞🐞🐞');
      CustomSnackBar.error('Something went Wrong!');
      return null;
    }
    return null;
  }

  // dashboard api
  static Future<HomeModel?> dashboardAPi() async {
    Map<String, dynamic>? mapResponse;
    try {
      mapResponse = await ApiMethod(isBasic: false).get(
        "${ApiEndpoint.dashboardURL}?lang=${languageSettingsController.selectedLanguage.value}",
        code: 200,
        showResult: false,
      );
      if (mapResponse != null) {
        HomeModel dashboardModel = HomeModel.fromJson(mapResponse);

        return dashboardModel;
      }
    } catch (e) {
      log.e('🐞🐞🐞 err from Home Model api service ==> $e 🐞🐞🐞');
      CustomSnackBar.error('Something went Wrong! Home Model Api');
      return null;
    }
    return null;
  }

  //!change password Api method
  static Future<CommonSuccessModel?> changePasswordApi(
      {required Map<String, dynamic> body}) async {
    Map<String, dynamic>? mapResponse;
    try {
      mapResponse = await ApiMethod(isBasic: false).post(
        "${ApiEndpoint.changePasswordURL}?lang=${languageSettingsController.selectedLanguage.value}",
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
      log.e('🐞🐞🐞 err from change password api service ==> $e 🐞🐞🐞');
      CustomSnackBar.error('Something went Wrong!');
      return null;
    }
    return null;
  }
}
