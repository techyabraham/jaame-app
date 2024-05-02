import 'package:adescrow_app/backend/backend_utils/custom_snackbar.dart';
import 'package:adescrow_app/utils/basic_screen_imports.dart';
import 'package:adescrow_app/utils/responsive_layout.dart';
import 'package:adescrow_app/widgets/others/custom_loading_widget.dart';
import 'package:adescrow_app/widgets/text_labels/title_heading5_widget.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../backend/models/money_exchange/money_exchange_index_model.dart';
import '../../../../controller/dashboard/my_wallets/money_exchange_controller.dart';
import '../../../../language/language_controller.dart';
import '../../../../utils/svg_assets.dart';
import '../../../../widgets/custom_dropdown_widget/custom_dropdown_widget.dart';

class MoneyExchangeScreen extends GetView<MoneyExchangeController> {
  const MoneyExchangeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        color: Theme.of(context).scaffoldBackgroundColor,
        child: Stack(
          children: [
            Container(
              height: MediaQuery.of(context).size.height * .27,
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(Dimensions.radius * 3),
                    bottomRight: Radius.circular(Dimensions.radius * 3),
                  )),
            ),
            ResponsiveLayout(
              mobileScaffold: Scaffold(
                  backgroundColor: Colors.transparent,
                  appBar: const PrimaryAppBar(
                    title: Strings.exchange,
                  ),
                  body: Obx(() => controller.isLoading
                      ? const CustomLoadingWidget()
                      : Column(
                          children: [
                            _infoWidget(context),
                            _inputWidget(context),
                          ],
                        ))),
            ),
          ],
        ),
      ),
    );
  }

  _infoWidget(BuildContext context) {
    return Expanded(
      flex: 1,
      child: Container(
        width: double.infinity,
        alignment: Alignment.center,
        padding: EdgeInsets.symmetric(
            horizontal: Dimensions.paddingSizeHorizontal * .5),
        margin: EdgeInsets.only(
          bottom: Dimensions.paddingSizeVertical * 1.8,
          top: Dimensions.paddingSizeVertical * .5,
          left: Dimensions.paddingSizeHorizontal,
          right: Dimensions.paddingSizeHorizontal,
        ),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(Dimensions.radius * 1.5),
            color: Theme.of(context).scaffoldBackgroundColor),
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // verticalSpace(Dimensions.paddingSizeVertical * 1),
              Obx(() => FittedBox(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const TitleHeading1Widget(
                          text: "1",
                          fontWeight: FontWeight.bold,
                        ),
                        horizontalSpace(Dimensions.marginSizeHorizontal * .3),
                        TitleHeading1Widget(
                          text: controller.fromSelectedCurrency.value,
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).primaryColor,
                        ),
                        TitleHeading1Widget(
                          text: "=",
                          padding: EdgeInsets.symmetric(
                              horizontal: Dimensions.marginSizeHorizontal * .3),
                          fontWeight: FontWeight.bold,
                        ),
                        TitleHeading1Widget(
                          text: controller.exchangeRate.value.toStringAsFixed(
                              controller.toSelectedCurrencyType.value == "FIAT"
                                  ? 2
                                  : 6),
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
                  )),
              verticalSpace(Dimensions.marginSizeVertical * .3),
              TitleHeading4Widget(
                text: Strings.exchangeRate,
                fontWeight: FontWeight.w400,
                fontSize: Dimensions.headingTextSize4 * .85,
                opacity: .4,
              ),
            ],
          ),
        ),
      ),
    );
  }

  _inputWidget(BuildContext context) {
    return Expanded(
      flex: 3,
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(
          horizontal: Dimensions.paddingSizeHorizontal * .85,
          vertical: Dimensions.paddingSizeHorizontal * .85,
        ),
        decoration: BoxDecoration(
            color: CustomColor.whiteColor,
            borderRadius: BorderRadius.only(
              topRight: Radius.circular(Dimensions.radius * 3),
              topLeft: Radius.circular(Dimensions.radius * 3),
            )),
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                alignment: Alignment.center,
                children: [
                  Column(
                    children: [
                      _fromWidget(context),
                      verticalSpace(Dimensions.marginSizeVertical * .5),
                      _toWidget(context),
                    ],
                  ),
                  Center(
                      child: Animate(
                          effects: const [FadeEffect(), ScaleEffect()],
                          child: SvgPicture.string(
                            SVGAssets.exchangeWhiteIcon,
                            height: Dimensions.heightSize * 4.2,
                            width: Dimensions.widthSize * 4.2,
                          )))
                ],
              ),
              verticalSpace(Dimensions.marginSizeVertical * .4),


              Obx(() => Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _infoTextWidget(context, name: Strings.limit, value: '${controller.min.value} - ${controller.max.value} ${controller.fromSelectedCurrency.value}'),
                  _infoTextWidget(context, name: Strings.charge, value: '${controller.fCharge.value.toStringAsFixed(controller.fromSelectedCurrencyType.value == "FIAT" ? 2 : 6)} ${controller.fromSelectedCurrency.value} + ${controller.moneyExchangeModel.data.charges.percentCharge}% = ${controller.tCharge.value.toStringAsFixed(controller.fromSelectedCurrencyType.value == "FIAT" ? 2 : 6)} ${controller.fromSelectedCurrency.value}'),

                ],
              )),
              verticalSpace(Dimensions.marginSizeVertical * .8),
              PrimaryButton(
                title: Strings.exchangeCurrency,
                onPressed: () {
                  if (controller.fromSelectedCurrency.value !=
                      controller.toSelectedCurrency.value) {
                    controller.onExchangeBTNProcess(context);
                  } else {
                    CustomSnackBar.error(Strings.exchangeMSG);
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  _infoTextWidget(BuildContext context,
      {required String name, required String value}) {
    return Row(
      children: [
        TitleHeading5Widget(
          text: name,
          textAlign: TextAlign.center,
          color: Theme.of(context).primaryColor.withOpacity(.8),
          fontWeight: FontWeight.w500,
          fontSize: Dimensions.headingTextSize5 * .89,
        ),
        TitleHeading5Widget(
          text: ": ",
          textAlign: TextAlign.center,
          color: Theme.of(context).primaryColor.withOpacity(.8),
          fontWeight: FontWeight.w500,
          fontSize: Dimensions.headingTextSize5 * .89,
        ),
        Directionality(
          textDirection: TextDirection.ltr,
          child: TitleHeading5Widget(
            text: value,
            textAlign: TextAlign.center,
            color: Theme.of(context).primaryColor,
            fontWeight: FontWeight.w600,
            fontSize: Dimensions.headingTextSize5 * .85,
          ),
        ),
      ],
    );
  }

  _fromWidget(BuildContext context) {
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
          PrimaryTextInputWidget(
            controller: controller.fromAmountController,
            labelText: Strings.from.tr,
            keyboardType: TextInputType.number,
            hint: "0.00",
            onChanged: (value) {
              controller.calculateExchangeRate();
            },
            suffixIcon: Container(
              // height: Dimensions.inputBoxHeight * 0.69,
              width: Dimensions.widthSize * 9.5,
              decoration: BoxDecoration(
                  color: Theme.of(context).primaryColor,
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(Get.find<LanguageSettingController>().selectedLanguage.value.contains("ar") ? 0: Dimensions.radius * .5),
                    topLeft: Radius.circular(Get.find<LanguageSettingController>().selectedLanguage.value.contains("ar") ? Dimensions.radius * .5: 0),
                    bottomRight: Radius.circular(Get.find<LanguageSettingController>().selectedLanguage.value.contains("ar") ? 0: Dimensions.radius * .5),
                    bottomLeft: Radius.circular(Get.find<LanguageSettingController>().selectedLanguage.value.contains("ar") ? Dimensions.radius * .5: 0),
                  )),
              child: _fromCurrencyDropDown(context),
            ),
          ),
        ],
      ),
    );
  }

  _toWidget(BuildContext context) {
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
          PrimaryTextInputWidget(
            controller: controller.toAmountController,
            keyboardType: TextInputType.number,
            labelText: Strings.to.tr,
            hint: "0.00",
            readOnly: true,
            suffixIcon: Container(
              // height: Dimensions.inputBoxHeight * 0.69,
              width: Dimensions.widthSize * 9.5,
              decoration: BoxDecoration(
                  color: Theme.of(context).primaryColor,
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(Get.find<LanguageSettingController>().selectedLanguage.value.contains("ar") ? 0: Dimensions.radius * .5),
                    topLeft: Radius.circular(Get.find<LanguageSettingController>().selectedLanguage.value.contains("ar") ? Dimensions.radius * .5: 0),
                    bottomRight: Radius.circular(Get.find<LanguageSettingController>().selectedLanguage.value.contains("ar") ? 0: Dimensions.radius * .5),
                    bottomLeft: Radius.circular(Get.find<LanguageSettingController>().selectedLanguage.value.contains("ar") ? Dimensions.radius * .5: 0),
                  )),
              child: _toCurrencyDropDown(context),
            ),
          ),
        ],
      ),
    );
  }

  _fromCurrencyDropDown(BuildContext context) {
    return Column(
      children: [
        Obx(() => CustomDropDown<UserWallet>(
              isCurrencyDropDown: true,
              items: controller.moneyExchangeModel.data.userWallet,
              hint: controller.fromSelectedCurrency.value.isEmpty
                  ? Strings.selectIDType
                  : controller.fromSelectedCurrency.value,
              onChanged: (value) {
                controller.fromSelectedCurrency.value = value!.currencyCode;
                controller.fromSelectedCurrencyType.value = value.type;
                controller.fromSelectedCurrencyRate.value = value.rate;
                controller.calculateExchangeRate();
              },
              padding: EdgeInsets.symmetric(
                horizontal: Dimensions.paddingSizeHorizontal * 0,
              ),
              titleTextColor: CustomColor.whiteColor,
              dropDownColor: Theme.of(context).primaryColor,
              borderEnable: true,
              dropDownFieldColor: Theme.of(context).primaryColor,
              dropDownIconColor: CustomColor.whiteColor,
              border: Border.all(
                color: Theme.of(context).primaryColor,
              ),
            )),
      ],
    );
  }

  _toCurrencyDropDown(BuildContext context) {
    return Column(
      children: [
        Obx(() => CustomDropDown<UserWallet>(
              isCurrencyDropDown: true,
              items: controller.moneyExchangeModel.data.userWallet,
              hint: controller.toSelectedCurrency.value.isEmpty
                  ? Strings.selectIDType
                  : controller.toSelectedCurrency.value,
              onChanged: (value) {
                controller.toSelectedCurrency.value = value!.title;
                controller.toSelectedCurrencyRate.value = value.rate;
                controller.toSelectedCurrencyType.value = value.type;
                controller.calculateExchangeRate();
              },
              padding: EdgeInsets.symmetric(
                horizontal: Dimensions.paddingSizeHorizontal * 0,
              ),
              titleTextColor: CustomColor.whiteColor,
              dropDownColor: Theme.of(context).primaryColor,
              borderEnable: true,
              dropDownFieldColor: Theme.of(context).primaryColor,
              dropDownIconColor: CustomColor.whiteColor,
              border: Border.all(
                color: Theme.of(context).primaryColor,
              ),
            )),
      ],
    );
  }
}
