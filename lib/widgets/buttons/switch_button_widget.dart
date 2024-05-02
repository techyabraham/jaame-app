import 'package:adescrow_app/widgets/others/custom_loading_widget.dart';

import '../../controller/dashboard/profiles/update_profile_controller.dart';
import '../../language/language_controller.dart';
import '../../utils/basic_widget_imports.dart';

class SwitchButtonWidget extends StatefulWidget {
  const SwitchButtonWidget({super.key,
    this.onTap,
    this.isScaffold = false
  });
  final Function? onTap;
  final bool isScaffold;

  @override
  State<SwitchButtonWidget> createState() => _SwitchButtonWidgetState();
}

class _SwitchButtonWidgetState extends State<SwitchButtonWidget> {
  // bool switchValue = true;

  @override
  Widget build(BuildContext context) {
    return Obx(()=> Get.find<UpdateProfileController>().isLoading
        ? const CustomLoadingWidget()
        : Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _btn(context, Strings.buyer, () {
          setState(() {
            Get.find<UpdateProfileController>().typeIsBuyer.value = !Get.find<UpdateProfileController>().typeIsBuyer.value ;
            widget.onTap!(true);
          });
        }, true, Get.find<UpdateProfileController>().typeIsBuyer.value),
        _btn(context, Strings.seller, () {
          setState(() {
            Get.find<UpdateProfileController>().typeIsBuyer.value = !Get.find<UpdateProfileController>().typeIsBuyer.value ;
            widget.onTap!(false);
          });
        }, false, !Get.find<UpdateProfileController>().typeIsBuyer.value),
      ],
    ));
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
