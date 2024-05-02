import 'package:adescrow_app/utils/basic_screen_imports.dart';
import 'package:adescrow_app/utils/responsive_layout.dart';
import 'package:adescrow_app/widgets/inputs/password_input_widget.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../../../controller/auth/login_controller.dart';
import '../../../widgets/buttons/secondary_button.dart';
import '../../../widgets/others/app_icon_widget.dart';
import '../../../widgets/others/custom_loading_widget.dart';
import '../../../widgets/text_labels/title_heading5_widget.dart';
import '../../../widgets/text_labels/title_sub_title_widget.dart';

class LoginScreen extends GetView<LoginController> {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: ResponsiveLayout(
        mobileScaffold: Scaffold(
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          // appBar: const PrimaryAppBar(
          //   title: Strings.login,
          //   showBackButton: false,
          // ),
          body: Column(
            children: [

              verticalSpace(Dimensions.heightSize * 2.5),
              const AppIconWidget(),
              verticalSpace(Dimensions.heightSize * 1),
              _bottomBodyWidget(context),
            ],
          ),
        ),
      ),
    );
  }

  _bottomBodyWidget(BuildContext context) {
    return Expanded(
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
            // title subtitle
            SizedBox(
              width: MediaQuery.of(context).size.width,
              child: const TitleSubTitleWidget(
                title: Strings.loginTitle,
                subTitle: Strings.loginSubTitle,
              ),
            ),
            // inputs widgets
            _inputWidget(context),

            // primary button
            Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: Dimensions.paddingSizeHorizontal * .5),
              child: Obx(() => controller.isLoading ? const CustomLoadingWidget(): PrimaryButton(
                title: Strings.login,
                onPressed: controller.onLoginProcess,
              )),
            ),

            verticalSpace(Dimensions.paddingSizeVertical * 1.2),

            //register button
            SecondaryButton(
              text: Strings.register,
              onTap: controller.goToRegisterScreen,
            ),

            verticalSpace(Dimensions.paddingSizeVertical * .3),

            const TitleHeading5Widget(
              text: Strings.dontHaveAnAccount,
              fontWeight: FontWeight.w500,
              textAlign: TextAlign.center,
              opacity: .4,
            ),

            verticalSpace(Dimensions.paddingSizeVertical * 1),
          ],
        ),
      ),
    );
  }

  _inputWidget(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: Dimensions.paddingSizeHorizontal * .7,
        vertical: Dimensions.paddingSizeVertical * .6,
      ),
      margin: EdgeInsets.symmetric(
        horizontal: Dimensions.paddingSizeHorizontal * .7,
        vertical: Dimensions.paddingSizeVertical * .5,
      ),
      decoration: BoxDecoration(
          color: Theme.of(context).scaffoldBackgroundColor,
          borderRadius: BorderRadius.circular(Dimensions.radius * 1.5)),
      child: Form(
        key: controller.formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            PrimaryTextInputWidget(
              controller: controller.emailController,
              labelText: Strings.emailAddress,
            ),
            verticalSpace(Dimensions.marginBetweenInputBox * .8),
            PasswordInputWidget(
              controller: controller.passwordController,
              hintText: Strings.password,
            ),
            verticalSpace(Dimensions.marginBetweenInputBox * .3),
            InkWell(
              onTap: () {
                _showDialog(context);
              },
              child: TitleHeading5Widget(
                text: Strings.forgotPassword,
                fontWeight: FontWeight.w500,
                color: Theme.of(context).primaryColor,
              ),
            )
          ],
        ),
      ),
    );
  }

  void _showDialog(BuildContext context) {
    showDialog(
      context: context,
      barrierColor: CustomColor.primaryLightTextColor.withOpacity(.1),
      builder: (context) {
        return Dialog(
          insetPadding: EdgeInsets.symmetric(
              horizontal: Dimensions.paddingSizeHorizontal * .6),
          backgroundColor: Colors.transparent,
          shadowColor: Colors.transparent,
          surfaceTintColor: Colors.transparent,
          child: Stack(
            children: [
              Container(
                margin: EdgeInsets.symmetric(
                    horizontal: Dimensions.paddingSizeHorizontal * .5,
                    vertical: Dimensions.paddingSizeVertical * .5),
                padding: EdgeInsets.symmetric(
                  horizontal: Dimensions.paddingSizeHorizontal * .8,
                ),
                decoration: BoxDecoration(
                    color: CustomColor.whiteColor,
                    borderRadius: BorderRadius.circular(Dimensions.radius)),
                child: Form(
                  key: controller.forgotPassFormKey,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      verticalSpace(Dimensions.marginSizeVertical * 1),
                      const TitleSubTitleWidget(
                        paddingRatio: 0,
                        title: Strings.forgotPassword,
                        subTitle: Strings.forgotPasswordSubTitle,
                      ),
                      verticalSpace(Dimensions.marginSizeVertical * .5),
                      PrimaryTextInputWidget(
                        controller: controller.forgotEmailController,
                        labelText: Strings.emailAddress,
                      ),
                      verticalSpace(Dimensions.marginSizeVertical * .5),
                      Obx(() => controller.isForgotLoading ? const CustomLoadingWidget(): PrimaryButton(
                        title: Strings.login,
                        onPressed: controller.onForgotPassProcess,
                      )),
                      verticalSpace(Dimensions.paddingSizeVertical * .8)
                    ],
                  ),
                ),
              ),
              Positioned(
                top: 0,
                right: 0,
                child: InkWell(
                  borderRadius: BorderRadius.circular(Dimensions.radius * 10),
                  onTap: () => Get.close(1),
                  child: Animate(
                    effects: const [FadeEffect(), ScaleEffect()],
                    child: CircleAvatar(
                      backgroundColor: Theme.of(context).primaryColor,
                      child: const Icon(Icons.close,
                          color: CustomColor.whiteColor),
                    ),
                  ),
                ),
              )
            ],
          ),
        );
      },
    );
  }
}
