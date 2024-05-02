import 'package:get/get.dart';

import '../controller/dashboard/my_escrows/add_new_escrow_controller.dart';



class AddNewEscrowBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(AddNewEscrowController());
  }
}
