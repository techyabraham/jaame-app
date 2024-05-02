import 'package:adescrow_app/utils/basic_screen_imports.dart';
import 'package:adescrow_app/utils/responsive_layout.dart';
import 'package:adescrow_app/widgets/inputs/password_input_widget.dart';
import 'package:adescrow_app/widgets/others/custom_loading_widget.dart';

import '../../../controller/auth/register_controller.dart';
import '../../../widgets/buttons/secondary_button.dart';
import '../../../widgets/buttons/switch_button_basic.dart';
import '../../../widgets/others/app_icon_widget.dart';
import '../../../widgets/text_labels/title_heading5_widget.dart';
import '../../../widgets/text_labels/title_sub_title_widget.dart';
import 'agree_with_widget.dart';

class RegisterScreen extends GetView<RegisterController> {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: ResponsiveLayout(
        mobileScaffold: Scaffold(
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          appBar: const PrimaryAppBar(
            title: Strings.register,
          ),
          body: Column(
            children: [
              const AppIconWidget(),
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
                title: Strings.registerTitle,
                subTitle: Strings.registerSubTitle,
              ),
            ),

            SwitchButtonBasicWidget(
              isScaffold: true,
              onTap: controller.switchValue,
            ),
            // inputs widgets
            _inputWidget(context),

            // primary button
            Padding(
              padding:
                  EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeHorizontal * .5),
              child: Obx(() => controller.isLoading ? const CustomLoadingWidget(): PrimaryButton(
                title: Strings.register,
                onPressed: controller.onRegisterProcess,
              )),
            ),

            verticalSpace(Dimensions.paddingSizeVertical * 1.5),

            //register button
            SecondaryButton(
              text: Strings.login,
              onTap: controller.goToLoginScreen,
            ),

            verticalSpace(Dimensions.paddingSizeVertical * .5),

            const TitleHeading5Widget(
              text: Strings.alreadyHaveAnAccount,
              fontWeight: FontWeight.w500,
              textAlign: TextAlign.center,
              opacity: .4,
            ),

            verticalSpace(Dimensions.paddingSizeVertical * 1.5),
          ],
        ),
      ),
    );
  }

  _inputWidget(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
                horizontal: Dimensions.paddingSizeHorizontal * .7,
                vertical: Dimensions.paddingSizeVertical * .7,
            ),
      margin: EdgeInsets.symmetric(
                horizontal: Dimensions.paddingSizeHorizontal * .7,
                vertical: Dimensions.paddingSizeVertical * .7,
            ),
      decoration: BoxDecoration(
          color: Theme.of(context).scaffoldBackgroundColor,
          borderRadius: BorderRadius.circular(Dimensions.radius * 1.5)),
      child: Form(
        key: controller.formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Row(
              children: [
                Expanded(
                  child: PrimaryTextInputWidget(
                    controller: controller.firstNameController,
                    labelText: Strings.firstName,
                  ),
                ),

                horizontalSpace(Dimensions.marginSizeHorizontal * .5),

                Expanded(
                  child: PrimaryTextInputWidget(
                    controller: controller.lastNameController,
                    labelText: Strings.lastName,
                  ),
                )
              ],
            ),
            verticalSpace(Dimensions.marginBetweenInputBox * .8),
            PrimaryTextInputWidget(
              controller: controller.emailController,
              labelText: Strings.emailAddress,
            ),
            verticalSpace(Dimensions.marginBetweenInputBox * .8),
            PasswordInputWidget(
              controller: controller.passwordController,
              hintText: Strings.password,
            ),

            verticalSpace(Dimensions.marginBetweenInputBox * .6),

            RememberMeWidget(
              controller: controller,
            )
          ],
        ),
      ),
    );
  }
}
