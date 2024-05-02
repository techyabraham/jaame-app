import 'package:adescrow_app/utils/basic_screen_imports.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../text_labels/title_heading5_widget.dart';

class CircleSVGButtonWidget extends StatelessWidget {
  const CircleSVGButtonWidget(
      {super.key,
      required this.color,
      required this.name,
      required this.svg,
      required this.onTap,
      required this.textColor});

  final Color color, textColor;
  final String name, svg;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        InkWell(
          borderRadius: BorderRadius.circular(Dimensions.radius * 3.2),
          onTap: onTap,
          child: Container(
            padding: EdgeInsets.symmetric(
                horizontal: Dimensions.paddingSizeHorizontal * .7,
                vertical: Dimensions.paddingSizeVertical * .7,
            ),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(Dimensions.radius * 3.2),
                color: color),
            child: Animate(
                effects: const [FadeEffect(), ScaleEffect()],
                child: SvgPicture.string(
                    svg,
                  height: Dimensions.heightSize * 2,
                  width: Dimensions.widthSize * 2,
                )),
          ),
        ),
        verticalSpace(Dimensions.heightSize * .5),
        TitleHeading5Widget(
          text: name,
          fontWeight: FontWeight.w500,
          color: textColor,
        )
      ],
    );
  }
}
