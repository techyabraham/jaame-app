import 'package:adescrow_app/utils/basic_screen_imports.dart';
import 'package:adescrow_app/utils/responsive_layout.dart';
import 'package:adescrow_app/widgets/others/custom_loading_widget.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../controller/dashboard/my_wallets/money_exchange_controller.dart';
import '../../../../utils/svg_assets.dart';
import '../../../../widgets/list_tile/text_value_form_widget.dart';

class MoneyExchangePreviewScreen extends GetView<MoneyExchangeController> {
  const MoneyExchangePreviewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: ResponsiveLayout(
        mobileScaffold: Scaffold(
            backgroundColor: Theme.of(context).scaffoldBackgroundColor,
            appBar: const PrimaryAppBar(
              title: Strings.preview,
            ),
            body: _bodyWidget(context)),
      ),
    );
  }

  _bodyWidget(BuildContext context) {
    return Column(
      children: [
        _amountDetails(context),
        verticalSpace(Dimensions.marginSizeVertical * .6),
        _previewDetails(context),
      ],
    );
  }

  _amountDetails(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        horizontal: Dimensions.paddingSizeHorizontal * 1,
        vertical: Dimensions.paddingSizeHorizontal * 1.7,
      ),
      decoration: BoxDecoration(
        color: CustomColor.whiteColor,
        borderRadius: BorderRadius.circular(Dimensions.radius * 3),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          FittedBox(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TitleHeading1Widget(
                  text: controller.fromAmountController.text,
                  fontWeight: FontWeight.bold,
                ),
                horizontalSpace(Dimensions.marginSizeHorizontal * .3),
                TitleHeading1Widget(
                  text: controller.fromSelectedCurrency.value,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).primaryColor,
                ),
                Center(
                    child: Transform.rotate(
                        angle: 1.55,
                        child: Animate(
                          effects: const [FadeEffect(), ScaleEffect()],
                          child: SvgPicture.string(
                            SVGAssets.exchangeScaffoldIcon,
                            height: Dimensions.iconSizeLarge * 1.3,
                            width: Dimensions.iconSizeLarge * 1.3,
                          ),
                        ))),
                TitleHeading1Widget(
                  text: controller.toAmountController.text,
                  fontWeight: FontWeight.bold,
                ),
                horizontalSpace(Dimensions.marginSizeHorizontal * .3),
                TitleHeading1Widget(
                  text: controller.toSelectedCurrency.value,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).primaryColor,
                ),
              ],
            ),
          ),
          verticalSpace(Dimensions.marginSizeVertical * .5),
          TitleHeading4Widget(
            text: Strings.exchangeAmount,
            fontWeight: FontWeight.w400,
            fontSize: Dimensions.headingTextSize4 * .85,
            opacity: .4,
          ),
        ],
      ),
    );
  }

  _previewDetails(BuildContext context) {
    return Expanded(
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.only(
          top: Dimensions.paddingSizeVertical * .8,
          left: Dimensions.paddingSizeHorizontal * .8,
          right: Dimensions.paddingSizeHorizontal * .8,
        ),
        decoration: BoxDecoration(
            color: CustomColor.whiteColor,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(Dimensions.radius * 3),
              topRight: Radius.circular(Dimensions.radius * 3),
            )),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TitleHeading2Widget(
              text: Strings.exchangeDetails,
              fontWeight: FontWeight.w600,
              fontSize: Dimensions.headingTextSize2 * .85,
            ),
            verticalSpace(Dimensions.marginSizeVertical * .5),
            _previewPaymentDetailsWidget(context),
            verticalSpace(Dimensions.marginSizeVertical * .5),
            Obx(() => controller.isLoading
                ? const CustomLoadingWidget()
                : PrimaryButton(
              title: Strings.confirm,
              onPressed: () => controller.onConfirmProcess(context),
            )),
            verticalSpace(Dimensions.paddingSizeVertical * 1.5),
          ],
        ),
      ),
    );
  }

  _previewPaymentDetailsWidget(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
                horizontal: Dimensions.paddingSizeHorizontal * .7,
                vertical: Dimensions.paddingSizeVertical * .7,
            ),
      decoration: BoxDecoration(
          color: Theme.of(context).scaffoldBackgroundColor,
          borderRadius: BorderRadius.circular(Dimensions.radius * 1.5)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          TextValueFormWidget(
            text: Strings.totalCharge,
            value: controller.tCharge.value.toString(),
            currency: controller.fromSelectedCurrency.value,
          ),
          _divider(),
          TextValueFormWidget(
            text: Strings.exchangeRate,
            currency: "1 ${controller.fromSelectedCurrency.value} = ${controller.exchangeRate.value.toStringAsFixed(2)} ${controller.toSelectedCurrency.value}",
          ),
          _divider(),
          TextValueFormWidget(
            text: Strings.totalExchangeAmount,
            value: controller.fromAmountController.text,
            currency: controller.fromSelectedCurrency.value,
          ),
          _divider(),
          TextValueFormWidget(
            text: Strings.convertedAmount,
            value: controller.toAmountController.text,
            currency: controller.toSelectedCurrency.value,
          )
        ],
      ),
    );
  }

  _divider() {
    return Divider(
      color: CustomColor.primaryLightTextColor.withOpacity(.1),
    );
  }
}
