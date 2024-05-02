import 'package:adescrow_app/utils/basic_screen_imports.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../utils/svg_assets.dart';

// custom appbar
class DashboardAppBar extends StatelessWidget implements PreferredSizeWidget {
  const DashboardAppBar({
    super.key,
    required this.title,
    this.appbarSize,
    this.onMenuTap,
    this.actions
  });

  final Widget title;
  final double? appbarSize;
  final VoidCallback? onMenuTap;
  final List<Widget>? actions;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: title,
      elevation: 0,
      leading: Animate(
        effects: const [FadeEffect(), ScaleEffect()],
        child: IconButton(
            onPressed: onMenuTap,
            icon: SvgPicture.string(
                SVGAssets.dashboardMenu,
              height: Dimensions.heightSize * 2.2,
              width: Dimensions.widthSize * 2.2,
            )),
      ),
      actions: actions,
      centerTitle: true,
      backgroundColor: Colors.transparent,
      iconTheme: IconThemeData(
        color: Theme.of(context).primaryColor,
        size: 30,
      ),
    );
  }

  @override
  // Size get preferredSize => Size.fromHeight(appBar.preferredSize.height);
  Size get preferredSize =>
      Size.fromHeight(appbarSize ?? Dimensions.appBarHeight * .8);
}
