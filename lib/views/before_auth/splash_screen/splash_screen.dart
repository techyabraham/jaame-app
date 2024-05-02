import 'package:adescrow_app/utils/basic_screen_imports.dart';
import 'package:adescrow_app/utils/responsive_layout.dart';
import 'package:adescrow_app/widgets/others/custom_loading_widget.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../../../controller/before_auth/basic_settings_controller.dart';
import '../../../widgets/others/custom_cached_network_image.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ResponsiveLayout(
      mobileScaffold: Scaffold(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        body: Obx(() => Get.find<BasicSettingsController>().isLoading
            ? const CustomLoadingWidget()
            : Stack(
                children: [
                  CustomCachedNetworkImage(
                    imageUrl: Get.find<BasicSettingsController>().splashBGLink,
                  ),
                  Positioned(
                    bottom: 50,
                    right: 0,
                    left: 0,
                    child: Animate(
                      effects: const [FadeEffect(), ScaleEffect()],
                      child: TitleHeading1Widget(
                        text: Get.find<BasicSettingsController>().basicSettingModel.data.siteName,
                        textAlign: TextAlign.center,
                        color: Theme.of(context).primaryColor,
                      ),
                    ),
                  )
                ],
              )),
      ),
    );
  }
}
