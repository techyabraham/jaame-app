import 'package:adescrow_app/utils/basic_screen_imports.dart';
import 'package:adescrow_app/utils/responsive_layout.dart';
import 'package:adescrow_app/widgets/others/custom_loading_widget.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../../../controller/dashboard/btm_navs_controller/profile_controller.dart';
import '../../../controller/dashboard/profiles/update_profile_controller.dart';
import '../../../widgets/dialog_helper.dart';
import '../../../widgets/list_tile/profile_tile_button_widget.dart';
import '../../../widgets/others/profile_image_widget.dart';
import '../../../widgets/buttons/switch_button_widget.dart';

class ProfileScreen extends GetView<ProfileController> {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ResponsiveLayout(
      mobileScaffold: Scaffold(
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          body: Column(
            children: [
              _profilesWidget(context),
              _tilesWidget(context),
            ],
          )),
    );
  }

  _profilesWidget(BuildContext context) {
    return Expanded(
        flex: 1,
        child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  const ProfileImageWidget(
                    isCircle: false,
                  ),
                  verticalSpace(Dimensions.marginSizeVertical * .7),
                  TitleHeading1Widget(
                    text: Get.find<UpdateProfileController>()
                        .profileModel
                        .data
                        .user
                        .fullname,
                    fontSize: Dimensions.headingTextSize1 * .85,
                  ).animate().fadeIn(duration: 900.ms, delay: 300.ms).move(
                      begin: const Offset(-16, 0), curve: Curves.easeOutQuad),
                  verticalSpace(Dimensions.marginSizeVertical * .2),
                  TitleHeading3Widget(
                    text: Get.find<UpdateProfileController>()
                        .profileModel
                        .data
                        .user
                        .email,
                    fontSize: Dimensions.headingTextSize3 * .9,
                    color: Theme.of(context).primaryColor,
                  ).animate().fadeIn(duration: 900.ms, delay: 300.ms).move(
                      begin: const Offset(-16, 0), curve: Curves.easeOutQuad),
                  verticalSpace(Dimensions.marginSizeVertical * .5),
                  SwitchButtonWidget(
                    onTap: (bool value) async{
                      debugPrint(value.toString());
                        await Get.find<UpdateProfileController>().profileSwitch();
                    },
                  ),
                  verticalSpace(Dimensions.marginSizeVertical * .8),
                ],
              ))
    ;
  }

  _tilesWidget(BuildContext context) {
    return Expanded(
        flex: 1,
        child: Container(
          padding: EdgeInsets.symmetric(
            horizontal: Dimensions.paddingSizeHorizontal * 1.5,
            vertical: Dimensions.paddingSizeHorizontal * 1.0,
          ),
          decoration: BoxDecoration(
              color: CustomColor.whiteColor,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(Dimensions.radius * 3),
                topRight: Radius.circular(Dimensions.radius * 3),
              )),
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: AnimateList(
                children: [
                  ProfileTileButtonWidget(
                    onTap: controller.routeUpdateProfile,
                    text: Strings.updateProfile,
                    icon: Icons.account_circle_outlined,
                  ),
                  ProfileTileButtonWidget(
                    onTap: controller.routeUpdateKYC,
                    text: Strings.updateKycForm,
                    icon: Icons.article_outlined,
                  ),
                  ProfileTileButtonWidget(
                    onTap: controller.routeFASecurity,
                    text: Strings.faSecurity,
                    icon: Icons.security_outlined,
                  ),
                  ProfileTileButtonWidget(
                    onTap: controller.routeChangePassword,
                    text: Strings.changePassword,
                    icon: Icons.lock_outline,
                  ),
                  Obx(() => controller.isLoading
                      ? const CustomLoadingWidget()
                      : ProfileTileButtonWidget(
                          onTap: () {
                            DialogHelper.showAlertDialog(context,
                                title: Strings.deleteAccount,
                                content: Strings.deleteAccountContent, onTap: () async{
                              Get.close(1);
                              await controller.deleteProfileProcess();
                            });
                          },
                          text: Strings.deleteAccount,
                          icon: Icons.delete_outlined,
                          isDelete: true,
                        )),
                ],
              ),
            ),
          ),
        ));
  }
}
