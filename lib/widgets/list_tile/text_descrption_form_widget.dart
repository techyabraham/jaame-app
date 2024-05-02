import '../../utils/basic_widget_imports.dart';

class TextDescriptionFormWidget extends StatelessWidget {
  const TextDescriptionFormWidget(
      {super.key,
      required this.text,
        this.value = "",
      });

  final String text, value;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        TitleHeading4Widget(
          opacity: .6,
          text: text,
          fontSize: Dimensions.headingTextSize4 * .85,
          fontWeight: FontWeight.w500,
        ),
        Expanded(
          child: TitleHeading3Widget(
            opacity: .6,
            text: value,
            textAlign: TextAlign.end,
            fontSize: Dimensions.headingTextSize3 * .85,
            fontWeight: FontWeight.w600,
            color: CustomColor.secondaryLightTextColor,
          ),
        )
      ],
    );
  }
}
