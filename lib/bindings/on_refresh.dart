
import '../controller/dashboard/btm_navs_controller/home_controller.dart';
import '../controller/dashboard/btm_navs_controller/my_escrow_controller.dart';
import '../controller/dashboard/notification_controller.dart';
import '../controller/dashboard/profiles/fa_security_controller.dart';
import '../controller/dashboard/profiles/update_profile_controller.dart';
import '../utils/basic_screen_imports.dart';

Future<void> onRefresh() async{
  await Get.find<HomeController>().homeDataFetch();
  await Get.find<MyEscrowController>().escrowIndexFetch();
  await Get.find<UpdateProfileController>().profileDataFetch();
  await Get.find<FASecurityController>().twoFAFetch();
  await Get.find<NotificationController>().notificationsFetch();
}