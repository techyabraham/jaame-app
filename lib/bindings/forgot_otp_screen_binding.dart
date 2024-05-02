import 'package:get/get.dart';

import '../controller/auth/forgot_otp_controller.dart';

class ForgotOTPBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(ForgotOTPController());
  }
}
