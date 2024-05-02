import '../../language/language_controller.dart';
import '../models/common/common_success_model.dart';
import '../models/money_out/money_out_index_model.dart';
import '../models/money_out/money_out_manual_model.dart';
import 'api_endpoint.dart';
import '../backend_utils/api_method.dart';
import '../backend_utils/custom_snackbar.dart';
import '../backend_utils/logger.dart';

final log = logger(MoneyOutApiService);

mixin MoneyOutApiService {

  Future<MoneyOutIndexModel?> moneyOutIndexAPi() async {
    Map<String, dynamic>? mapResponse;
    try {
      mapResponse = await ApiMethod(isBasic: false).get(
        "${ApiEndpoint.moneyOutIndexURL}?lang=${languageSettingsController.selectedLanguage.value}",
        code: 200,
        showResult: false,
      );
      if (mapResponse != null) {
        MoneyOutIndexModel modelData = MoneyOutIndexModel.fromJson(mapResponse);

        return modelData;
      }
    } catch (e) {
      log.e('🐞🐞🐞 err from Money Out Index Model api service ==> $e 🐞🐞🐞');
      CustomSnackBar.error('Something went Wrong!');
      return null;
    }
    return null;
  }

  Future<MoneyOutManualModel?> moneyOutSubmitManualApi(
      {required Map<String, dynamic> body}) async {
    Map<String, dynamic>? mapResponse;
    try {
      mapResponse = await ApiMethod(isBasic: false).post(
        "${ApiEndpoint.moneyOutSubmitURL}?lang=${languageSettingsController.selectedLanguage.value}",
        body,
        code: 200,
        duration: 15,
        showResult: true,
      );
      if (mapResponse != null) {
        MoneyOutManualModel modelData =
        MoneyOutManualModel.fromJson(mapResponse);

        // CustomSnackBar.success(
        //     commonSuccessModel.message!.success!.first.toString());
        return modelData;
      }
    } catch (e) {
      log.e('🐞🐞🐞 err from money out submit api service ==> $e 🐞🐞🐞');
      CustomSnackBar.error('Something went Wrong!');
      return null;
    }
    return null;
  }

  Future<CommonSuccessModel?> moneyOutManualConfirmApi({
    required Map<String, String> body,
    required List<String> pathList,
    required List<String> fieldList,
  }) async {

    Map<String, dynamic>? mapResponse;
    try {
      mapResponse = await ApiMethod(isBasic: false).multipartMultiFile(
        "${ApiEndpoint.moneyOutConfirmURL}?lang=${languageSettingsController.selectedLanguage.value}",
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
      log.e('🐞🐞🐞 err from money out manual confirm api service ==> $e 🐞🐞🐞');
      CustomSnackBar.error('Something went Wrong!');
      return null;
    }
    return null;
  }
}