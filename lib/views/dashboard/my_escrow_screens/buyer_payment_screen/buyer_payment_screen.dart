import 'package:adescrow_app/utils/basic_screen_imports.dart';
import 'package:adescrow_app/utils/responsive_layout.dart';

import '../../../../backend/models/escrow/buyer_payment_index_model.dart';
import '../../../../backend/models/escrow/escrow_create_model.dart';
import '../../../../controller/dashboard/my_escrows/buyer_payment_controller.dart';
import '../../../../widgets/custom_dropdown_widget/custom_dropdown_widget.dart';
import '../../../../widgets/list_tile/text_value_form_widget.dart';
import '../../../../widgets/others/custom_loading_widget.dart';

class BuyerPaymentScreen extends GetView<BuyerPaymentController> {
  const BuyerPaymentScreen({super.key});

  // final controller = Get.put();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: ResponsiveLayout(
        mobileScaffold: Scaffold(
            backgroundColor: Theme.of(context).scaffoldBackgroundColor,
            appBar: const PrimaryAppBar(
              title: Strings.preview,
            ),
            body: Obx(() => controller.isLoading ? const CustomLoadingWidget(): _bodyWidget(context))),
      ),
    );
  }

  _bodyWidget(BuildContext context) {
    return Container(
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
            text: Strings.escrowDetails,
            fontWeight: FontWeight.w600,
            fontSize: Dimensions.headingTextSize2 * .85,
          ),
          verticalSpace(Dimensions.marginSizeVertical * .5),
          _previewEscrowDetailsWidget(context),

          // verticalSpace(Dimensions.marginSizeVertical * 1),
          // TitleHeading2Widget(
          //   text: Strings.paymentDetails,
          //   fontWeight: FontWeight.w600,
          //   fontSize: Dimensions.headingTextSize2 * .85,
          // ),
          // verticalSpace(Dimensions.marginSizeVertical * .5),
          // // _previewPaymentDetailsWidget(context),

          verticalSpace(Dimensions.marginSizeVertical * .5),

          _payWithDropDown(context),

          verticalSpace(Dimensions.marginSizeVertical * .5),

      Obx(() => controller.isSubmitLoading
          ? const CustomLoadingWidget()
          : PrimaryButton(
            title: Strings.confirm,
            onPressed: ()=> controller.onConfirmProcess(context),
          )),
          verticalSpace(Dimensions.paddingSizeVertical * 1.5),
        ],
      ),
    );
  }

  _previewEscrowDetailsWidget(BuildContext context) {
    EscrowInformation data = controller.buyerPaymentIndexModel.data.escrowInformation;
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
            text: Strings.title,
            value: data.title,
          ),
          _divider(),

          TextValueFormWidget(
            text: Strings.myRole,
            value: data.role,
          ),
          _divider(),

          TextValueFormWidget(
            text: Strings.category,
            value: data.category,
          ),
          _divider(),

          TextValueFormWidget(
            text: Strings.amount,
            value: data.amount,
          ),
          _divider(),

          TextValueFormWidget(
            text: Strings.chargePayer,
            currency: data.chargePayer,
          ),
          _divider(),

          TextValueFormWidget(
            text: Strings.totalCharge,
            value: data.totalCharge,
          ),
        ],
      ),
    );
  }

  // _previewPaymentDetailsWidget(BuildContext context) {
  //   EscrowInformation data = controller.escrowSubmitModel.data.escrowInformation;
  //   return Container(
  //     padding: EdgeInsets.symmetric(
  //               horizontal: Dimensions.paddingSizeHorizontal * .7,
  //               vertical: Dimensions.paddingSizeVertical * .7,
  //           ),
  //     decoration: BoxDecoration(
  //         color: Theme.of(context).scaffoldBackgroundColor,
  //         borderRadius: BorderRadius.circular(Dimensions.radius * 1.5)),
  //     child: Column(
  //       crossAxisAlignment: CrossAxisAlignment.end,
  //       children: [
  //
  //         TextValueFormWidget(
  //           text: Strings.feesCharge,
  //           currency: data.fee,
  //         ),
  //         _divider(),
  //
  //         TextValueFormWidget(
  //           text: "${controller.selectedMyRole.value == "Seller" ? "": "${Strings.seller} "}${Strings.willGet}",
  //           currency: data.sellerAmount,
  //         ),
  //         _divider(),
  //
  //         Visibility(
  //           visible: controller.selectedMyRole.value == "Buyer",
  //           child: Column(
  //             children: [
  //               TextValueFormWidget(
  //                 text: Strings.payWith,
  //                 value: data.payWith,
  //               ),
  //               _divider(),
  //             ],
  //           ),
  //         ),
  //
  //
  //         Visibility(
  //           visible: controller.selectedMyRole.value == "Buyer",
  //           child: Column(
  //             children: [
  //               TextValueFormWidget(
  //                 text: Strings.exchangeRate,
  //                 currency: data.exchangeRate,
  //               ),
  //               _divider(),
  //             ],
  //           ),
  //         ),
  //
  //
  //         Visibility(
  //           visible: controller.selectedMyRole.value == "Buyer",
  //           child: TextValueFormWidget(
  //             text: "${controller.selectedMyRole.value == "Buyer" ? "": "${Strings.buyer} "}${Strings.willPay}",
  //             currency: data.buyerAmount,
  //           ),
  //         ),
  //
  //       ],
  //     ),
  //   );
  // }


  _payWithDropDown(BuildContext context) {
    return CustomDropDown<GatewayCurrency>(
      items: controller.selectedPaymentList,
      title: Strings.payWith,
      customTitle:
      "My Wallet: ${controller.buyerPaymentIndexModel.data.userWallet.amount}",
      hint: controller.selectedPaymentMethod.value.isEmpty
          ? "My Wallet: ${controller.buyerPaymentIndexModel.data.userWallet.amount}"
          : controller.selectedPaymentMethod.value,
      onChanged: (value) {
        controller.selectedPaymentMethod.value = value!.title;
        controller.selectedPaymentMethodAlias.value = value.alias;
        controller.selectedPaymentMethodId.value = value.id;
        controller.selectedPaymentMethodTypeId.value = value.mcode;
        controller.selectedPaymentMethodType.value = value.type;
      },
      padding: EdgeInsets.symmetric(
        horizontal: Dimensions.paddingSizeHorizontal * 0.25,
      ),
      titleTextColor: Theme.of(context).primaryColor,
      dropDownColor: Theme.of(context).scaffoldBackgroundColor,
      borderEnable: true,
      dropDownFieldColor: Colors.transparent,
      dropDownIconColor: Theme.of(context).primaryColor,
      border: Border.all(
        color: Theme.of(context).primaryColor.withOpacity(.2),
        width: 1.5,
      ),
    );
  }


  _divider() {
    return Divider(
      color: CustomColor.primaryLightTextColor.withOpacity(.1),
    );
  }
}
