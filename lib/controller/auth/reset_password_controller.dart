import 'package:adescrow_app/backend/models/common/common_success_model.dart';

import '../../backend/backend_utils/logger.dart';
import '../../backend/services/api_services.dart';
import '../../routes/routes.dart';
import '../../utils/basic_widget_imports.dart';
import '../../views/confirm_screen.dart';
import 'login_controller.dart';

final log = logger(ResetPasswordController);

class ResetPasswordController extends GetxController {
  final formKey = GlobalKey<FormState>();

  final newPasswordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  @override
  void dispose() {
    newPasswordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }

  late CommonSuccessModel _modelData;
  CommonSuccessModel get modelData => _modelData;

  final _isForgotLoading = false.obs;
  bool get isForgotLoading => _isForgotLoading.value;

  Future<CommonSuccessModel> resetPasswordProcess() async {
    _isForgotLoading.value = true;
    update();

    Map<String, dynamic> inputBody = {
      'password': newPasswordController.text,
      'password_confirmation': confirmPasswordController.text,
      'token': Get.find<LoginController>().token.value,
    };

    await ApiServices.resetPasswordApi(body: inputBody).then((value) {
      _modelData = value!;
      update();
    }).catchError((onError) {
      log.e(onError);
    });

    _isForgotLoading.value = false;
    update();

    return _modelData;
  }

  onResetPasswordProcess(BuildContext context) async {
    if (formKey.currentState!.validate()) {
      await resetPasswordProcess().then((value) => Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => ConfirmScreen(
                    message: Strings.resetPasswordConfirmationMSG,
                    onOkayTap: () => Get.offAllNamed(Routes.loginScreen),
                  ))));
    }
  }
}
