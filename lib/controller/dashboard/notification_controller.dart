import 'package:adescrow_app/utils/basic_screen_imports.dart';

import '../../backend/backend_utils/logger.dart';
import '../../backend/models/dashboard/notification_model.dart';
import '../../backend/services/dashboard_api_service.dart';

final log = logger(NotificationController);

class NotificationController extends GetxController with DashboardApiService{


  @override
  void onInit() {
    notificationsFetch();
    super.onInit();
  }

  final _isLoading = false.obs;
  bool get isLoading => _isLoading.value;

  late NotificationModel _notificationModel;
  NotificationModel get notificationModel => _notificationModel;

  Future<NotificationModel> notificationsFetch() async {
    _isLoading.value = true;
    update();
    await notificationAPi().then((value) {
      _notificationModel = value!;
      _isLoading.value = false;
      update();
    }).catchError((onError) {
      log.e(onError);
      _isLoading.value = false;
      update();
    });
    return _notificationModel;
  }

}