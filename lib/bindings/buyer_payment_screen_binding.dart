import 'package:get/get.dart';

import '../controller/dashboard/my_escrows/buyer_payment_controller.dart';



class BuyerPaymentBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(BuyerPaymentController());
  }
}
