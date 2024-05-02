import 'package:adescrow_app/utils/basic_screen_imports.dart';

import '../../../backend/backend_utils/logger.dart';
import '../../../backend/models/common/common_success_model.dart';
import '../../../backend/models/dashboard/profile_model.dart';
import '../../../backend/services/profile_api_services.dart';
import '../../../routes/routes.dart';

final log = logger(UpdateProfileController);


class UpdateProfileController extends GetxController with ProfileApiService{
  final formKey = GlobalKey<FormState>();

  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final numberController = TextEditingController();
  final cityController = TextEditingController();
  final zipController = TextEditingController();
  final stateController = TextEditingController();
  final addressController = TextEditingController();

  final typeIsBuyer = true.obs;

  final code = "".obs;
  final country = "".obs;

  void onUpdateProfileProcess() async{
    if(filePath.isEmpty) {
      await withoutImageProcess();
    }else{
      await withImageProcess();
    }
  }

  @override
  void onInit() {
    profileDataFetch();
    super.onInit();
  }

  final _isLoading = false.obs;
  bool get isLoading => _isLoading.value;

  late ProfileModel _profileModel;
  ProfileModel get profileModel => _profileModel;

  Future<ProfileModel> profileDataFetch() async{
    _isLoading.value = true;
    update();

    await profileApi().then((value) {
      _profileModel = value!;

      typeIsBuyer.value = _profileModel.data.user.type == "buyer" ? true: false;

      firstNameController.text = _profileModel.data.user.firstname;
      lastNameController.text = _profileModel.data.user.lastname;
      numberController.text = _profileModel.data.user.mobile;
      cityController.text = _profileModel.data.user.address.city;
      zipController.text = _profileModel.data.user.address.zip;
      stateController.text = _profileModel.data.user.address.state;
      addressController.text = _profileModel.data.user.address.address;
      country.value = _profileModel.data.user.address.country;

      for (var element in _profileModel.data.countries) {
        if(element.name == country.value){
          code.value = element.mobileCode;
        }
      }


     update();
    }).catchError((onError) {
      log.e(onError);
    });
    _isLoading.value = false;
    update();

    return _profileModel;
  }


 profileSwitch() async{
    _isLoading.value = true;
    update();

    await profileSwitchApi().then((value) {

      update();
    }).catchError((onError) {
      log.e(onError);
    });
    _isLoading.value = false;
    update();
  }


  late CommonSuccessModel _successModel;
  CommonSuccessModel get successModel => _successModel;


  final _isSubmitLoading = false.obs;
  bool get isSubmitLoading => _isSubmitLoading.value;


  Future<CommonSuccessModel> withoutImageProcess() async {
    _isSubmitLoading.value = true;
    update();

    Map<String, dynamic> inputBody = {
      'firstname': firstNameController.text,
      'lastname': lastNameController.text,
      'phone': numberController.text,
      'city': cityController.text,
      'zip_code': zipController.text,
      'state': stateController.text,
      'address': addressController.text,
      'country': country.value,
      'phone_code': code.value,
    };

    await updateProfileWithoutImageApi(body: inputBody).then((value) async {
      _successModel = value!;

      Get.offAllNamed(Routes.dashboardScreen);

      _isSubmitLoading.value = false;
      update();
    }).catchError((onError) {
      log.e(onError);
    });
    _isSubmitLoading.value = false;
    update();
    return _successModel;
  }

  String filePath = "";

  Future<CommonSuccessModel> withImageProcess() async {
    _isSubmitLoading.value = true;
    update();

    Map<String, String> inputBody = {
      'firstname': firstNameController.text,
      'lastname': lastNameController.text,
      'phone': numberController.text,
      'city': cityController.text,
      'zip_code': zipController.text,
      'state': stateController.text,
      'address': addressController.text,
      'country': country.value,
      'phone_code': code.value,
    };

    await updateProfileWithImageApi(body: inputBody, filepath: filePath).then((value) async {
      _successModel = value!;

      Get.offAllNamed(Routes.dashboardScreen);

      _isSubmitLoading.value = false;
      update();
    }).catchError((onError) {
      log.e(onError);
    });
    _isSubmitLoading.value = false;
    update();
    return _successModel;
  }
}