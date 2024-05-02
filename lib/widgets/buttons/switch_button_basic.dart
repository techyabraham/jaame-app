
import '../../language/language_controller.dart';
import '../../utils/basic_widget_imports.dart';

class SwitchButtonBasicWidget extends StatefulWidget {
  const SwitchButtonBasicWidget({super.key,
    this.onTap,
    this.isScaffold = false
  });
  final Function? onTap;
  final bool isScaffold;

  @override
  State<SwitchButtonBasicWidget> createState() => _SwitchButtonBasicWidgetState();
}

class _SwitchButtonBasicWidgetState extends State<SwitchButtonBasicWidget> {
  bool switchValue = true;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _btn(context, Strings.buyer, () {
          setState(() {
            switchValue = true;
            widget.onTap!(true);
          });
        }, true, switchValue),
        _btn(context, Strings.seller, () {
          setState(() {
            switchValue = false;
            widget.onTap!(false);
          });
        }, false, !switchValue),
      ],
    );
  }

  _btn(BuildContext context, String text, VoidCallback onTap, bool isLeft,
      bool checked) {
    return InkWell(
      borderRadius: BorderRadius.circular(Dimensions.radius),
      onTap: onTap,
      child: Container(
        alignment: Alignment.center,
        height: Dimensions.buttonHeight * .9,
        width: Dimensions.widthSize * 8.5,
        decoration: BoxDecoration(
            color: checked
                ? Theme.of(context).primaryColor
                : widget.isScaffold ? Theme.of(context).scaffoldBackgroundColor: CustomColor.whiteColor,
            borderRadius: BorderRadius.only(
              topLeft: Get.find<LanguageSettingController>().selectedLanguage.value.contains("ar") ? Radius.circular(isLeft ? 0 : Dimensions.radius): Radius.circular(isLeft ? Dimensions.radius : 0),
              topRight: Get.find<LanguageSettingController>().selectedLanguage.value.contains("ar") ? Radius.circular(isLeft ? Dimensions.radius : 0): Radius.circular(isLeft ? 0 : Dimensions.radius),
              bottomLeft: Get.find<LanguageSettingController>().selectedLanguage.value.contains("ar") ? Radius.circular(isLeft ? 0 : Dimensions.radius): Radius.circular(isLeft ? Dimensions.radius : 0),
              bottomRight: Get.find<LanguageSettingController>().selectedLanguage.value.contains("ar") ? Radius.circular(isLeft ? Dimensions.radius : 0): Radius.circular(isLeft ? 0 : Dimensions.radius),
            )),
        child: TitleHeading3Widget(
          text: text,
          fontSize: Dimensions.headingTextSize3 * .85,
          color: checked ? CustomColor.whiteColor : null,
          opacity: checked ? 1 : .4,
        ),
      ),
    );
  }
}
