import 'package:flutter_animate/flutter_animate.dart';

import '../../utils/basic_widget_imports.dart';

class DrawerTileButtonWidget extends StatelessWidget {
  const DrawerTileButtonWidget(
      {super.key,
      required this.onTap,
      required this.text,
      required this.icon,
      });

  final VoidCallback onTap;
  final String text;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: EdgeInsets.symmetric(
           horizontal: Dimensions.paddingSizeHorizontal * 1,
           vertical: Dimensions.paddingSizeHorizontal * .3,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Animate(
              effects: const [FadeEffect(), ScaleEffect()],
              child: Container(
                padding: EdgeInsets.symmetric(
                  horizontal: Dimensions.paddingSizeHorizontal * .1,
                  vertical: Dimensions.paddingSizeVertical * .1,
                ),
                decoration: BoxDecoration(
                  color: Theme.of(context).primaryColor,
                  borderRadius: BorderRadius.circular(Dimensions.radius * .7)
                ),
                child: Icon(icon, size: Dimensions.iconSizeDefault * 1.3, color: CustomColor.whiteColor),
              ),
            ),
            
            horizontalSpace(Dimensions.marginSizeHorizontal * .7),
            TitleHeading3Widget(
              text: text,
              fontSize: Dimensions.headingTextSize3 * .85,
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
