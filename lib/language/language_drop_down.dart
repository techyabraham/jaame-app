import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../utils/custom_color.dart';
import '../utils/dimensions.dart';
import '../widgets/text_labels/title_heading4_widget.dart';
import 'language_controller.dart';

class ChangeLanguageWidget extends StatelessWidget {
  const ChangeLanguageWidget({super.key, this.isOnboard = false});
  final bool isOnboard;
  // final _languageController = Get.put(LanguageController());
  @override
  Widget build(BuildContext context) {
    return Obx(
      () => !isOnboard
          ? _dropDown(context)
          : Container(
              alignment: Alignment.center,
              padding: EdgeInsets.symmetric(
                vertical: Dimensions.paddingSizeVertical * 0,
                horizontal: Dimensions.paddingSizeHorizontal * 0.5,
              ),
              decoration: BoxDecoration(
                color: CustomColor.whiteColor.withOpacity(0.1),
                borderRadius: BorderRadius.circular(Dimensions.radius * 0.6),
              ),
              child: _dropDown(context),
            ),
    );
  }

  _dropDown(BuildContext context) {
    return DropdownButton<String>(
      padding: EdgeInsets.zero,
      isDense: true,
      isExpanded: false,
      dropdownColor: Theme.of(context).scaffoldBackgroundColor,
      value: languageSettingsController.selectedLanguage.value,
      underline: Container(),
      icon: const Icon(
        Icons.arrow_drop_down_rounded,
        color: null,
      ).paddingOnly(top: Dimensions.heightSize * 0),
      onChanged: (String? newValue) {
        if (newValue != null) {
          languageSettingsController.changeLanguage(newValue);

        }
      },
      items: languageSettingsController.languages.map<DropdownMenuItem<String>>(
        (language) {
          return DropdownMenuItem<String>(
            value: language.code,
            child: TitleHeading4Widget(
              text: isOnboard ? language.code.toUpperCase() : language.name,
            ),
          );
        },
      ).toList(),
    );
  }
}


/* set this /// todo
ChangeLanguageWidget(
                    isOnboard: false,
                  ),
 */