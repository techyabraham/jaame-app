import 'package:flutter_svg/flutter_svg.dart';

import '../../language/language_controller.dart';
import '../../utils/basic_widget_imports.dart';
import '../../utils/svg_assets.dart';

class PasswordInputWidget extends StatefulWidget {
  const PasswordInputWidget({
    super.key,
    required this.controller,
    required this.hintText,
    this.keyboardType,
    this.readOnly = false,
    this.focusedBorderWidth = 1.2,
    this.enabledBorderWidth = 1,
    this.color = Colors.transparent,
  });
  final TextEditingController controller;
  final String hintText;
  final TextInputType? keyboardType;
  final bool? readOnly;
  final Color? color;
  final double focusedBorderWidth;
  final double enabledBorderWidth;

  @override
  State<PasswordInputWidget> createState() => _PasswordInputWidgetState();
}

class _PasswordInputWidgetState extends State<PasswordInputWidget> {
  bool isVisibility = true;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TitleHeading4Widget(
          text: widget.hintText.tr,
          fontWeight: FontWeight.w600,
        ),
        verticalSpace(Dimensions.marginBetweenInputBox * .5),
        TextFormField(
          cursorColor: Theme.of(context).primaryColor,
          readOnly: false,
          style: CustomStyle.lightHeading4TextStyle
              .copyWith(color: Theme.of(context).primaryColor),
          controller: widget.controller,
          keyboardType: widget.keyboardType,
          validator: (String? value) {
            if (value!.isEmpty) {
              return Get.find<LanguageSettingController>().isLoading
                  ? ""
                  : Get.find<LanguageSettingController>()
                      .getTranslation(Strings.pleaseFillOutTheField);
            } else {
              return null;
            }
          },
          decoration: InputDecoration(
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(Dimensions.radius * 0.5),
              borderSide: BorderSide(
                  color: Theme.of(context).primaryColor.withOpacity(0.2),
                  width: widget.enabledBorderWidth),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(
                  color: Theme.of(context).primaryColor,
                  width: widget.focusedBorderWidth),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(Dimensions.radius * 0.5),
              borderSide: const BorderSide(color: Colors.red, width: 1),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(Dimensions.radius * 0.5),
              borderSide: const BorderSide(color: Colors.red, width: 1),
            ),
            filled: true,
            fillColor: widget.color,
            contentPadding:
                const EdgeInsets.only(left: 10, right: 10, top: 10, bottom: 10),
            hintText: Get.find<LanguageSettingController>().isLoading
                ? ""
                : "${Get.find<LanguageSettingController>().getTranslation(Strings.enter)} ${Get.find<LanguageSettingController>().getTranslation(widget.hintText)}",
            hintStyle: Get.isDarkMode
                ? CustomStyle.darkHeading3TextStyle.copyWith(
                    color: CustomColor.primaryDarkTextColor.withOpacity(0.2),
                    fontWeight: FontWeight.w500,
                    fontSize: Dimensions.headingTextSize3,
                  )
                : CustomStyle.lightHeading3TextStyle.copyWith(
                    color: CustomColor.primaryLightTextColor.withOpacity(0.2),
                    fontWeight: FontWeight.w500,
                    fontSize: Dimensions.headingTextSize3,
                  ),
            suffixIcon: IconButton(
              icon: Opacity(
                opacity: .2,
                child: SvgPicture.string(
                  isVisibility ? SVGAssets.eyeSlash : SVGAssets.eye,
                ),
              ),
              color: widget.color,
              onPressed: () {
                setState(() {
                  isVisibility = !isVisibility;
                });
              },
            ),
          ),
          obscureText: isVisibility,
        )
      ],
    );
  }
}
