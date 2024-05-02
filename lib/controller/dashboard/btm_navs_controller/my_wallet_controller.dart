import 'package:adescrow_app/utils/basic_screen_imports.dart';

import '../../../backend/models/dashboard/home_model.dart';
import '../../../routes/routes.dart';
import 'home_controller.dart';

class MyWalletController extends GetxController{

  final walletsController = Get.find<HomeController>();

  void routeCurrentBalanceScreen(int index, UserWallet data) {
    Get.toNamed(Routes.currentBalanceScreen, arguments: data);
  }
}