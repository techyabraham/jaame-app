import 'package:get/get.dart';

import '../controller/dashboard/my_escrows/conversation_controller.dart';



class ConversationBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(ConversationController());
  }
}
