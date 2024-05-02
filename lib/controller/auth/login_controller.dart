
import 'package:adescrow_app/backend/local_storage/local_storage.dart';

import '../../backend/backend_utils/logger.dart';
import '../../backend/models/auth/forgot_send_otp_model.dart';
import '../../backend/models/auth/login_model.dart';
import '../../backend/services/api_services.dart';
import '../../routes/routes.dart';
import '../../utils/basic_widget_imports.dart';


final log = logger(LoginController);

class LoginController extends GetxController{
  final formKey = GlobalKey<FormState>();
  final forgotPassFormKey = GlobalKey<FormState>();


  final forgotEmailController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    forgotEmailController.dispose();
    super.dispose();
  }





  onLoginProcess() async{
    if(formKey.currentState!.validate()){
      await signInProcess();
    }
  }

  /*--------------------------- Api function start ----------------------------------*/
  // Sign in process function
  final _isLoading = false.obs;
  bool get isLoading => _isLoading.value;

  late LoginModel _signInModel;
  LoginModel get signInModel => _signInModel;


  Future<LoginModel> signInProcess() async {
    _isLoading.value = true;
    update();

    Map<String, dynamic> inputBody = {
      'email': emailController.text,
      'password': passwordController.text,
    };

    await ApiServices.signInApi(body: inputBody).then((value) {
      _signInModel = value!;

      int kycVerified = _signInModel.data.user.kycVerified;
      int twoFaStatus = _signInModel.data.user.twoFactorStatus;
      int twoFaVerified = _signInModel.data.user.twoFactorVerified;

      // save token
      LocalStorage.saveToken(token: _signInModel.data.token);

      if (_signInModel.data.user.emailVerified == 0) {
        Get.toNamed(Routes.registerOTPScreen);
      }
      else {
        debugPrint("Email Verified => Login Process :: ${twoFaStatus.toString()} :: ${twoFaVerified.toString()}");
        debugPrint("Email Verified => Login Process :: ${twoFaStatus.toString()} :: ${twoFaVerified.toString()}");
        debugPrint("Email Verified => Login Process :: ${twoFaStatus.toString()} :: ${twoFaVerified.toString()}");

        if(kycVerified == 0){
          Get.toNamed(Routes.kycFormScreen);
        }
        else{
          /// this is for 2fa check
          if (twoFaStatus == 1 && twoFaVerified == 0) {
            Get.toNamed(Routes.faVerifyScreen);
          } else {
            _goToSavedUser(_signInModel);
          }
        }

        _isLoading.value = false;
        update();
      }

      update();
    }).catchError((onError) {
      log.e(onError);
    });

    _isLoading.value = false;
    update();
    return _signInModel;
  }

  void _goToSavedUser(LoginModel signInModel) {
    debugPrint("Verified => Save User and Dashboard");

    LocalStorage.isLoginSuccess(isLoggedIn: true);
    LocalStorage.saveEmail(email: emailController.text);
    Get.offAllNamed(Routes.dashboardScreen);
  }


  void onForgotPassProcess() async{
    if(forgotPassFormKey.currentState!.validate()) {
      await sendOTPProcess().then((value) {
        if(value != null) {
        }
      });
    }
  }

  final _isForgotLoading = false.obs;
  bool get isForgotLoading => _isForgotLoading.value;

  late ForgetSendOtpModel? _forgotModel;
  ForgetSendOtpModel? get forgotModel => _forgotModel;

  late RxString token;

  Future<ForgetSendOtpModel?> sendOTPProcess() async {
    _isForgotLoading.value = true;
    update();

    Map<String, dynamic> inputBody = {
      'credentials': forgotEmailController.text,
    };

    await ApiServices.forgotPasswordSendOTPApi(body: inputBody).then((value) {
      _forgotModel = value!;
      token = _forgotModel!.data.user.token.obs;
      Get.toNamed(Routes.forgotOTPScreen);
      update();
    }).catchError((onError) {
      log.e(onError);
    });

    _isForgotLoading.value = false;
    update();
    return _forgotModel;
  }


  goToRegisterScreen() {
    Get.toNamed(Routes.registerScreen);
  }
}