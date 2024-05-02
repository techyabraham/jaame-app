import 'package:adescrow_app/utils/basic_screen_imports.dart';

class NavButtonWidget extends StatelessWidget {
  const NavButtonWidget(
      {super.key,
      required this.text,
      required this.icon,
      required this.onTap,
      required this.isSelected});

  final String text;
  final IconData icon;
  final VoidCallback onTap;
  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    return isSelected
        ? Container(
            padding: EdgeInsets.symmetric(
                horizontal: Dimensions.paddingSizeHorizontal * .5,
                vertical: Dimensions.paddingSizeHorizontal * .22),
            margin: EdgeInsets.symmetric(
                vertical: Dimensions.paddingSizeHorizontal * .1),
            decoration: BoxDecoration(
                color: Theme.of(context).scaffoldBackgroundColor,
                borderRadius: BorderRadius.circular(Dimensions.radius * 2)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                _icon(),
                horizontalSpace(5),
                TitleHeading4Widget(
                  text: text,
                  opacity: .4,
                  padding: const EdgeInsets.only(top: 2),
                  fontSize: Dimensions.headingTextSize4 * .85,
                  fontWeight: FontWeight.w600,
                )
              ],
            ),
          )
        : IconButton(onPressed: onTap, icon: _icon());
  }

  _icon() {
    return Icon(icon,
            color: CustomColor.primaryLightTextColor.withOpacity(.4),
      size: Dimensions.iconSizeDefault * 1.3,
    );
  }
}

/*
Animate(
        effects: const [FadeEffect(), ScaleEffect()],
 */
