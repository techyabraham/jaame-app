import 'package:get/get.dart';

import '../controller/before_auth/basic_settings_controller.dart';
import '../controller/dashboard/btm_navs_controller/home_controller.dart';
import '../controller/dashboard/btm_navs_controller/my_escrow_controller.dart';
import '../controller/dashboard/btm_navs_controller/my_wallet_controller.dart';
import '../controller/dashboard/btm_navs_controller/profile_controller.dart';
import '../controller/dashboard/dashboard_controller.dart';
import '../controller/dashboard/notification_controller.dart';
import '../controller/dashboard/profiles/change_password_controller.dart';
import '../controller/dashboard/profiles/fa_security_controller.dart';
import '../controller/dashboard/profiles/update_profile_controller.dart';
import '../controller/dashboard/my_wallets/transactions_controller.dart';


class DashboardBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(DashboardController());
    Get.put(HomeController());
    Get.put(MyEscrowController());
    Get.put(MyWalletController());
    Get.put(ProfileController());
    Get.put(NotificationController());
    Get.put(TransactionsController());
    Get.put(UpdateProfileController());
    Get.put(ChangePasswordController());
    Get.put(FASecurityController());
    Get.put(BasicSettingsController(), permanent: true);
  }
}
