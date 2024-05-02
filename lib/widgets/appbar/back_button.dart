import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../language/language_controller.dart';
import '../../utils/basic_widget_imports.dart';
import '../../utils/svg_assets.dart';

class BackButtonWidget extends StatelessWidget {
  const BackButtonWidget({super.key, required this.onTap});

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: onTap,
      icon: Animate(
          effects: const [FadeEffect(), ScaleEffect()],
          child: Transform.rotate(
            angle: Get.find<LanguageSettingController>().selectedLanguage.value.contains("ar") ? 3.14 : 0,
            child: SvgPicture.string(
                SVGAssets.backButtonPrimary,
              height: Dimensions.heightSize* 2.2,
              width: Dimensions.widthSize * 2.2,
            ),
          )
      ),
    );
  }
}
