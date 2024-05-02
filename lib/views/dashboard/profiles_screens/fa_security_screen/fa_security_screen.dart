import 'package:adescrow_app/utils/basic_screen_imports.dart';
import 'package:adescrow_app/utils/responsive_layout.dart';
import 'package:adescrow_app/widgets/others/custom_loading_widget.dart';

import '../../../../controller/dashboard/profiles/fa_security_controller.dart';
import '../../../../widgets/dialog_helper.dart';
import '../../../../widgets/others/custom_cached_network_image.dart';
import '../../../../widgets/text_labels/title_sub_title_widget.dart';

class FASecurityScreen extends GetView<FASecurityController> {
  const FASecurityScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: ResponsiveLayout(
        mobileScaffold: Scaffold(
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          appBar: const PrimaryAppBar(
            title: Strings.faSecurity,
          ),
          body: Obx(() => controller.isLoading
              ? const CustomLoadingWidget()
              : Column(
                  children: [
                    verticalSpace(Dimensions.marginSizeVertical),
                    Container(
                      // width: MediaQuery.of(context).size.width * .8,
                      height: MediaQuery.of(context).size.height * .32,
                      width: MediaQuery.sizeOf(context).width * .8,
                      margin: EdgeInsets.symmetric(
                          horizontal: Dimensions.paddingSizeHorizontal * 2.4,
                          vertical: Dimensions.paddingSizeVertical * .5),
                      // padding: EdgeInsets.symmetric(
                      // horizontal: Dimensions.paddingSizeHorizontal,
                      // vertical: Dimensions.paddingSizeVertical,
                      decoration: BoxDecoration(
                        color: CustomColor.whiteColor,
                        borderRadius:
                            BorderRadius.circular(Dimensions.radius * 1.5),
                      ),
                      child: CustomCachedNetworkImage(
                        imageUrl: controller.twoFaInfoModel.data.qrCode,
                      ),
                    ),
                    verticalSpace(Dimensions.marginSizeVertical),
                    _bottomBodyWidget(context),
                  ],
                )),
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
              child: TitleSubTitleWidget(
                fromStart: true,
                title: controller.twoFaInfoModel.data.qrStatus == 1
                    ? Strings.disableTwoFa
                    : Strings.enableTwoFa,
                subTitle: controller.twoFaInfoModel.data.alert,
              ),
            ),

            // primary button
            Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: Dimensions.paddingSizeHorizontal * .5),
              child: PrimaryButton(
                  title: controller.twoFaInfoModel.data.qrStatus == 1
                      ? Strings.disable
                      : Strings.enable,
                  onPressed: () {
                    DialogHelper.showAlertDialog(context,
                        title: controller.twoFaInfoModel.data.qrStatus == 1
                            ? Strings.disable
                            : Strings.enable,
                        content: controller.twoFaInfoModel.data.qrStatus == 1
                            ? Strings.faDisableAlert
                            : Strings.faEnableAlert,
                        onTap: controller.onFASubmitProcess);
                  }),
            ),
          ],
        ),
      ),
    );
  }
}
