import 'package:get/get.dart';

import '../controller/before_auth/onboard_screen_controller.dart';




class OnboardBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(OnboardController());
  }
}
