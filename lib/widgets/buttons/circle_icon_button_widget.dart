import 'package:adescrow_app/utils/basic_screen_imports.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../text_labels/title_heading5_widget.dart';

class CircleIconButtonWidget extends StatelessWidget {
  const CircleIconButtonWidget(
      {super.key, required this.name, required this.onTap, required this.icon});

  final String name;
  final IconData icon;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        InkWell(
          borderRadius: BorderRadius.circular(Dimensions.radius * 3.2),
          onTap: onTap,
          child: Container(
            alignment: Alignment.center,
            padding: EdgeInsets.symmetric(
                horizontal: Dimensions.paddingSizeHorizontal * .5,
                vertical: Dimensions.paddingSizeVertical * .5,
            ),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(Dimensions.radius * 3.2),
                color: CustomColor.whiteColor),
            child: Animate(
                effects: const [FadeEffect(), ScaleEffect()],
                child: Icon(icon, size: Dimensions.iconSizeDefault * 1.3 , color: Theme.of(context).primaryColor)),
          ),
        ),
        verticalSpace(Dimensions.heightSize * .5),
        TitleHeading5Widget(
          text: name,
          fontWeight: FontWeight.w600,
          opacity: .4,
          fontSize: Dimensions.headingTextSize5 * .85,
        )
      ],
    );
  }
}
