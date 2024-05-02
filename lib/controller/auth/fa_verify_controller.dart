import 'package:adescrow_app/backend/local_storage/local_storage.dart';
import 'package:adescrow_app/utils/basic_screen_imports.dart';

import '../../../backend/backend_utils/logger.dart';
import '../../../backend/models/common/common_success_model.dart';
import '../../backend/services/two_fa_api_service.dart';
import '../../routes/routes.dart';

final log = logger(FAVerifyController);

class FAVerifyController extends GetxController with TwoFaApiService {
  final formKey = GlobalKey<FormState>();
  final otpController = TextEditingController();

  final _isLoading = false.obs;
  bool get isLoading => _isLoading.value;

  late CommonSuccessModel _successModel;
  CommonSuccessModel get successModel => _successModel;

  Future<CommonSuccessModel> onFAVerifyProcess() async {
    _isLoading.value = true;
    update();

    Map<String, dynamic> inputBody = {
      'otp': otpController.text,
    };

    await twoFaVerifyApi(body: inputBody).then((value) async {
      _successModel = value!;
      LocalStorage.isLoginSuccess(isLoggedIn: true);
      Get.offAllNamed(Routes.dashboardScreen);
      update();
    }).catchError((onError) {
      log.e(onError);
    });

    _isLoading.value = false;
    update();
    return _successModel;
  }

  void submitProcess() async{
    if(formKey.currentState!.validate()){
      await onFAVerifyProcess();
    }
  }
}
