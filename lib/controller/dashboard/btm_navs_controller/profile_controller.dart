import 'package:adescrow_app/utils/basic_screen_imports.dart';

import '../../../backend/backend_utils/logger.dart';
import '../../../backend/local_storage/local_storage.dart';
import '../../../backend/services/api_services.dart';
import '../../../routes/routes.dart';


final log = logger(ProfileController);

class ProfileController extends GetxController{



  final _isLoading = false.obs;
  bool get isLoading => _isLoading.value;



  deleteProfileProcess() async{
    _isLoading.value = true;
    update();

    await ApiServices.deleteApi().then((value) {
      LocalStorage.logout();
      Get.offAllNamed(Routes.loginScreen);
      update();
    }).catchError((onError) {
      log.e(onError);
    });

    _isLoading.value = false;
    update();
  }

  void routeUpdateProfile() => Get.toNamed(Routes.updateProfileScreen);
  void routeUpdateKYC() => Get.toNamed(Routes.kycFormScreen);
  void routeFASecurity() => Get.toNamed(Routes.faSecurityScreen);
  void routeChangePassword() => Get.toNamed(Routes.changePasswordScreen);
}