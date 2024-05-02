import 'package:adescrow_app/utils/basic_screen_imports.dart';
import 'package:adescrow_app/utils/responsive_layout.dart';
import 'package:adescrow_app/widgets/others/custom_loading_widget.dart';

import '../../../controller/auth/register_otp_controller.dart';
import '../../../widgets/buttons/secondary_button.dart';
import '../../../widgets/inputs/pin_code_widget2.dart';
import '../../../widgets/others/app_icon_widget.dart';
import '../../../widgets/text_labels/title_sub_title_widget.dart';

class RegisterOTPScreen extends GetView<RegisterOTPController> {
  const RegisterOTPScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: ResponsiveLayout(
        mobileScaffold: Scaffold(
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          appBar: const PrimaryAppBar(
            title: Strings.otpVerification,
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
                title: Strings.otpVerification,
                subTitle: Strings.otpVerificationSubTitle,
              ),
            ),

            // inputs widgets
            _inputWidget(context),

            verticalSpace(Dimensions.paddingSizeVertical * .3),
            Obx(() => !controller.enableResend.value
                ? Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.watch_later_outlined,
                        size: Dimensions.iconSizeDefault * 1.1,
                        color: Theme.of(context).primaryColor,
                      ),
                      horizontalSpace(Dimensions.widthSize * .5),
                      TitleHeading4Widget(
                        text:
                            "00:${controller.second.value < 10 ? "0${controller.second.value}" : controller.second.value}",
                        color: Theme.of(context).primaryColor,
                      ),
                    ],
                  )
                : SecondaryButton(
                    text: Strings.resend,
                    onTap: controller.resendBTN,
                  )),
            verticalSpace(Dimensions.paddingSizeVertical * .8),

            // primary button
            Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: Dimensions.paddingSizeHorizontal * .5),
              child: Obx(() => controller.isLoading
                  ? const CustomLoadingWidget()
                  : PrimaryButton(
                      title: Strings.submit,
                      onPressed: controller.onOTPSubmitProcess,
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
      alignment: Alignment.center,
      padding: EdgeInsets.only(
        left: Dimensions.paddingSizeHorizontal * .7,
        right: Dimensions.paddingSizeHorizontal * .7,
        top: Dimensions.paddingSizeVertical * .7,
        bottom: Dimensions.paddingSizeVertical * .24,
      ),
      margin: EdgeInsets.symmetric(
        horizontal: Dimensions.paddingSizeHorizontal * .7,
        vertical: Dimensions.paddingSizeVertical * .7,
      ),
      decoration: BoxDecoration(
          color: Theme.of(context).scaffoldBackgroundColor,
          borderRadius: BorderRadius.circular(Dimensions.radius * 1.5)),
      child: PinCodeWidget(
        textController: controller.pinController,
      ),
    );
  }
}
