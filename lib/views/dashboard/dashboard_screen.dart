import 'package:adescrow_app/utils/basic_screen_imports.dart';
import 'package:adescrow_app/utils/responsive_layout.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../controller/dashboard/dashboard_controller.dart';
import '../../language/language_drop_down.dart';
import '../../utils/svg_assets.dart';
import '../../widgets/appbar/dashboard_appbar.dart';
import '../../widgets/drawer/drawer_widget.dart';
import '../../widgets/others/app_icon_widget.dart';
import 'nav_buttons_widget.dart';

class DashboardScreen extends GetView<DashboardController> {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    /*
    PopScope(
          canPop: false,
          onPopInvoked: (value){
            debugPrint(value.toString());
            debugPrint(controller.selectedIndex.value.toString());
            if(controller.selectedIndex.value == 0){
              debugPrint("Home");
              SystemNavigator.pop();
            }else{
              debugPrint("Other");
              controller.selectedIndex.value = 0;
            }
          },
     */



    return ResponsiveLayout(
      mobileScaffold: SafeArea(
        // ignore: deprecated_member_use
        child: Obx(() => WillPopScope(
          onWillPop: ()async{
            debugPrint(controller.selectedIndex.value.toString());
            if(controller.selectedIndex.value == 0){
              debugPrint("Home");
              SystemNavigator.pop();
            }else{
              debugPrint("Other");
              controller.selectedIndex.value = 0;
            }
            return false;
          },
          child: Scaffold(
            key: controller.scaffoldKey,
                backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                appBar: DashboardAppBar(
                  title: Container(
                    alignment: Alignment.topCenter,
                    height: controller.selectedIndex.value == 0
                        ? Dimensions.buttonHeight * .6
                        : Dimensions.buttonHeight * .7,
                    width: width * 1,
                    child: controller.selectedIndex.value == 0
                        ? AppIconWidget(
                            height: Dimensions.buttonHeight * .55,
                            width: MediaQuery.sizeOf(context).width * .23,
                          )
                        : Padding(
                          padding: const EdgeInsets.only(top: 10),
                          child: TitleHeading1Widget(
                              text:
                                  controller.bodyText[controller.selectedIndex.value],
                              textAlign: TextAlign.center,
                              fontSize: Dimensions.headingTextSize1 * .85,
                            ),
                        ),
                  ),
                  onMenuTap: () {
                    controller.scaffoldKey.currentState!.openDrawer();
                  },
                  actions: [
                    Visibility(
                      visible: controller.selectedIndex.value == 0,
                      child: Animate(
                        effects: const [FadeEffect(), ScaleEffect()],
                        child: IconButton(
                          onPressed: controller.notificationRoute,
                          icon: SvgPicture.string(
                              SVGAssets.dashboardNotification,
                            height: Dimensions.heightSize * 2.2,
                            width: Dimensions.widthSize * 2.2,
                          ),
                        ),
                      ),
                    ),
                    Visibility(
                      visible: controller.selectedIndex.value == 1,
                      child: IconButton(
                        onPressed: controller.addNewEscrowRoute,
                        icon: Animate(
                          effects: const [FadeEffect(), ScaleEffect()],
                          child: Container(
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Theme.of(context).primaryColor),
                              child: const Icon(Icons.add,
                                  color: CustomColor.whiteColor)),
                        ),
                      ),
                    ),
                    Visibility(
                      visible: controller.selectedIndex.value == 2,
                      child: SizedBox(
                        width: Dimensions.widthSize * 4,
                      ),
                    ),
                    Visibility(
                      visible: controller.selectedIndex.value == 3,
                      child: const ChangeLanguageWidget(
                        isOnboard: true,
                      ),
                    ),
                  ],
                ),
                drawer: DrawerWidget(controller: controller),
                body: Obx(() => controller.body[controller.selectedIndex.value]),
                bottomNavigationBar: _bottomNavWidget(context),
              ),
        )),
      ),
    );
  }

  _bottomNavWidget(BuildContext context) {
    return Container(
      height: Dimensions.buttonHeight * .8,
      decoration: BoxDecoration(
          color: CustomColor.whiteColor,
          boxShadow: [
            BoxShadow(
                color: CustomColor.blackColor.withOpacity(.1),
                offset: const Offset(0, -4),
                blurRadius: 10,
                spreadRadius: -4,
                blurStyle: BlurStyle.outer)
          ],
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(Dimensions.radius * 2),
            topRight: Radius.circular(Dimensions.radius * 2),
          )),
      child: Obx(() => Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              NavButtonWidget(
                onTap: () {
                  controller.selectedIndex.value = 0;
                },
                icon: Icons.other_houses_outlined,
                text: Strings.home,
                isSelected: controller.selectedIndex.value == 0,
              ),
              NavButtonWidget(
                onTap: () {
                  controller.selectedIndex.value = 1;
                },
                icon: Icons.bar_chart,
                text: Strings.myEscrow,
                isSelected: controller.selectedIndex.value == 1,
              ),
              NavButtonWidget(
                onTap: () {
                  controller.selectedIndex.value = 2;
                },
                icon: Icons.account_balance_wallet_outlined,
                text: Strings.myWallet,
                isSelected: controller.selectedIndex.value == 2,
              ),
              NavButtonWidget(
                onTap: () {
                  controller.selectedIndex.value = 3;
                },
                icon: Icons.account_circle_outlined,
                text: Strings.profile,
                isSelected: controller.selectedIndex.value == 3,
              ),
            ],
          )),
    );
  }
}
