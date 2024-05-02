import 'package:adescrow_app/utils/basic_screen_imports.dart';

import '../../backend/backend_utils/logger.dart';
import '../../backend/download_file.dart';
import '../../backend/local_storage/local_storage.dart';
import '../../backend/services/api_services.dart';
import '../../routes/routes.dart';
import '../../views/dashboard/btm_screens/home_screen.dart';
import '../../views/dashboard/btm_screens/my_escrow_screen.dart';
import '../../views/dashboard/btm_screens/my_wallet_screen.dart';
import '../../views/dashboard/btm_screens/profile_screen.dart';

final log = logger(DashboardController);

class DashboardController extends GetxController with DownloadFile{

  @override
  void onInit() {
    checkPermission();
    super.onInit();
  }




  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  final selectedIndex = 0.obs;

  List body = [
    const HomeScreen(),
    const MyEscrowScreen(),
    const MyWalletScreen(),
    const ProfileScreen()
  ];

  List bodyText = [
    Strings.home,
    Strings.myEscrow,
    Strings.myWallet,
    Strings.profile
  ];


  void notificationRoute()=> Get.toNamed(Routes.notificationScreen);

  void addNewEscrowRoute()=> Get.toNamed(Routes.addNewEscrowScreen);

  final _isLoading = false.obs;
  bool get isLoading => _isLoading.value;



  logOutProcess() async{

    _isLoading.value = true;
    update();

    await ApiServices.logOutApi().then((value) {
      if(value != null) {
        LocalStorage.logout();
        Get.offAllNamed(Routes.loginScreen);
      }
      update();
    }).catchError((onError) {
      log.e(onError);
    });

    _isLoading.value = false;
    update();

  }
}