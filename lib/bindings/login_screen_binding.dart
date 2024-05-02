import 'package:get/get.dart';

import '../controller/auth/fa_verify_controller.dart';
import '../controller/auth/login_controller.dart';
import '../controller/auth/reset_password_controller.dart';


class LoginBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(LoginController());
    Get.put(FAVerifyController());
    Get.put(ResetPasswordController());
  }
}
