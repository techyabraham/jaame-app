import 'package:adescrow_app/utils/basic_screen_imports.dart';
import 'package:adescrow_app/utils/responsive_layout.dart';
import 'package:adescrow_app/widgets/others/custom_loading_widget.dart';

import '../../../../controller/dashboard/my_escrows/add_new_escrow_controller.dart';
import '../../../../widgets/others/crypto_address_info_widget.dart';

class EscrowTatumScreen extends StatelessWidget {
  EscrowTatumScreen({super.key});

  final controller = Get.put(AddNewEscrowController());

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: ResponsiveLayout(
        mobileScaffold: Scaffold(
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          appBar: PrimaryAppBar(
            title: controller.selectedPaymentMethod.value,
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
          CryptoAddressInfoWidget(
            address: controller.escrowTatumPaymentModel.data.addressInfo.address,
          ),
          verticalSpace(Dimensions.paddingSizeVertical * 0),
          _inputWidget(context),
          Padding(
            padding: EdgeInsets.symmetric(
                horizontal: Dimensions.paddingSizeHorizontal * .5),
            child: Obx(() => controller.isLoading
                ? const CustomLoadingWidget()
                : PrimaryButton(
                    title: Strings.submit,
                    onPressed: () {
                      if (controller.formKey.currentState!.validate()) {
                        controller.onTatumSubmit(context);
                      }
                    })),
          ),
          verticalSpace(Dimensions.paddingSizeVertical * 1.5)
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
      margin: EdgeInsets.symmetric(
        horizontal: Dimensions.paddingSizeHorizontal * .7,
        vertical: Dimensions.paddingSizeVertical * .7,
      ),
      decoration: BoxDecoration(
          color: Theme.of(context).scaffoldBackgroundColor,
          borderRadius: BorderRadius.circular(Dimensions.radius * 1.5)),
      child: Form(
        key: controller.formManualKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            ...controller.inputFields.map((element) {
              return element;
            }),
          ],
        ),
      ),
    );
  }
}
