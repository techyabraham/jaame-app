import 'package:adescrow_app/utils/basic_screen_imports.dart';
import 'package:adescrow_app/utils/responsive_layout.dart';
import 'package:adescrow_app/widgets/inputs/password_input_widget.dart';
import 'package:adescrow_app/widgets/others/custom_loading_widget.dart';

import '../../../../controller/dashboard/profiles/change_password_controller.dart';

class ChangePassScreen extends GetView<ChangePasswordController> {
  const ChangePassScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: ResponsiveLayout(
        mobileScaffold: Scaffold(
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          appBar: const PrimaryAppBar(
            title: Strings.changePassword,
          ),
          body: _bottomBodyWidget(context),
        ),
      ),
    );
  }

  _bottomBodyWidget(BuildContext context) {
    return Container(
      height: double.infinity,
      width: double.infinity,
      padding: EdgeInsets.symmetric(
          horizontal: Dimensions.paddingSizeHorizontal,
          vertical: Dimensions.paddingSizeVertical),
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
          TitleHeading2Widget(
            text: Strings.addNewPassword,
            fontWeight: FontWeight.w600,
            fontSize: Dimensions.headingTextSize2 * .85,
          ),
          verticalSpace(Dimensions.marginSizeVertical * .5),

          // inputs widgets
          _inputWidget(context),

          verticalSpace(Dimensions.marginSizeVertical * .8),

          // primary button
          Obx(() => controller.isLoading
              ? const CustomLoadingWidget()
              : PrimaryButton(
                  title: Strings.changePassword,
                  onPressed: () => controller.onChangePasswordProcess(context),
                )),

          verticalSpace(Dimensions.paddingSizeVertical * 1.5),
        ],
      ),
    );
  }

  _inputWidget(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
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
            PasswordInputWidget(
              controller: controller.oldPasswordController,
              hintText: Strings.oldPassword,
            ),
            verticalSpace(Dimensions.marginBetweenInputBox * .8),
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
