import 'dart:io';

import 'package:adescrow_app/utils/basic_screen_imports.dart';
import 'package:adescrow_app/utils/responsive_layout.dart';

import '../../../../backend/models/dashboard/profile_model.dart';
import '../../../../controller/dashboard/profiles/update_profile_controller.dart';
import '../../../../widgets/custom_dropdown_widget/custom_dropdown_widget.dart';
import '../../../../widgets/others/custom_loading_widget.dart';
import '../../../../widgets/others/profile_image_widget.dart';

class UpdateProfileScreen extends GetView<UpdateProfileController> {
  const UpdateProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: ResponsiveLayout(
        mobileScaffold: Scaffold(
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          appBar: const PrimaryAppBar(
            title: Strings.updateProfile,
          ),
          body: Obx(() => controller.isLoading ? const CustomLoadingWidget(): Column(
            children: [
              verticalSpace(Dimensions.paddingSizeVertical * .8),
              ProfileImageWidget(
                isCircle: false,
                onTap: (File file) {
                  controller.filePath = file.path;
                },
              ),
              verticalSpace(Dimensions.paddingSizeVertical * .8),
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
          padding: EdgeInsets.symmetric(
              horizontal: Dimensions.paddingSizeHorizontal * 1,
              vertical: Dimensions.paddingSizeVertical * 1),
          physics: const BouncingScrollPhysics(),
          children: [
            TitleHeading2Widget(
              text: Strings.profileInfo,
              fontWeight: FontWeight.w600,
              fontSize: Dimensions.headingTextSize2 * .85,
            ),
            verticalSpace(Dimensions.paddingSizeVertical * .8),

            // inputs widgets
            _inputWidget(context),

            verticalSpace(Dimensions.paddingSizeVertical * .8),

            // primary button
            Obx(() => controller.isSubmitLoading
                ? const CustomLoadingWidget()
                : PrimaryButton(
                    title: Strings.updateProfile,
                    onPressed: controller.onUpdateProfileProcess,
                  )),

            verticalSpace(Dimensions.paddingSizeVertical * 1.5),
          ],
        ),
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
            Row(
              children: [
                Expanded(
                  child: PrimaryTextInputWidget(
                    controller: controller.firstNameController,
                    labelText: Strings.firstName,
                  ),
                ),
                horizontalSpace(Dimensions.marginSizeHorizontal * .5),
                Expanded(
                  child: PrimaryTextInputWidget(
                    controller: controller.lastNameController,
                    labelText: Strings.lastName,
                  ),
                )
              ],
            ),
            verticalSpace(Dimensions.marginBetweenInputBox * .8),
            _countryDropDown(context),
            verticalSpace(Dimensions.marginBetweenInputBox * .8),
            PrimaryTextInputWidget(
              controller: controller.numberController,
              keyboardType: TextInputType.number,
              labelText: Strings.phoneNumber,
              prefixIcon: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Obx(() => TitleHeading3Widget(
                        text: controller.code.value,
                        textAlign: TextAlign.center,
                        padding: EdgeInsets.only(
                          right: Dimensions.paddingSizeHorizontal * .2,
                          left: Dimensions.paddingSizeHorizontal * .3
                        ),
                        opacity: .2,
                        fontSize: Dimensions.headingTextSize3 * .85,
                      )),
                ],
              ),
            ),
            verticalSpace(Dimensions.marginBetweenInputBox * .8),
            Row(
              children: [
                Expanded(
                  child: PrimaryTextInputWidget(
                    controller: controller.cityController,
                    labelText: Strings.city,
                  ),
                ),
                horizontalSpace(Dimensions.marginSizeHorizontal * .5),
                Expanded(
                  child: PrimaryTextInputWidget(
                    controller: controller.zipController,
                    labelText: Strings.zip,
                  ),
                )
              ],
            ),
            verticalSpace(Dimensions.marginBetweenInputBox * .8),
            Row(
              children: [
                Expanded(
                  child: PrimaryTextInputWidget(
                    controller: controller.addressController,
                    labelText: Strings.address,
                  ),
                ),
                horizontalSpace(Dimensions.marginSizeHorizontal * .5),
                Expanded(
                  child: PrimaryTextInputWidget(
                    controller: controller.stateController,
                    labelText: Strings.state,
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }

  _countryDropDown(BuildContext context) {
    return Column(
      children: [
        Obx(() => CustomDropDown<Country>(
              items: controller.profileModel.data.countries,
              title: Strings.country,
              hint: controller.country.value.isEmpty
                  ? Strings.selectCountry
                  : controller.country.value,
              onChanged: (value) {
                controller.country.value = value!.title;
                controller.code.value = value.mcode;
              },
              padding: EdgeInsets.symmetric(
                horizontal: Dimensions.paddingSizeHorizontal * 0.25,
              ),
              titleTextColor: controller.country.value.isEmpty
                  ? CustomColor.primaryLightTextColor.withOpacity(.2)
                  : Theme.of(context).primaryColor,
              dropDownColor: Theme.of(context).scaffoldBackgroundColor,
              borderEnable: true,
              dropDownFieldColor: Colors.transparent,
              dropDownIconColor: controller.country.value.isEmpty
                  ? CustomColor.primaryLightTextColor.withOpacity(.2)
                  : Theme.of(context).primaryColor,
              border: Border.all(
                color: Theme.of(context).primaryColor.withOpacity(.2),
                width: 1.5,
              ),
            )),
      ],
    );
  }
}
