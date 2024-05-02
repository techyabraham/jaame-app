import 'package:adescrow_app/utils/basic_screen_imports.dart';
import 'package:adescrow_app/utils/responsive_layout.dart';
import 'package:adescrow_app/widgets/inputs/password_input_widget.dart';

import '../../../controller/auth/reset_password_controller.dart';
import '../../../widgets/others/app_icon_widget.dart';
import '../../../widgets/others/custom_loading_widget.dart';
import '../../../widgets/text_labels/title_sub_title_widget.dart';

class ResetPassScreen extends GetView<ResetPasswordController> {
  const ResetPassScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: ResponsiveLayout(
        mobileScaffold: Scaffold(
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          body: Column(
            children: [
              verticalSpace(Dimensions.heightSize * 2),
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
                title: Strings.resetPassword,
                subTitle: Strings.resetPasswordSubTitle,
              ),
            ),
            verticalSpace(Dimensions.paddingSizeVertical * 1),

            // inputs widgets
            _inputWidget(context),

            // primary button
            Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: Dimensions.paddingSizeHorizontal * .5
              ),
              child: Obx(() => controller.isForgotLoading ? const CustomLoadingWidget(): PrimaryButton(
                title: Strings.resetPassword,
                onPressed: ()=> controller.onResetPasswordProcess(context),
              )),
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
        borderRadius: BorderRadius.circular(Dimensions.radius * 1.5)
      ),
      child: Form(
        key: controller.formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [

            PasswordInputWidget(
              controller: controller.newPasswordController,
              hintText: Strings.newPassword,
            ),

            verticalSpace(Dimensions.marginBetweenInputBox * .8),

            PasswordInputWidget(
                controller: controller.confirmPasswordController,
                hintText: Strings.confirmPassword,
            ),
          ],
        ),
      ),
    );
  }
}
