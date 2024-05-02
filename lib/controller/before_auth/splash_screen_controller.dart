import 'dart:async';

import 'package:adescrow_app/backend/local_storage/local_storage.dart';
import 'package:get/get.dart';

import '../../backend/local_auth/local_auth_controller.dart';
import '../../routes/routes.dart';

class SplashController extends GetxController {
  @override
  void onReady() {
    super.onReady();

    _goToScreen();
  }

  _goToScreen() async {
    Timer(const Duration(seconds: 4), () {
      LocalStorage.isLoggedIn()
          ? Get.find<BiometricController>().supportState == SupportState.supported
            ? Get.offAllNamed(Routes.welcomeScreen)
            :  Get.offAllNamed(Routes.loginScreen)
          : LocalStorage.isOnBoardDone()
              ? Get.offAllNamed(Routes.loginScreen)
              : Get.offAllNamed(Routes.onboardScreen);
    });
  }
}
