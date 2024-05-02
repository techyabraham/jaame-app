import 'package:get/get.dart';


import '../backend/local_auth/local_auth_controller.dart';
import '../controller/before_auth/basic_settings_controller.dart';
import '../controller/before_auth/splash_screen_controller.dart';


class SplashBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(SplashController());
    Get.put(BiometricController());
    Get.put(BasicSettingsController(), permanent: true);
  }
}
