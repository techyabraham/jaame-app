import 'package:adescrow_app/utils/basic_screen_imports.dart';

import '../../../backend/backend_utils/logger.dart';
import '../../../backend/local_storage/local_storage.dart';
import '../../../backend/models/common/common_success_model.dart';
import '../../../backend/models/dashboard/home_model.dart';
import '../../../backend/models/tatum/cached_tatum_model.dart';
import '../../../backend/services/api_services.dart';
import '../../../backend/services/dashboard_api_service.dart';
import '../../../routes/routes.dart';
import '../../../views/confirm_screen.dart';

final log = logger(HomeController);

class HomeController extends GetxController with DashboardApiService{
RxInt openTileIndex = (-1).obs;

  @override
  void onInit() {
    homeDataFetch();
    super.onInit();
  }

  final _isLoading = false.obs;
  bool get isLoading => _isLoading.value;

  late HomeModel _homeModel;
  HomeModel get homeModel => _homeModel;

  Future<HomeModel> homeDataFetch() async{
    _isLoading.value = true;
    update();

    await ApiServices.dashboardAPi().then((value) {
      _homeModel = value!;

      LocalStorage.saveUserId(id: _homeModel.data.userId);
      update();
    }).catchError((onError) {
      log.e(onError);
    });
    _isLoading.value = false;
    update();

    return _homeModel;
  }


  /// transactions tatum
final formKey = GlobalKey<FormState>();
List<TextEditingController> inputFieldControllers = [];
RxList inputFields = [].obs;


final _isFetchLoading = false.obs;
bool get isFetchLoading => _isFetchLoading.value;

// tatum
late CachedTatumModel _tatumModel;
  CachedTatumModel get tatumModel => _tatumModel;

  // NOTE: this is dynamic method,,, I am passing apiUrl and id for manage dynamic ..... from 2 actions
Future<CachedTatumModel> cachedTatumProcess({required String id, required String apiUrl}) async {
  inputFields.clear();
  inputFieldControllers.clear();

  _isSubmitLoading.value = true;
  update();


  await cachedTatumProcessApi(apiUrl: apiUrl,id: id).then((value) async {
    _tatumModel = value!;

    var data = _tatumModel.data.addressInfo.inputFields;
    for (int item = 0; item < data.length; item++) {
      // make the dynamic controller
      var textEditingController = TextEditingController();
      inputFieldControllers.add(textEditingController);
      if (data[item].type.contains('text')) {
        inputFields.add(
          Column(
            mainAxisAlignment: mainStart,
            crossAxisAlignment: crossStart,
            children: [
              PrimaryTextInputWidget(
                controller: inputFieldControllers[item],
                labelText: data[item].label,
              ),
              verticalSpace(Dimensions.marginBetweenInputBox * .8),
            ],
          ),
        );
      }
    }
    _isSubmitLoading.value = false;
    update();

    Get.toNamed(Routes.transactionsTatumScreen);

    update();
  }).catchError((onError) {
    log.e(onError);
  });
  _isSubmitLoading.value = false;
  update();
  return _tatumModel;
}


void onTatumSubmit(BuildContext context) async {
  await tatumSubmitApiProcess().then((value) {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => ConfirmScreen(
              message: Strings.addMoneyConfirmationMSG,
              onApproval: true,
              onOkayTap: () => Get.offAllNamed(Routes.dashboardScreen),
            )));
  });
}

///* manual submit submit api process


  final _isSubmitLoading = false.obs;
  bool get isSubmitLoading => _isSubmitLoading.value;

  late CommonSuccessModel _tatumSuccessModel;
  CommonSuccessModel get tatumSuccessModel => _tatumSuccessModel;

Future<CommonSuccessModel> tatumSubmitApiProcess() async {
  _isLoading.value = true;
  Map<String, String> inputBody = {};

  final data = tatumModel.data.addressInfo.inputFields;

  for (int i = 0; i < data.length; i += 1) {
    inputBody[data[i].name] = inputFieldControllers[i].text;
  }

  await cachedTatumSubmitProcessApi(
      body: inputBody, url: tatumModel.data.addressInfo.submitUrl)
      .then((value) {
    _tatumSuccessModel = value!;

    inputFields.clear();
    inputFieldControllers.clear();

    _isLoading.value = false;
    update();
  }).catchError((onError) {
    log.e(onError);
  });
  _isLoading.value = false;
  update();
  return _tatumSuccessModel;
}

}