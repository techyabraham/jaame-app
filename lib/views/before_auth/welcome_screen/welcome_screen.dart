
import 'package:adescrow_app/backend/local_storage/local_storage.dart';
import 'package:adescrow_app/utils/basic_screen_imports.dart';
import 'package:adescrow_app/utils/responsive_layout.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../../../backend/local_auth/local_auth_controller.dart';
import '../../../controller/before_auth/welcome_screen_controller.dart';
import '../../../widgets/others/app_icon_widget.dart';
import '../../../widgets/buttons/circle_svg_button_widget.dart';
import '../../../widgets/text_labels/title_sub_title_widget.dart';

class WelcomeScreen extends GetView<WelcomeController> {
  WelcomeScreen({super.key});

  final biometric = Get.put(BiometricController());

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: ResponsiveLayout(
        mobileScaffold: Scaffold(
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          body: Column(
            children: [
              _upperIconWidget(),
              _bottomBodyWidget(context),
            ],
          ),
        ),
      ),
    );
  }

  _upperIconWidget() {
    return const Expanded(
      flex: 2,
      child: AppIconWidget(),
    );
  }

  _bottomBodyWidget(BuildContext context) {
    return Expanded(
      flex: 5,
      child: Container(
        decoration: BoxDecoration(
            color: CustomColor.whiteColor,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(Dimensions.radius * 3),
              topRight: Radius.circular(Dimensions.radius * 3),
            )),
        child: ListView(
          shrinkWrap: true,
          physics: const BouncingScrollPhysics(),
          children: [
            SizedBox(
              width: MediaQuery.of(context).size.width,
              child: const TitleSubTitleWidget(
                title: Strings.welcomeOnboard,
                subTitle: Strings.welcomeMessage,
              ),
            ),

            verticalSpace(Dimensions.paddingSizeVertical * 6),

            Visibility(
              visible: LocalStorage.isLoggedIn(),
              child: Align(
                alignment: Alignment.center,
                child: SizedBox(
                  height: Dimensions.buttonHeight * 1.6,
                  child: ListView.separated(
                    shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index){
                        return  Obx(()=> CircleSVGButtonWidget(
                          onTap: () {
                            // controller.setIndex(index);
                            biometric.showLocalAuth();
                          },
                          color: controller.selectedIndex.value == index ? CustomColor.primaryLightColor : CustomColor.primaryLightScaffoldBackgroundColor,
                          textColor: controller.selectedIndex.value == index ? CustomColor.primaryLightColor : CustomColor.primaryLightTextColor.withOpacity(.4),
                          name: "",
                          svg: controller.selectedIndex.value == index ? controller.selectedButtonSVG[index] : controller.buttonSVG[index],
                        ));
                      },
                      separatorBuilder: (context, i) => horizontalSpace(Dimensions.paddingSizeHorizontal * .5),
                      itemCount: controller.buttonsName.length
                  ),
                ),
              ),
            ),
            verticalSpace(Dimensions.paddingSizeVertical * 2),

            TextButton(onPressed: controller.loginWithEmail, child: TitleHeading4Widget(
              text: Strings.loginWithEmail,
              fontWeight: FontWeight.w500,
              textAlign: TextAlign.center,
              fontSize: Dimensions.headingTextSize4 * .8,
              opacity: .6,
              color: Theme.of(context).primaryColor,
            ).animate()
                .fadeIn(duration: 900.ms, delay: 300.ms)
                .move(begin: const Offset(-16, 0), curve: Curves.easeOutQuad),)

          ],
        ),
      ),
    );
  }
}
