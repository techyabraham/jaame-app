import 'package:adescrow_app/controller/dashboard/dashboard_controller.dart';
import 'package:adescrow_app/widgets/others/custom_loading_widget.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../../backend/services/api_endpoint.dart';
import '../../controller/dashboard/profiles/update_profile_controller.dart';
import '../../language/language_controller.dart';
import '../../utils/basic_widget_imports.dart';
import '../../views/web_view/web_view_screen.dart';
import '../dialog_helper.dart';
import '../list_tile/drawer_tile_button_widget.dart';
import '../others/app_icon_widget.dart';
import '../others/profile_image_widget.dart';

class DrawerWidget extends StatelessWidget {
  const DrawerWidget({super.key, required this.controller});

  final DashboardController controller;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.sizeOf(context).width * .7,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
              topRight: Radius.circular(Dimensions.radius * 2)),
          color: CustomColor.drawerBGLightColor),
      child: Drawer(
        backgroundColor: CustomColor.drawerBGLightColor,
        child: Obx(() => Get.find<UpdateProfileController>().isLoading
            ? const CustomLoadingWidget()
            : _allItemListView(context)),
      ),
    );
  }

  _drawerItems(BuildContext context) {
    return Column(
      children: AnimateList(children: [
        verticalSpace(Dimensions.marginSizeVertical * 1),
        const ProfileImageWidget(
          isCircle: true,
        ),
        verticalSpace(Dimensions.marginSizeVertical * .5),
        TitleHeading2Widget(
          text: Get.find<UpdateProfileController>()
              .profileModel
              .data
              .user
              .fullname,
          fontSize: Dimensions.headingTextSize2 * .85,
        )
            .animate()
            .fadeIn(duration: 900.ms, delay: 300.ms)
            .move(begin: const Offset(-16, 0), curve: Curves.easeOutQuad),
        verticalSpace(Dimensions.marginSizeVertical * .2),
        TitleHeading4Widget(
          text:
              Get.find<UpdateProfileController>().profileModel.data.user.email,
          fontSize: Dimensions.headingTextSize4 * .9,
          opacity: .4,
        )
            .animate()
            .fadeIn(duration: 900.ms, delay: 300.ms)
            .move(begin: const Offset(-16, 0), curve: Curves.easeOutQuad),
        verticalSpace(Dimensions.marginSizeVertical * 1),
        DrawerTileButtonWidget(
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const WebViewScreen(
                          appTitle: Strings.helpCenter,
                          link: "${ApiEndpoint.mainDomain}/contact-us",
                        )));
          },
          text: Strings.helpCenter,
          icon: Icons.help_outline_rounded,
        ),
        DrawerTileButtonWidget(
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const WebViewScreen(
                          appTitle: Strings.privacyPolicy,
                          link: "${ApiEndpoint.mainDomain}/page/privacy-policy",
                        )));
          },
          text: Strings.privacyPolicy,
          icon: Icons.privacy_tip_outlined,
        ),
        DrawerTileButtonWidget(
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const WebViewScreen(
                          appTitle: Strings.aboutUs,
                          link: "${ApiEndpoint.mainDomain}/about-us",
                        )));
          },
          text: Strings.aboutUs,
          icon: Icons.info_outline,
        ),
        Obx(() => controller.isLoading
            ? const CustomLoadingWidget()
            : DrawerTileButtonWidget(
                onTap: () {
                  DialogHelper.showAlertDialog(context,
                      title: Strings.logout,
                      content: Strings.logOutContent, onTap: () async {
                    Get.close(1);
                    await controller.logOutProcess();
                  });
                },
                text: Strings.logout,
                icon: Icons.power_settings_new_outlined,
              )),
        verticalSpace(Dimensions.marginSizeVertical * .2),
      ]),
    );
  }

  _allItemListView(BuildContext context) {
    return Stack(
      children: [
        Positioned(
            // top: MediaQuery.of(context).size.height * .17,
            left: 0,
            bottom: -60,
            child: Align(
              alignment: Alignment.centerLeft,
              child: SizedBox(
                width: MediaQuery.sizeOf(context).width * .8,
                child: Opacity(
                  opacity: .1,
                  child: Image.asset(
                    "assets/logo/app_launcher.jpg",
                    alignment: Alignment.centerRight,
                    width: MediaQuery.sizeOf(context).width * 1,
                    height: MediaQuery.sizeOf(context).height * .72,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            )),
        ListView(
          physics: const BouncingScrollPhysics(),
          children: [
            verticalSpace(Dimensions.heightSize * .2),
            SizedBox(
              height: MediaQuery.sizeOf(context).height * .07,
              child: Stack(
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: IconButton(
                      onPressed: () => Get.close(1),
                      icon: Transform.rotate(
                        angle: Get.find<LanguageSettingController>().selectedLanguage.value.contains("ar") ? 3.14 : 0,
                        child: Icon(
                          Icons.arrow_back,
                          size: Dimensions.iconSizeDefault * 1.2,
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    top: 0,
                    left: 1,
                    right: 1,
                    child: AppIconWidget(
                      height: MediaQuery.sizeOf(context).height * .06,
                      width: MediaQuery.sizeOf(context).width * .4,
                    ),
                  ),
                ],
              ),
            ),
            _drawerItems(context),
          ],
        ),
      ],
    );
  }
}
