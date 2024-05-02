
import 'dart:async';

import '../../backend/backend_utils/custom_snackbar.dart';
import '../../backend/backend_utils/logger.dart';
import '../../backend/services/api_services.dart';
import '../../routes/routes.dart';
import '../../utils/basic_screen_imports.dart';
import 'login_controller.dart';

final log = logger(ForgotOTPController);

class ForgotOTPController extends GetxController{

  final pinController = TextEditingController();

  @override
  void dispose() {
    pinController.dispose();
    timer!.cancel();
    super.dispose();
  }


  Timer? timer;
  RxInt second = 60.obs;
  RxBool enableResend = false.obs;

  @override
  void onInit() {
    timerInit();
    super.onInit();
  }

  resendBTN() async{

    Get.find<LoginController>().sendOTPProcess().then((value) {
      if(value != null) {

        second.value = 59;
        enableResend.value = false;
      }

    });
  }

  timerInit() {
    timer = Timer.periodic(const Duration(seconds: 1), (_) {

      if ( second.value != 0) {
        second.value--;
      } else {
        enableResend.value = true;
      }

    });
  }



  final _isForgotLoading = false.obs;
  bool get isForgotLoading => _isForgotLoading.value;

  verifyOTPProcess() async {
    _isForgotLoading.value = true;
    update();

    Map<String, dynamic> inputBody = {
      'otp': pinController.text,
      'token': Get.find<LoginController>().token.value,
    };

    await ApiServices.forgotPasswordVerifyOTPApi(body: inputBody).then((value) {
      if(value != null){
        Get.toNamed(Routes.resetPassScreen);
      }
      update();
    }).catchError((onError) {
      log.e(onError);
    });

    _isForgotLoading.value = false;
    update();
  }

  void onOTPSubmitProcess() async{

    debugPrint(pinController.text.length.toString());
    if (pinController.text.length == 6) {
      await verifyOTPProcess();
    } else {
      CustomSnackBar.error(Strings.enterPin);
    }
  }
}