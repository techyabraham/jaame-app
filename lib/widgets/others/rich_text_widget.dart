
import '../../language/language_controller.dart';
import '../../utils/basic_widget_imports.dart';


class RichTextWidget extends StatelessWidget {
  const RichTextWidget({super.key, required this.preText, required this.postText, required this.onPressed, this.opacity, this.textAlign});

  final String preText, postText;
  final VoidCallback onPressed;
  final double? opacity;
  final TextAlign? textAlign;

  @override
  Widget build(BuildContext context) {

    return GestureDetector(
      onTap: onPressed,
      child: Text.rich(
        TextSpan(
          children: [
            TextSpan(
              text: Get.find<LanguageSettingController>().isLoading
                  ? ""
                  : Get.find<LanguageSettingController>()
                  .getTranslation(preText),
              style: CustomStyle.lightHeading5TextStyle.copyWith(
                color: CustomColor.primaryLightTextColor.withOpacity(opacity ?? .7)
              )
            ),
            TextSpan(
              text: Get.find<LanguageSettingController>().isLoading
                  ? ""
                  : Get.find<LanguageSettingController>()
                  .getTranslation(postText),
              style: CustomStyle.lightHeading5TextStyle.copyWith(
                color: CustomColor.primaryLightColor,
                fontWeight: FontWeight.w500,
              )
            ),
          ],
        ),
        textAlign: textAlign ?? TextAlign.center,
      ),
    );
  }
}
