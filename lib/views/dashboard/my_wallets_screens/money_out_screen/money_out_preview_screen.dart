import 'package:adescrow_app/utils/basic_screen_imports.dart';
import 'package:adescrow_app/utils/responsive_layout.dart';
import 'package:adescrow_app/widgets/others/custom_loading_widget.dart';

import '../../../../controller/dashboard/my_wallets/money_out_controller.dart';
import '../../../../widgets/list_tile/text_value_form_widget.dart';

class MoneyOutPreviewScreen extends GetView<MoneyOutController> {
  const MoneyOutPreviewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: ResponsiveLayout(
        mobileScaffold: Scaffold(
            backgroundColor: Theme.of(context).scaffoldBackgroundColor,
            appBar: const PrimaryAppBar(
              title: Strings.preview,
            ),
            body: Obx(() => controller.isLoading
                ? const CustomLoadingWidget()
                : _bodyWidget(context))),
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
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TitleHeading1Widget(
                text: controller.amountController.text,
                fontWeight: FontWeight.bold,
              ),
              horizontalSpace(Dimensions.marginSizeHorizontal * .3),
              TitleHeading1Widget(
                text: controller.selectedCurrency.value,
                fontWeight: FontWeight.bold,
                color: Theme.of(context).primaryColor,
              ),
            ],
          ),
          verticalSpace(Dimensions.marginSizeVertical * .5),
          TitleHeading4Widget(
            text: Strings.enteredAmount,
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
              text: Strings.moneyOutDetails,
              fontWeight: FontWeight.w600,
              fontSize: Dimensions.headingTextSize2 * .85,
            ),
            verticalSpace(Dimensions.marginSizeVertical * .5),
            _previewPaymentDetailsWidget(context),
            verticalSpace(Dimensions.marginSizeVertical * .5),
            PrimaryButton(
              prefix: Strings.moneyOut,
              title: Strings.confirmPay,
              suffix:
              "${controller.amountController.text} ${controller.selectedCurrency.value}",
              onPressed: () => controller.onConfirmProcess(context),
            ),
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
            text: Strings.trxID,
            value: controller.information.trx,
          ),
          _divider(),
          TextValueFormWidget(
            text: Strings.totalCharge,
            value: controller.information.totalCharge,
          ),
          _divider(),
          TextValueFormWidget(
            text: Strings.requestAmount,
            value: controller.information.requestAmount,
          ),
          _divider(),

          TextValueFormWidget(
              text: Strings.willGet,
              value: controller.information.willGet
          ),
          _divider(),
          TextValueFormWidget(
              text: Strings.exchangeRate,
              currency: controller.information.exchangeRate
          ),
          _divider(),
          TextValueFormWidget(
              text: Strings.payWith,
              value: controller.information.gatewayCurrencyName
          ),
          _divider(),
          TextValueFormWidget(
              text: Strings.totalPayable,
              value: controller.information.payable
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
