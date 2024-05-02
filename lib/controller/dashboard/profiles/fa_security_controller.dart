import 'package:adescrow_app/utils/basic_screen_imports.dart';

import '../../../backend/backend_utils/logger.dart';
import '../../../backend/models/common/common_success_model.dart';
import '../../../backend/models/dashboard/two_fa_info_model.dart';
import '../../../backend/services/two_fa_api_service.dart';

final log = logger(FASecurityController);

class FASecurityController extends GetxController with TwoFaApiService {
  @override
  void onInit() {
    twoFAFetch();
    super.onInit();
  }

  final _isLoading = false.obs;
  bool get isLoading => _isLoading.value;

  late TwoFaInfoModel _twoFaInfoModel;
  TwoFaInfoModel get twoFaInfoModel => _twoFaInfoModel;

  Future<TwoFaInfoModel> twoFAFetch() async {
    _isLoading.value = true;
    update();

    await twoFaInfoAPi().then((value) {
      _twoFaInfoModel = value!;
      update();
    }).catchError((onError) {
      log.e(onError);
    });

    _isLoading.value = false;
    update();

    return _twoFaInfoModel;
  }

  late CommonSuccessModel _successModel;
  CommonSuccessModel get successModel => _successModel;

  Future<CommonSuccessModel> onFASubmitProcess() async {
    Get.close(1);
    _isLoading.value = true;
    update();

    Map<String, dynamic> inputBody = {
      'status': _twoFaInfoModel.data.qrStatus == 1 ? 0 : 1,
    };

    await twoFaStatusUpdateApi(body: inputBody).then((value) async {
      _successModel = value!;
      await twoFAFetch();
      update();
    }).catchError((onError) {
      log.e(onError);
    });

    return _successModel;
  }
}
