import 'dart:io';

import 'package:adescrow_app/utils/basic_screen_imports.dart';
import 'package:adescrow_app/utils/responsive_layout.dart';
import 'package:adescrow_app/widgets/others/custom_loading_widget.dart';

import '../../../../backend/models/escrow/escrow_create_model.dart';
import '../../../../controller/dashboard/my_escrows/add_new_escrow_controller.dart';
import '../../../../language/language_controller.dart';
import '../../../../widgets/custom_dropdown_widget/custom_dropdown_widget.dart';
import '../../../../widgets/others/custom_upload_file_widget.dart';
import '../../../../widgets/text_labels/title_heading5_widget.dart';

class AddNewEscrowScreen extends GetView<AddNewEscrowController> {
  const AddNewEscrowScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: ResponsiveLayout(
        mobileScaffold: Scaffold(
            backgroundColor: Theme.of(context).scaffoldBackgroundColor,
            appBar: const PrimaryAppBar(
              title: Strings.addNewEscrow,
            ),
            body: Obx(() => controller.isLoading
                ? const CustomLoadingWidget()
                : _bodyWidget(context))),
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
          Expanded(child: ListView(
            shrinkWrap: true,
            physics: const BouncingScrollPhysics(),
            children: [
              _inputWidget(context),
              verticalSpace(Dimensions.marginBetweenInputBox * 1),
              Obx(() => controller.isSubmitLoading
                  ? const CustomLoadingWidget()
                  : PrimaryButton(
                      title: Strings.addNewEscrow,
                      onPressed: controller.onAddNewEscrowProcess,
                    )),
              verticalSpace(Dimensions.paddingSizeVertical * 1.5),
            ],
          )),
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
            PrimaryTextInputWidget(
              controller: controller.titleController,
              labelText: Strings.title,
            ),
            verticalSpace(Dimensions.marginBetweenInputBox * .8),
            _categoryDropDown(context),
            _myRoleDropDown(context),
            _payByDropDown(context),
            PrimaryTextInputWidget(
              controller: controller.emailController,
              labelText: Strings.userNameOrEmail,
              onChanged: (value) async{
                await controller.escrowUserCheck(value);
              },
              suffixIcon: Obx(() => Visibility(
                visible: controller.user.value.isNotEmpty,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      height: Dimensions.inputBoxHeight * .77,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          color: controller.isValidUser.value
                              ? Theme.of(context).primaryColor.withOpacity(.3)
                              : Colors.red.withOpacity(.3),
                          borderRadius: BorderRadius.only(
                            topRight: Radius.circular(Get.find<LanguageSettingController>().selectedLanguage.value.contains("ar") ? 0: Dimensions.radius * .5),
                            topLeft: Radius.circular(Get.find<LanguageSettingController>().selectedLanguage.value.contains("ar") ? Dimensions.radius * .5: 0),
                            bottomRight: Radius.circular(Get.find<LanguageSettingController>().selectedLanguage.value.contains("ar") ? 0: Dimensions.radius * .5),
                            bottomLeft: Radius.circular(Get.find<LanguageSettingController>().selectedLanguage.value.contains("ar") ? Dimensions.radius * .5: 0),
                          )),
                      child: TitleHeading5Widget(
                        text: controller.isValidUser.value
                            ? Strings.validUser
                            : Strings.invalidUser,
                        padding: EdgeInsets.symmetric(
                          horizontal: Dimensions.paddingSizeHorizontal * .35
                        ),
                        color: controller.isValidUser.value
                            ? Theme.of(context).primaryColor
                            : Colors.red,
                      ),
                    ),
                  ],
                ),
              )),
            ),
            verticalSpace(Dimensions.marginBetweenInputBox * .8),
            PrimaryTextInputWidget(
              controller: controller.amountController,
              labelText: Strings.amount.tr,
              hint: "0.00",
              suffixIcon: Container(
                padding: EdgeInsets.zero,
                margin: EdgeInsets.zero,
                width: Dimensions.widthSize * 9.5,
                decoration: BoxDecoration(
                    color: Theme.of(context).primaryColor,
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(Get.find<LanguageSettingController>().selectedLanguage.value.contains("ar") ? 0: Dimensions.radius * .5),
                      topLeft: Radius.circular(Get.find<LanguageSettingController>().selectedLanguage.value.contains("ar") ? Dimensions.radius * .5: 0),
                      bottomRight: Radius.circular(Get.find<LanguageSettingController>().selectedLanguage.value.contains("ar") ? 0: Dimensions.radius * .5),
                      bottomLeft: Radius.circular(Get.find<LanguageSettingController>().selectedLanguage.value.contains("ar") ? Dimensions.radius * .5: 0),
                    )),
                child: _currencyDropDown(context),
              ),
            ),
            verticalSpace(Dimensions.marginBetweenInputBox * .8),
            PrimaryTextInputWidget(
              controller: controller.remarksController,
              labelText: Strings.remarks.tr,
              hint: Strings.writeHere.tr,
              optional: Strings.optional,
              maxLine: 4,

            ),
            verticalSpace(Dimensions.marginBetweenInputBox * .8),
            CustomUploadFileWidget(
              labelText: Strings.attachments,
              optional: Strings.optional,
              hint: "(Supported files jpg, jpeg, png, pdf, zip)",
              onTap: (File value) {
                debugPrint(value.path);
                controller.selectedFilePath.value = value.path;
              },
            ),
            verticalSpace(Dimensions.marginBetweenInputBox * .8),
            _payWithDropDown(context),
          ],
        ),
      ),
    );
  }

  _categoryDropDown(BuildContext context) {
    return Column(
      children: [
        Obx(() => CustomDropDown<EscrowCategory>(
              items: controller.escrowIndexModel.data.escrowCategories,
              title: Strings.category,
              hint: controller.selectedCategory.value.isEmpty
                  ? Strings.selectIDType
                  : controller.selectedCategory.value,
              onChanged: (value) {
                controller.selectedCategory.value = value!.title;
                controller.selectedCategoryId.value = value.id;
              },
              padding: EdgeInsets.symmetric(
                horizontal: Dimensions.paddingSizeHorizontal * 0.25,
              ),
              titleTextColor: controller.selectedCategory.value.isEmpty
                  ? CustomColor.primaryLightTextColor.withOpacity(.2)
                  : Theme.of(context).primaryColor,
              dropDownColor: Theme.of(context).scaffoldBackgroundColor,
              borderEnable: true,
              dropDownFieldColor: Colors.transparent,
              dropDownIconColor: controller.selectedCategory.value.isEmpty
                  ? CustomColor.primaryLightTextColor.withOpacity(.2)
                  : Theme.of(context).primaryColor,
              border: Border.all(
                color: Theme.of(context).primaryColor.withOpacity(.2),
                width: 1.5,
              ),
            )),
        verticalSpace(Dimensions.marginBetweenInputBox * .8),
      ],
    );
  }

  _myRoleDropDown(BuildContext context) {
    return Column(
      children: [
        Obx(() => CustomDropDown<EscrowStaticModel>(
              items: controller.myRoleList,
              title: Strings.myRole,
              hint: controller.selectedMyRole.value.isEmpty
                  ? Strings.selectMyRole
                  : controller.selectedMyRole.value,
              onChanged: (value) {
                controller.selectedMyRole.value = value!.title;
                controller.selectedOppositeRole.value = value.title == "Buyer" ? "Seller" : "Buyer";
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
            )),
        verticalSpace(Dimensions.marginBetweenInputBox * .8),
      ],
    );
  }

  _payByDropDown(BuildContext context) {
    return Column(
      children: [
        Obx(() => CustomDropDown<EscrowStaticModel>(
              items: controller.payByList,
              title: Strings.whoWillPayTheFees,
              customTitle: controller.selectedOppositeRole.value,
              hint: controller.selectedPayBy.value.isEmpty
                  ? controller.selectedOppositeRole.value
                  : controller.selectedPayBy.value,
              onChanged: (value) {
                controller.selectedPayBy.value = value!.title;
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
            )),
        verticalSpace(Dimensions.marginBetweenInputBox * .8),
      ],
    );
  }

  _payWithDropDown(BuildContext context) {
    return Obx(() => Visibility(
          visible: controller.selectedMyRole.value == "Buyer",
          child: CustomDropDown<GatewayCurrency>(
            margin: const EdgeInsets.symmetric(
              horizontal: 0
            ),
            items: controller.selectedPaymentList,
            title: Strings.payWith,
            customTitle:
                "My Wallet: ${controller.selectedCurrencyBalance} ${controller.selectedCurrency}",
            hint: controller.selectedPaymentMethod.value.isEmpty
                ? "My Wallet: ${controller.selectedCurrencyBalance} ${controller.selectedCurrency}"
                : controller.selectedPaymentMethod.value,
            onChanged: (value) {
              controller.selectedPaymentMethod.value = value!.title;
              controller.selectedPaymentMethodAlias.value = value.alias;
              controller.selectedPaymentMethodId.value = value.id;
              controller.selectedPaymentMethodTypeId.value = value.mcode;
              controller.selectedPaymentMethodType.value = value.type;
            },
            padding: EdgeInsets.symmetric(
              horizontal: Dimensions.paddingSizeHorizontal * 0,
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
          ),
        ));
  }

  _currencyDropDown(BuildContext context) {
    return Obx(() => CustomDropDown<UserWallet>(
          items: controller.escrowIndexModel.data.userWallet,
          hint: controller.selectedCurrency.value,
          onChanged: (value) {
            controller.selectedCurrency.value = value!.title;
            controller.selectedCurrencyType.value = value.type;
            controller.selectedCurrencyBalance.value =
                value.max.toStringAsFixed(value.type == "FIAT" ? 2 : 6);
          },
      margin: EdgeInsets.zero,
          padding: EdgeInsets.symmetric(
            horizontal: Dimensions.paddingSizeHorizontal * 0,
            vertical: 0
          ),
      isCurrencyDropDown: true,
          titleTextColor: CustomColor.whiteColor,
          dropDownColor: Theme.of(context).primaryColor,
          borderEnable: true,
          dropDownFieldColor: Theme.of(context).primaryColor,
          dropDownIconColor: CustomColor.whiteColor,
          border: Border.all(
            color: Theme.of(context).primaryColor,
          ),
        ));
  }
}
