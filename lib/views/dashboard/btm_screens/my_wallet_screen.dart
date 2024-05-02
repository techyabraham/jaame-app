import 'package:adescrow_app/backend/services/api_endpoint.dart';
import 'package:adescrow_app/utils/basic_screen_imports.dart';
import 'package:adescrow_app/utils/responsive_layout.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../../../backend/models/dashboard/home_model.dart';
import '../../../bindings/on_refresh.dart';
import '../../../controller/dashboard/btm_navs_controller/my_wallet_controller.dart';
import '../../../extensions/custom_extensions.dart';
import '../../../widgets/others/custom_loading_widget.dart';

class MyWalletScreen extends GetView<MyWalletController> {
  const MyWalletScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    return ResponsiveLayout(
      mobileScaffold: Scaffold(
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          body: Obx(() => controller.walletsController.isLoading
              ? const CustomLoadingWidget()
              : RefreshIndicator(
                  backgroundColor: Theme.of(context).primaryColor,
                  color: CustomColor.whiteColor,
                  onRefresh: onRefresh,
                  child: ListView(
                    physics: const BouncingScrollPhysics(),
                    children: [
                      Container(
                        height: height * .85,
                        width: width,
                        padding: EdgeInsets.only(
                          top: Dimensions.paddingSizeVertical * .8,
                          left: Dimensions.paddingSizeHorizontal * .8,
                          right: Dimensions.paddingSizeHorizontal * .8,
                        ),
                        decoration: BoxDecoration(
                            color: CustomColor.whiteColor,
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(Dimensions.radius * 3),
                              topRight: Radius.circular(Dimensions.radius * 3),
                            )),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            TitleHeading2Widget(
                              text: Strings.availableWallet,
                              fontWeight: FontWeight.w600,
                              fontSize: Dimensions.headingTextSize2 * .85,
                            ),
                            verticalSpace(Dimensions.marginSizeVertical * .5),
                            Expanded(
                                child: GridView.count(
                              crossAxisSpacing:
                                  Dimensions.paddingSizeHorizontal * .2,
                              mainAxisSpacing:
                                  Dimensions.paddingSizeVertical * .2,
                              physics: const BouncingScrollPhysics(),
                              padding: EdgeInsets.only(
                                bottom: Dimensions.paddingSizeVertical * .8,
                              ),
                              crossAxisCount: 2,
                              childAspectRatio: 2.65,
                              scrollDirection: Axis.vertical,
                              shrinkWrap: true,
                              children: List.generate(
                                  controller.walletsController.homeModel.data
                                      .userWallet.length,
                                  (index) => _gridViewWidget(context, index)),
                            ))
                          ],
                        ),
                      ),
                    ],
                  ),
                ))),
    );
  }

  _gridViewWidget(BuildContext context, int index) {
    UserWallet data =
        controller.walletsController.homeModel.data.userWallet[index];
    return InkWell(
      onTap: () {
        controller.routeCurrentBalanceScreen(index, data);
      },
      child: Container(
        // width: double.infinity,
        padding: EdgeInsets.symmetric(
            horizontal: Dimensions.paddingSizeHorizontal * .3,
            vertical: Dimensions.paddingSizeVertical * .4),
        decoration: BoxDecoration(
            color: Theme.of(context).scaffoldBackgroundColor,
            borderRadius: BorderRadius.circular(Dimensions.radius)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Animate(
              effects: const [FadeEffect(), ScaleEffect()],
              child: Container(
                // height: Dimensions.buttonHeight * .8,
                width: Dimensions.widthSize * 3.1,
                margin: EdgeInsets.symmetric(
                    vertical: Dimensions.paddingSizeVertical * .18),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(Dimensions.radius * 1),
                    image: DecorationImage(
                        image: NetworkImage(
                          "${ApiEndpoint.mainDomain}/${data.imagePath}/${data.flag}",
                        ),
                        fit: BoxFit.fill)),
              ),
            ),
            horizontalSpace(Dimensions.marginSizeHorizontal * .3),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  TitleHeading2Widget(
                    text: makeBalance(
                        data.balance.toString(), data.currencyType == "FIAT" ? 2 : 6),
                    fontSize: Dimensions.headingTextSize2 * .7,
                  ),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    physics: const BouncingScrollPhysics(),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        TitleHeading4Widget(
                          text: data.name,
                          fontSize: Dimensions.headingTextSize4 * .7,
                          opacity: .4,
                        ),
                        TitleHeading4Widget(
                          text: " - ",
                          fontSize: Dimensions.headingTextSize4 * .5,
                          opacity: .4,
                        ),
                        TitleHeading4Widget(
                          text: data.currencyCode,
                          fontSize: Dimensions.headingTextSize4 * .7,
                          color: Theme.of(context).primaryColor,
                        ),
                      ],
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  /*
  Container(
                      height: Dimensions.buttonHeight * 1.4,
                      width: Dimensions.widthSize * 22,
                      padding: EdgeInsets.all(Dimensions.paddingSize * .8),
                      decoration: BoxDecoration(
                          color: Theme.of(context).scaffoldBackgroundColor,
                          borderRadius: BorderRadius.circular(Dimensions.radius)),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Image.asset(flag[index]["img"]),
                          horizontalSpace(Dimensions.marginSizeHorizontal * .5),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              TitleHeading2Widget(
                                text: flag[index]["value"],
                                fontSize: Dimensions.headingTextSize2 * .85,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  TitleHeading4Widget(
                                    text: flag[index]["name"],
                                    fontSize: Dimensions.headingTextSize4 * .85,
                                    opacity: .4,
                                  ),
                                  TitleHeading4Widget(
                                    text: " - ",
                                    fontSize: Dimensions.headingTextSize4 * .85,
                                    opacity: .4,
                                  ),
                                  TitleHeading4Widget(
                                    text: flag[index]["currency"],
                                    fontSize: Dimensions.headingTextSize4 * .85,
                                    color: Theme.of(context).primaryColor,
                                  ),
                                ],
                              )
                            ],
                          )
                        ],
                      ),
                    )
   */
}
