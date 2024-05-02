import '../../language/language_controller.dart';
import '../backend_utils/api_method.dart';
import '../backend_utils/custom_snackbar.dart';
import '../backend_utils/logger.dart';
import '../models/common/common_success_model.dart';
import '../models/conversation/conversation_model.dart';
import 'api_endpoint.dart';

final log = logger(ConversationApiService);

mixin ConversationApiService {
  Future<ConversationModel?> conversationAPi(String id) async {
    Map<String, dynamic>? mapResponse;
    try {
      mapResponse = await ApiMethod(isBasic: false).get(
        "${ApiEndpoint.conversationURL}/$id?lang=${languageSettingsController.selectedLanguage.value}",
        code: 200,
        showResult: false,
        stream: true,
      );
      if (mapResponse != null) {
        ConversationModel modelData = ConversationModel.fromJson(mapResponse);

        return modelData;
      }
    } catch (e) {
      log.e('🐞🐞🐞 err from Conversation Model api service ==> $e 🐞🐞🐞');
      CustomSnackBar.error('Something went Wrong!');
      return null;
    }
    return null;
  }

  Future<CommonSuccessModel?> sendMessageApi(
      {required Map<String, dynamic> body}) async {
    Map<String, dynamic>? mapResponse;
    try {
      mapResponse = await ApiMethod(isBasic: false).post(
        "${ApiEndpoint.messageSendURL}?lang=${languageSettingsController.selectedLanguage.value}",
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
      log.e('🐞🐞🐞 err from send message api service ==> $e 🐞🐞🐞');
      CustomSnackBar.error('Something went Wrong!');
      return null;
    }
    return null;
  }

  Future<CommonSuccessModel?> sendFileApi(
      {required Map<String, String> body, required String filePath}) async {
    Map<String, dynamic>? mapResponse;
    try {
      mapResponse = await ApiMethod(isBasic: false).multipart2(
        "${ApiEndpoint.messageSendURL}?lang=${languageSettingsController.selectedLanguage.value}",
        body,
        filePath,
        "files[]",
        code: 200,
        showResult: true,
      );
      if (mapResponse != null) {
        CommonSuccessModel commonSuccessModel =
            CommonSuccessModel.fromJson(mapResponse);

        return commonSuccessModel;
      }
    } catch (e) {
      log.e('🐞🐞🐞 err from send message api service ==> $e 🐞🐞🐞');
      CustomSnackBar.error('Something went Wrong!');
      return null;
    }
    return null;
  }

  Future<CommonSuccessModel?> disputeApi(
      {required Map<String, dynamic> body}) async {
    Map<String, dynamic>? mapResponse;
    try {
      mapResponse = await ApiMethod(isBasic: false).post(
        "${ApiEndpoint.disputeURL}?lang=${languageSettingsController.selectedLanguage.value}",
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
      log.e('🐞🐞🐞 err from dispute api service ==> $e 🐞🐞🐞');
      CustomSnackBar.error('Something went Wrong!');
      return null;
    }
    return null;
  }

  Future<CommonSuccessModel?> releasePaymentApi(
      {required Map<String, dynamic> body}) async {
    Map<String, dynamic>? mapResponse;
    try {
      mapResponse = await ApiMethod(isBasic: false).post(
        "${ApiEndpoint.releasePaymentURL}?lang=${languageSettingsController.selectedLanguage.value}",
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
      log.e('🐞🐞🐞 err from dispute api service ==> $e 🐞🐞🐞');
      CustomSnackBar.error('Something went Wrong!');
      return null;
    }
    return null;
  }

  Future<CommonSuccessModel?> requestPaymentApi(
      {required Map<String, dynamic> body}) async {
    Map<String, dynamic>? mapResponse;
    try {
      mapResponse = await ApiMethod(isBasic: false).post(
        "${ApiEndpoint.requestPaymentURL}?lang=${languageSettingsController.selectedLanguage.value}",
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
      log.e('🐞🐞🐞 err from dispute api service ==> $e 🐞🐞🐞');
      CustomSnackBar.error('Something went Wrong!');
      return null;
    }
    return null;
  }
}
