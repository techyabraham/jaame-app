import 'package:adescrow_app/utils/basic_screen_imports.dart';
import 'package:adescrow_app/utils/responsive_layout.dart';

import '../../../../backend/models/escrow/escrow_submit_model.dart';
import '../../../../controller/dashboard/my_escrows/add_new_escrow_controller.dart';
import '../../../../widgets/list_tile/text_value_form_widget.dart';
import '../../../../widgets/others/custom_loading_widget.dart';

class AddNewEscrowPreviewScreen extends GetView<AddNewEscrowController> {
  const AddNewEscrowPreviewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: ResponsiveLayout(
        mobileScaffold: Scaffold(
            backgroundColor: Theme.of(context).scaffoldBackgroundColor,
            appBar: const PrimaryAppBar(
              title: Strings.addNewEscrow,
            ),
            body: _bodyWidget(context)),
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
      child: SingleChildScrollView(
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
            verticalSpace(Dimensions.marginSizeVertical * 1),
            TitleHeading2Widget(
              text: Strings.paymentDetails,
              fontWeight: FontWeight.w600,
              fontSize: Dimensions.headingTextSize2 * .85,
            ),
            verticalSpace(Dimensions.marginSizeVertical * .5),
            _previewPaymentDetailsWidget(context),
            verticalSpace(Dimensions.marginSizeVertical * .5),
            Obx(() => controller.isSubmitLoading
                ? const CustomLoadingWidget()
                : PrimaryButton(
                    prefix: controller.selectedMyRole.value == "Buyer"
                        ? Strings.buyerPay
                        : "",
                    title: controller.selectedMyRole.value == "Buyer"
                        ? Strings.confirmPay
                        : Strings.confirm,
                    suffix: controller.selectedMyRole.value == "Buyer"
                        ? controller
                            .escrowSubmitModel.data.escrowInformation.totalAmount
                        : "",
                    onPressed: () => controller.onConfirmProcess(context),
                  )),
            verticalSpace(Dimensions.paddingSizeVertical * 1.5),
          ],
        ),
      ),
    );
  }

  _previewEscrowDetailsWidget(BuildContext context) {
    EscrowInformation data =
        controller.escrowSubmitModel.data.escrowInformation;
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
            value: data.trx,
          ),
          _divider(),
          TextValueFormWidget(
            text: Strings.title,
            value: data.title,
          ),
          _divider(),
          TextValueFormWidget(
            text: Strings.category,
            value: data.category,
          ),
          _divider(),
          TextValueFormWidget(
            text: Strings.myRole,
            value: data.myRole,
          ),
          _divider(),
          TextValueFormWidget(
            text: Strings.totalAmount,
            currency: data.totalAmount,
          ),
          _divider(),
          TextValueFormWidget(
            text: Strings.chargePayer,
            value: controller.selectedPayBy.value,
          ),
        ],
      ),
    );
  }

  _previewPaymentDetailsWidget(BuildContext context) {
    EscrowInformation data =
        controller.escrowSubmitModel.data.escrowInformation;
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
            text: Strings.feesCharge,
            currency: data.fee,
          ),
          _divider(),
          TextValueFormWidget(
            text:
                controller.selectedMyRole.value == "Seller" ? Strings.willGet :Strings.sellerWillGet,
            currency: data.sellerAmount,
          ),

          Visibility(
              visible: controller.selectedMyRole.value == "Buyer",
              child: _divider()),
          Visibility(
            visible: controller.selectedMyRole.value == "Buyer",
            child: Column(
              children: [
                TextValueFormWidget(
                  text: Strings.payWith,
                  value: data.payWith,
                ),
                _divider(),
              ],
            ),
          ),
          Visibility(
            visible: controller.selectedMyRole.value == "Buyer",
            child: Column(
              children: [
                TextValueFormWidget(
                  text: Strings.exchangeRate,
                  currency: data.exchangeRate,
                ),
                _divider(),
              ],
            ),
          ),
          Visibility(
            visible: controller.selectedMyRole.value == "Buyer",
            child: TextValueFormWidget(
              text:
                  "${controller.selectedMyRole.value == "Buyer" ? "" : "${Strings.buyer} "}${Strings.willPay}",
              currency: data.buyerAmount,
            ),
          ),
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
