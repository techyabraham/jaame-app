import 'package:adescrow_app/backend/backend_utils/no_data_widget.dart';
import 'package:adescrow_app/utils/basic_screen_imports.dart';
import 'package:adescrow_app/utils/responsive_layout.dart';
import 'package:adescrow_app/widgets/others/custom_loading_widget.dart';

import '../../../../controller/dashboard/my_wallets/transactions_controller.dart';
import '../../../../widgets/list_tile/transaction_tile_widget.dart';

class TransactionsScreen extends GetView<TransactionsController> {
  const TransactionsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: ResponsiveLayout(
        mobileScaffold: Scaffold(
            backgroundColor: Theme.of(context).scaffoldBackgroundColor,
            appBar: const PrimaryAppBar(
              title: Strings.transactions,
            ),
            body: Obx(() => controller.isLoading
                ? const CustomLoadingWidget()
                : _body(context))),
      ),
    );
  }

  _body(BuildContext context) {
    return controller.historyList.isEmpty
        ? const Column(children: [NoDataWidget()])
        : Stack(
            children: [
              ListView.separated(
                  controller: controller.scrollController,
                  shrinkWrap: true,
                  padding: EdgeInsets.only(
                    right: Dimensions.paddingSizeHorizontal * .85,
                    left: Dimensions.paddingSizeHorizontal * .85,
                    bottom: Dimensions.paddingSizeVertical * .85,
                  ),
                  scrollDirection: Axis.vertical,
                  physics: const BouncingScrollPhysics(),
                  itemBuilder: (context, index) {
                    return Obx(() => TransactionTileWidget(
                          onTap: () {
                            if (controller.openTileIndex.value != index) {
                              controller.openTileIndex.value = index;
                            } else {
                              controller.openTileIndex.value = -1;
                            }
                          },
                          expansion: controller.openTileIndex.value == index,
                          inDashboard: false,
                          transaction: controller.historyList[index],
                        ));
                  },
                  separatorBuilder: (context, i) =>
                      verticalSpace(Dimensions.marginSizeVertical * .3),
                  itemCount: controller.historyList.length),
              Obx(() => controller.isMoreLoading
                  ? const CustomLoadingWidget()
                  : const SizedBox()),
            ],
          );
  }
}
