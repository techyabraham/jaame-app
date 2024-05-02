import 'package:adescrow_app/backend/models/common/common_success_model.dart';

import '../../../backend/backend_utils/logger.dart';
import '../../../backend/services/api_services.dart';
import '../../../utils/basic_screen_imports.dart';

final log = logger(ChangePasswordController);

class ChangePasswordController extends GetxController {
  final formKey = GlobalKey<FormState>();

  final oldPasswordController = TextEditingController();
  final newPasswordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  @override
  void dispose() {
    oldPasswordController.dispose();
    newPasswordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }

  final _isLoading = false.obs;
  bool get isLoading => _isLoading.value;

  late CommonSuccessModel _successModel;
  CommonSuccessModel get successModel => _successModel;

  Future<CommonSuccessModel> changePasswordProcess() async {
    _isLoading.value = true;
    update();

    Map<String, dynamic> inputBody = {
      'current_password': oldPasswordController.text,
      'password': newPasswordController.text,
      'password_confirmation': confirmPasswordController.text,
    };

    await ApiServices.changePasswordApi(body: inputBody).then((value) {
      _successModel = value!;

      oldPasswordController.clear();
      newPasswordController.clear();
      confirmPasswordController.clear();

      update();
    }).catchError((onError) {
      log.e(onError);
    });

    _isLoading.value = false;
    update();

    return _successModel;
  }

  onChangePasswordProcess(BuildContext context) {
    if (formKey.currentState!.validate()) {
      changePasswordProcess();
    }
  }
}
