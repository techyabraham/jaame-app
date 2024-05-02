import 'package:adescrow_app/backend/services/api_endpoint.dart';
import 'package:adescrow_app/utils/basic_screen_imports.dart';
import 'package:adescrow_app/utils/responsive_layout.dart';

import '../../../../backend/backend_utils/no_data_widget.dart';
import '../../../../backend/models/dashboard/home_model.dart';
import '../../../../controller/dashboard/btm_navs_controller/home_controller.dart';
import '../../../../controller/dashboard/my_wallets/current_balance_controller.dart';
import '../../../../extensions/custom_extensions.dart';
import '../../../../routes/routes.dart';
import '../../../../widgets/buttons/circle_icon_button_widget.dart';
import '../../../../widgets/list_tile/transaction_tile_widget.dart';
import '../../../../widgets/others/wallet_flag_image_widget.dart';

class CurrentBalanceScreen extends GetView<CurrentBalanceController> {
  CurrentBalanceScreen({super.key});

  final UserWallet data = Get.arguments;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        color: Theme.of(context).scaffoldBackgroundColor,
        child: Stack(
          children: [
            Container(
              height: MediaQuery.of(context).size.height * .2,
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(Dimensions.radius * 12),
                    bottomRight: Radius.circular(Dimensions.radius * 12),
                  )),
            ),
            ResponsiveLayout(
              mobileScaffold: Scaffold(
                  backgroundColor: Colors.transparent,
                  appBar: const PrimaryAppBar(
                    title: Strings.currentBalance,
                  ),
                  body: ListView(
                    physics: const BouncingScrollPhysics(),
                    children: [
                      _walletWidget(context),
                      _recentTransactionsWidget(),
                    ],
                  )),
            ),
          ],
        ),
      ),
    );
  }

  _walletWidget(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        verticalSpace(Dimensions.marginSizeVertical * 1),
        WalletFlagImageWidget(
          imagePath:
              "${ApiEndpoint.mainDomain}/${data.imagePath}/${data.flag}",
        ),
        verticalSpace(Dimensions.marginSizeVertical * .2),
        TitleHeading1Widget(
          text:
              "${makeBalance(data.balance.toString(), data.currencyType == "FIAT" ? 2 : 6)} ${data.currencyCode}",
          fontSize: Dimensions.headingTextSize1 * 1.2,
        ),
        verticalSpace(Dimensions.marginSizeVertical * .2),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TitleHeading3Widget(
              text: "${data.name} - ",
              opacity: .4,
              fontSize: Dimensions.headingTextSize3 * .85,
            ),
            TitleHeading3Widget(
              text: data.currencyCode,
              color: Theme.of(context).primaryColor,
              fontSize: Dimensions.headingTextSize3 * .85,
            ),
          ],
        ),
        verticalSpace(Dimensions.marginSizeVertical * 1),
        Padding(
          padding: EdgeInsets.symmetric(
              horizontal: Dimensions.paddingSizeHorizontal * .5),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              CircleIconButtonWidget(
                name: Strings.addMoney,
                icon: Icons.add,
                onTap: () {
                  Get.toNamed(Routes.addMoneyScreen, arguments: data);
                },
              ),
              CircleIconButtonWidget(
                name: Strings.moneyOut,
                icon: Icons.remove,
                onTap: () {
                  Get.toNamed(Routes.moneyOutScreen, arguments: data);
                },
              ),
              CircleIconButtonWidget(
                name: Strings.exchange,
                icon: Icons.currency_exchange_outlined,
                onTap: () {
                  Get.toNamed(Routes.moneyExchangeScreen);
                },
              ),
              CircleIconButtonWidget(
                name: Strings.transactions,
                icon: Icons.history,
                onTap: () {
                  Get.toNamed(Routes.transactionsScreen);
                },
              ),
            ],
          ),
        ),
        verticalSpace(Dimensions.marginSizeVertical * .6)
      ],
    );
  }

  _recentTransactionsWidget() {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: Dimensions.paddingSizeHorizontal * .85,
        vertical: Dimensions.paddingSizeHorizontal * .85,
      ),
      decoration: BoxDecoration(
          color: CustomColor.whiteColor,
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(Dimensions.radius * 3),
            topLeft: Radius.circular(Dimensions.radius * 3),
          )),
      child: ListView(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        children: [
          TitleHeading2Widget(
            text: Strings.recentTransactions,
            fontWeight: FontWeight.w600,
            fontSize: Dimensions.headingTextSize2 * .85,
          ),
          verticalSpace(Dimensions.marginSizeVertical * .5),
          Get.find<HomeController>().homeModel.data.transactions.isEmpty
              ? const Column(
                  children: [
                    NoDataWidget(),
                  ],
                )
              : ListView.separated(
                  shrinkWrap: true,
                  scrollDirection: Axis.vertical,
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    return Obx(() => TransactionTileWidget(
                      onTap: () {
                        if (Get.find<HomeController>().openTileIndex.value != index) {
                          Get.find<HomeController>().openTileIndex.value = index;
                        } else {
                          Get.find<HomeController>().openTileIndex.value = -1;
                        }
                      },
                      expansion: Get.find<HomeController>().openTileIndex.value == index,
                      inDashboard: true,
                      transaction: Get.find<HomeController>()
                          .homeModel
                          .data
                          .transactions[index],
                    ));
                  },
                  separatorBuilder: (context, i) =>
                      verticalSpace(Dimensions.marginSizeVertical * .3),
                  itemCount: Get.find<HomeController>()
                      .homeModel
                      .data
                      .transactions
                      .length),
        ],
      ),
    );
  }
}
