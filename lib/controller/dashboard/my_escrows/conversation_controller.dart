
import 'dart:async';
import 'dart:io';


import '../../../backend/backend_utils/logger.dart';
import '../../../backend/models/common/common_success_model.dart';
import '../../../backend/models/conversation/conversation_model.dart';
import '../../../backend/models/escrow/escrow_index_model.dart';
import '../../../backend/services/conversation_api_service.dart';
import '../../../utils/basic_screen_imports.dart';
import '../../../views/dashboard/my_escrow_screens/conversation_screen/message_model.dart';
import '../btm_navs_controller/my_escrow_controller.dart';

final log = logger(ConversationController);

class ConversationController extends GetxController with ConversationApiService{


  @override
  void onInit() {
    isStreamStart.value = true;
    super.onInit();
  }

  final sendTextController = TextEditingController();
  final scrollController = ScrollController();

  RxInt status = 0.obs;
  EscrowDatum escrowData = Get.find<MyEscrowController>().escrowData;

  void scrollDown() {
    debugPrint("DOWN");
    scrollController.animateTo(
      scrollController.position.maxScrollExtent,
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeOut,
    );
  }

  @override
  dispose(){
    super.dispose();
    sendTextController.dispose();
  }

  void sendText() async{
    scrollDown();
    debugPrint("Sending massage with File --------------- RESULT ");
    debugPrint("Sending massage with File ? ${haveFile.value}");
    if(haveFile.value){

      update();
      await sendFileProcess().then((value) {
        file = null;
        update();
        isFirst.value = true;
        i = 0;
        scrollDown();
      });
    }
    else {
      if (sendTextController.text.isNotEmpty) {
        await sendMessageProcess().then((value) {
          isFirst.value = true;
          i = 0;
          scrollDown();
        });
      }
    }
  }

  RxList<MessageModel> messages =<MessageModel>[].obs;

  // --------------------------- Stream
  int i = 0;
  RxBool isFirst = true.obs;
  RxBool isStreamStart = false.obs;

  Stream<ConversationModel> getConversationStream() async* {
    while (isStreamStart.value) {
      await Future.delayed(Duration(seconds: isFirst.value ? 0 : 2));
      if (isStreamStart.value) {
        ConversationModel data = await conversationFetch();


        if(i == 1){
          isFirst.value = false;
        }

        i++;
        yield data;
      }
    }
  }

  final _isLoading = false.obs;
  bool get isLoading => _isLoading.value;

  final _isLoading2 = false.obs;
  bool get isLoading2 => _isLoading2.value;

  late ConversationModel _conversationModel;
  ConversationModel get conversationModel => _conversationModel;

  Future<ConversationModel> conversationFetch() async {
    await conversationAPi(escrowData.id.toString()).then((value) {
      _conversationModel = value!;

      status.value = _conversationModel.data.status;
      log.i(_conversationModel.data.escrowConversations.length);

      if(i == 1){
        scrollDown();
      }

      update();
    }).catchError((onError) {
      log.e(onError);
    });
    return _conversationModel;
  }



  final _isMSGLoading = false.obs;
  bool get isMSGLoading => _isMSGLoading.value;

  late CommonSuccessModel? _successModel;
  CommonSuccessModel? get successModel => _successModel;

  Future<CommonSuccessModel?> sendMessageProcess() async {

    _isMSGLoading.value = true;
    update();

    Map<String, dynamic> inputBody = {
      'escrow_id': escrowData.id,
      'message': sendTextController.text,
    };

    await sendMessageApi(body: inputBody).then((value) async {
      _successModel = value;

      update();
    }).catchError((onError) {
      log.e(onError);
    });
    sendTextController.clear();
    _isMSGLoading.value = false;
    update();
    return _successModel;
  }

  RxString filePath = "".obs;
  RxBool haveFile = false.obs;
  File? file;
  Future<CommonSuccessModel?> sendFileProcess() async {
    _isMSGLoading.value = true;
    update();

    Map<String, String> inputBody = {
      'escrow_id': escrowData.id.toString(),
      'message': sendTextController.text,
    };

    await sendFileApi(body: inputBody, filePath: filePath.value).then((value) async {
      _successModel = value;


      filePath.value == "";
      haveFile.value = false;
      update();
    }).catchError((onError) {
      log.e(onError);
    });

    sendTextController.clear();
    _isMSGLoading.value = false;
    update();
    return _successModel;
  }

  Future<CommonSuccessModel?> disputeProcess() async {
    _isLoading2.value = true;
    update();

    Map<String, dynamic> inputBody = {
      'target': escrowData.id,
    };

    await disputeApi(body: inputBody).then((value) async {
      _successModel = value;

      _isLoading2.value = false;
      update();
    }).catchError((onError) {
      log.e(onError);
    });

    _isLoading2.value = false;
    update();
    return _successModel;
  }

  Future<CommonSuccessModel?> releasePaymentProcess() async {
    _isLoading.value = true;
    update();

    Map<String, dynamic> inputBody = {
      'target': escrowData.id,
    };

    await releasePaymentApi(body: inputBody).then((value) async {
      _successModel = value;

      _isLoading.value = false;
      update();
    }).catchError((onError) {
      log.e(onError);
    });

    _isLoading.value = false;
    update();
    return _successModel;
  }

  Future<CommonSuccessModel?> requestPaymentProcess() async {
    _isLoading.value = true;
    update();

    Map<String, dynamic> inputBody = {
      'target': escrowData.id,
    };

    await requestPaymentApi(body: inputBody).then((value) async {
      _successModel = value;

      _isLoading.value = false;
      update();
    }).catchError((onError) {
      log.e(onError);
    });

    _isLoading.value = false;
    update();
    return _successModel;
  }
}
