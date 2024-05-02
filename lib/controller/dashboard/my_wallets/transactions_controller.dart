import 'package:adescrow_app/utils/basic_screen_imports.dart';


import '../../../backend/services/dashboard_api_service.dart';
import '../../../backend/models/dashboard/home_model.dart';
import '../../../backend/models/dashboard/transaction_model.dart';

class TransactionsController extends GetxController  with DashboardApiService{
  RxInt openTileIndex = (-1).obs;
  late ScrollController scrollController;

  @override
  void onInit() {
    transactionProcess();
    scrollController = ScrollController()..addListener(scrollListener);
    super.onInit();
  }

  void scrollListener() {
    if (scrollController.position.pixels == scrollController.position.maxScrollExtent) {
      debugPrint('Scrolled to the bottom');
      transactionMoreProcess();
    }
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  /// ------------------------------------- >>
  final _isLoading = false.obs;
  bool get isLoading => _isLoading.value;

  late TransactionModel _transactionModel;
  TransactionModel get transactionModel => _transactionModel;

  final _isMoreLoading = false.obs;
  bool get isMoreLoading => _isMoreLoading.value;

  int page = 1;
  RxBool hasNextPage = true.obs;
  RxList<Transaction> historyList = <Transaction>[].obs;  /// set it first


  ///* Get Transaction in process
  Future<TransactionModel> transactionProcess() async {
    historyList.clear();
    hasNextPage.value = true;
    page = 1;

    _isLoading.value = true;
    update();
    await transactionProcessApi(page.toString()).then((value) {
      _transactionModel = value!;

      if(_transactionModel.data.transactions.lastPage > 1){
        hasNextPage.value = true;
      }else{
        hasNextPage.value = false;
      }

      historyList.addAll(_transactionModel.data.transactions.data);

      _isLoading.value = false;
      update();
    }).catchError((onError) {
      log.e(onError);
    });
    _isLoading.value = false;
    update();
    return _transactionModel;
  }



  ///* Get Transaction in process
  Future<TransactionModel> transactionMoreProcess() async {
    page ++;

    if(hasNextPage.value && !_isMoreLoading.value){

      _isMoreLoading.value = true;
      update();
      await transactionProcessApi(page.toString()).then((value) {
        _transactionModel = value!;

        var data = _transactionModel.data.transactions.lastPage;
        historyList.addAll(_transactionModel.data.transactions.data);
        if(page >= data){
          hasNextPage.value = false;
        }

        _isMoreLoading.value = false;

        update();
      }).catchError((onError) {
        log.e(onError);
      });

      _isMoreLoading.value = false;
      update();

    }
    return _transactionModel;
  }

}