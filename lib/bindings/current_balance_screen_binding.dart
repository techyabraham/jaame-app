import 'package:get/get.dart';
import '../controller/dashboard/my_wallets/add_money_controller.dart';
import '../controller/dashboard/my_wallets/current_balance_controller.dart';
import '../controller/dashboard/my_wallets/money_exchange_controller.dart';
import '../controller/dashboard/my_wallets/money_out_controller.dart';


class CurrentBalanceBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(CurrentBalanceController());
    Get.put(AddMoneyController());
    Get.put(MoneyOutController());
    Get.put(MoneyExchangeController());
  }
}
