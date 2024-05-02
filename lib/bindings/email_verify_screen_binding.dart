import 'package:get/get.dart';

import '../controller/auth/register_otp_controller.dart';

class EmailVerifyBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(RegisterOTPController());
  }
}
