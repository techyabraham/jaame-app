
import 'package:get/get.dart';

import '../../backend/local_storage/local_storage.dart';
import '../../routes/routes.dart';

class OnboardController extends GetxController {

  goNextBTNClicked(){

    LocalStorage.saveOnboardDoneOrNot(isOnBoardDone: true);
    Get.offAllNamed(Routes.loginScreen);
  }
}
