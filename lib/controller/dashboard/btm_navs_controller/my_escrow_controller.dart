import 'package:adescrow_app/utils/basic_screen_imports.dart';

import '../../../backend/models/escrow/escrow_index_model.dart';
import '../../../backend/services/escrow_api_service.dart';

class MyEscrowController extends GetxController with EscrowApiService{
  RxInt openTileIndex = (-1).obs;

  @override
  void onInit() {
    escrowIndexFetch();
    super.onInit();
  }

late EscrowDatum escrowData;

  final _isLoading = false.obs;
  bool get isLoading => _isLoading.value;


  // fetch info
  late EscrowIndexModel _escrowIndexModel;
  EscrowIndexModel get escrowIndexModel => _escrowIndexModel;

  Future<EscrowIndexModel> escrowIndexFetch() async {
    _isLoading.value = true;
    update();

    await escrowIndexAPi().then((value) {
      _escrowIndexModel = value!;

      update();
    }).catchError((onError) {
      log.e(onError);
    });

    _isLoading.value = false;
    update();

    return _escrowIndexModel;
  }

}