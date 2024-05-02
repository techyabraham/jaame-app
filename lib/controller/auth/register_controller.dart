

import '../../backend/backend_utils/logger.dart';
import '../../backend/local_storage/local_storage.dart';
import '../../backend/models/auth/registration_model.dart';
import '../../backend/services/api_endpoint.dart';
import '../../backend/services/api_services.dart';
import '../../routes/routes.dart';
import '../../utils/basic_widget_imports.dart';
import '../../views/web_view/web_view_screen.dart';


final log = logger(RegisterController);

class RegisterController extends GetxController{
  final formKey = GlobalKey<FormState>();


  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  void dispose() {
    firstNameController.dispose();
    lastNameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  RxBool isChecked = false.obs;
  String type = "buyer";
  void checkBoxOnChanged(bool? value) {
    isChecked.value = value!;
  }

  switchValue(bool value) {
    debugPrint(value.toString());
    if(value) {
      type = 'buyer';
    } else {
      type = 'seller';
    }
  }

  late RegistrationModel _registrationModel;
  RegistrationModel get registrationModel => _registrationModel;

  onRegisterProcess() async{
    if(formKey.currentState!.validate()){
      await signUpProcess();
    }
  }


  final _isLoading = false.obs;
  bool get isLoading => _isLoading.value;

  Future<RegistrationModel> signUpProcess() async {
    _isLoading.value = true;
    update();

    Map<String, dynamic> inputBody = {
      'type': type,
      'email': emailController.text,
      'first_name': firstNameController.text,
      'last_name': lastNameController.text,
      'password': passwordController.text,
      'policy': isChecked.value ? "on" : "",
    };

    await ApiServices.signUpApi(body: inputBody).then((value) {
      _registrationModel = value!;
      LocalStorage.saveToken(token: _registrationModel.data.token);
      if(_registrationModel.data.user.emailVerified == 0){
        Get.toNamed(Routes.registerOTPScreen);
      }
      else if(_registrationModel.data.user.kycVerified == 0){
        Get.toNamed(Routes.kycFormScreen);
      }else{
        Get.offAllNamed(Routes.dashboardScreen);
      }

      update();
    }).catchError((onError) {
      log.e(onError);
    });

    _isLoading.value = false;
    update();
    return _registrationModel;
  }



  goToLoginScreen() {
    Get.offAllNamed(Routes.loginScreen);
  }

  void privacyPolicyWebView(BuildContext context) {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => const WebViewScreen(
              beforeAuth: true,
              appTitle: Strings.privacyPolicy,
              link:
              "${ApiEndpoint.mainDomain}/page/privacy-policy",
            )));
  }
}