import 'package:flutter_animate/flutter_animate.dart';

import '../../utils/basic_widget_imports.dart';

class ProfileTileButtonWidget extends StatelessWidget {
  const ProfileTileButtonWidget(
      {super.key,
      required this.onTap,
      required this.text,
      required this.icon,
      this.isDelete = false});

  final VoidCallback onTap;
  final String text;
  final IconData icon;
  final bool isDelete;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: EdgeInsets.symmetric(
            horizontal: Dimensions.paddingSizeHorizontal * .5,
            vertical: Dimensions.paddingSizeVertical * .5),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Animate(
                effects: const [FadeEffect(), ScaleEffect()],
                child: Icon(icon,
                    size: Dimensions.iconSizeDefault * 1.3,
                    color: isDelete
                        ? CustomColor.redColor
                        : CustomColor.primaryLightTextColor)),
            horizontalSpace(Dimensions.marginSizeHorizontal * .7),
            TitleHeading3Widget(
              text: text,
              fontSize: Dimensions.headingTextSize3 * .85,
              color: isDelete ? CustomColor.redColor : null,
            )
          ],
        ),
      ),
    )
        .animate()
        .fadeIn(duration: 900.ms, delay: 300.ms)
        .shimmer(blendMode: BlendMode.srcOver, color: Colors.white12)
        .move(begin: const Offset(-16, 0), curve: Curves.easeOutQuad);
  }
}
