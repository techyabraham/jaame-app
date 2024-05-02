

import 'package:adescrow_app/backend/services/api_endpoint.dart';
import 'package:get/get.dart';

import '../../backend/backend_utils/logger.dart';
import '../../backend/models/basic_settings_model.dart';
import '../../backend/services/api_services.dart';


final log = logger(BasicSettingsController);

class BasicSettingsController extends GetxController{

  late String splashBGLink;
  late String appIconLink;
  RxInt selectedIndex = 0.obs;

  @override
  void onInit() {
    basicSettingsFetch();
    super.onInit();
  }




  final _isLoading = false.obs;
  bool get isLoading => _isLoading.value;


  late BasicSettingModel _basicSettingModel;
  BasicSettingModel get basicSettingModel => _basicSettingModel;

  Future<BasicSettingModel> basicSettingsFetch() async {
    _isLoading.value = true;
    update();

    await ApiServices.basicSettingApi().then((value) {
      _basicSettingModel = value!;

      splashBGLink = "${ApiEndpoint.mainDomain}/${_basicSettingModel.data.imagePath}/${_basicSettingModel.data.splashScreen.splashScreenImage}";
      // onboardBGLink = "${ApiEndpoint.mainDomain}/${_basicSettingModel.data.imagePath}/${_basicSettingModel.data.onboardScreen.first.image}";
      appIconLink = "${ApiEndpoint.mainDomain}/${_basicSettingModel.data.logoImagePath}/${_basicSettingModel.data.allLogo.siteLogo}";

      update();
    }).catchError((onError) {
      log.e(onError);
    });
    _isLoading.value = false;
    update();

    return _basicSettingModel;
  }


}
//basicSettingApi

configDriveLink(String link){
  return 'https://drive.google.com/uc?export=view&id=${link.substring(link.indexOf('/d/') + 3, link.indexOf('/view'))}';
}