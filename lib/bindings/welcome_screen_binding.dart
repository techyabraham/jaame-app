import 'package:get/get.dart';

import '../controller/before_auth/welcome_screen_controller.dart';




class WelcomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(WelcomeController());

  }
}
