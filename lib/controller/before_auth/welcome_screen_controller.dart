
import 'package:get/get.dart';

import '../../backend/local_storage/local_storage.dart';
import '../../backend/services/api_services.dart';
import '../../language/english.dart';
import '../../routes/routes.dart';
import '../../utils/svg_assets.dart';

class WelcomeController extends GetxController {

  // goNextBTNClicked() => Get.offAllNamed(Routes.welcomeScreen);

  RxInt selectedIndex = (-1).obs;

  List buttonsName = [
    Strings.fingerLock,
    Strings.faceLock,
    Strings.passwordLock
  ];

  List selectedButtonSVG = [
    SVGAssets.fingerWhite,
    SVGAssets.faceWhite,
    SVGAssets.passwordWhite
  ];

  List buttonSVG = [
    SVGAssets.fingerPrimary,
    SVGAssets.facePrimary,
    SVGAssets.passwordPrimary
  ];

  void setIndex(int index) {
    // selectedIndex.value = index;
    Get.toNamed(Routes.loginScreen);
  }

  void loginWithEmail() async{


    await ApiServices.logOutApi(false).then((value) {
      LocalStorage.logout();
      Get.offNamed(Routes.loginScreen);
      update();
    }).catchError((onError) {
      log.e(onError);
    });

  }
}
