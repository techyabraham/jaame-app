
import '../../../../utils/basic_widget_imports.dart';
import '../../../controller/auth/register_controller.dart';
import '../../../widgets/others/rich_text_widget.dart';


class RememberMeWidget extends StatelessWidget {
  const RememberMeWidget({super.key, required this.controller});

  final RegisterController controller;

  @override
  Widget build(BuildContext context) {
    return Obx(() => Opacity(
      opacity: controller.isChecked.value ? 1 : .6,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: Dimensions.paddingSizeHorizontal * 1,
            height: Dimensions.paddingSizeVertical * 1,
            child: Checkbox(
                activeColor: CustomColor.primaryLightTextColor.withOpacity(.4),
                checkColor: CustomColor.primaryLightColor,
                shape: RoundedRectangleBorder(
                  side: BorderSide(
                    color: CustomColor.primaryLightTextColor.withOpacity(.4),
                  ),
                  borderRadius: BorderRadius.circular(Dimensions.radius * .3),
                ),
                value: controller.isChecked.value,
                onChanged: controller.checkBoxOnChanged
            ),
          ),

          horizontalSpace(Dimensions.marginSizeHorizontal * .2),

          Expanded(
            child: RichTextWidget(
              onPressed: ()=> controller.privacyPolicyWebView(context),
              preText: Strings.iHaveAgreed,
              postText: Strings.termsOfUse,
              textAlign: TextAlign.start,
              opacity: .6,
            ),
          )

        ],
      ),
    ));
  }
}
