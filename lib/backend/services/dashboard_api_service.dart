import 'package:adescrow_app/backend/models/common/common_success_model.dart';

import '../backend_utils/api_method.dart';
import '../backend_utils/custom_snackbar.dart';
import '../backend_utils/logger.dart';
import '../models/dashboard/notification_model.dart';
import '../models/dashboard/transaction_model.dart';
import '../models/tatum/cached_tatum_model.dart';
import 'api_endpoint.dart';

final log = logger(DashboardApiService);

mixin DashboardApiService {

  Future<NotificationModel?> notificationAPi() async {
    Map<String, dynamic>? mapResponse;
    try {
      mapResponse = await ApiMethod(isBasic: false).get(
        ApiEndpoint.notificationURL ,
        code: 200,
      );
      if (mapResponse != null) {
        NotificationModel modelData = NotificationModel.fromJson(mapResponse);

        return modelData;
      }
    } catch (e) {
      log.e('🐞🐞🐞 err from Notification Model api service ==> $e 🐞🐞🐞');
      CustomSnackBar.error('Something went Wrong!');
      return null;
    }
    return null;
  }

  ///* Get Transaction api services
  Future<TransactionModel?> transactionProcessApi(String page) async {
    Map<String, dynamic>? mapResponse;
    try {
      mapResponse = await ApiMethod(isBasic: false).get(
        "${ApiEndpoint.allTransactionsURL}?page=$page"
      );
      if (mapResponse != null) {
        TransactionModel result = TransactionModel.fromJson(mapResponse);
        // CustomSnackBar.success(result.message.success.first.toString());
        return result;
      }
    } catch (e) {
      log.e(':ladybug::ladybug::ladybug: err from Transaction api service ==> $e :ladybug::ladybug::ladybug:');
      CustomSnackBar.error('Something went Wrong!');
      return null;
    }
    return null;
  }


  ///* Get CachedTatum api services
  Future<CachedTatumModel?> cachedTatumProcessApi({required String id, required String apiUrl}) async {
    Map<String, dynamic>? mapResponse;
    try {
      mapResponse = await ApiMethod(isBasic: false).get(
        "$apiUrl/$id",
      );
      if (mapResponse != null) {
        CachedTatumModel result = CachedTatumModel.fromJson(mapResponse);
        // CustomSnackBar.success(result.message.success.first.toString());
        return result;
      }
    } catch (e) {
      log.e(':ladybug::ladybug::ladybug: err from CachedTatum api service ==> $e :ladybug::ladybug::ladybug:');
      CustomSnackBar.error('Something went Wrong!');
      return null;
    }
    return null;
  }


  ///* CachedTatumSubmit api services
  Future<CommonSuccessModel?> cachedTatumSubmitProcessApi(
      {required Map<String, dynamic> body, required String url}) async {
    Map<String, dynamic>? mapResponse;
    try {
      mapResponse = await ApiMethod(isBasic: false).post(
        url,
        body,
      );
      if (mapResponse != null) {
        CommonSuccessModel result = CommonSuccessModel.fromJson(mapResponse);
        // CustomSnackBar.success(result.message.success.first.toString());
        return result;
      }
    } catch (e) {
      log.e(':ladybug::ladybug::ladybug: err from CachedTatumSubmit api service ==> $e :ladybug::ladybug::ladybug:');
      CustomSnackBar.error('Something went Wrong!');
      return null;
    }
    return null;
  }

}
