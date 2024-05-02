import 'package:adescrow_app/utils/basic_screen_imports.dart';
import 'package:adescrow_app/utils/responsive_layout.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_svg/svg.dart';

import '../../../backend/services/api_endpoint.dart';
import '../../../widgets/others/custom_cached_network_image.dart';
import '../../../controller/before_auth/basic_settings_controller.dart';
import '../../../controller/before_auth/onboard_screen_controller.dart';
import '../../../utils/svg_assets.dart';
import '../../../widgets/text_labels/title_sub_title_widget.dart';

class OnboardScreen extends StatelessWidget {
  const OnboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var basicController = Get.find<BasicSettingsController>();
    var basicSettings = basicController.basicSettingModel;


    return ResponsiveLayout(

      mobileScaffold: Scaffold(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        body: basicSettings.data.onboardScreen.isEmpty ? Container() : Stack(
          children: [

            Obx(() => CustomCachedNetworkImage(
              imageUrl: "${ApiEndpoint.mainDomain}/${basicSettings.data.imagePath}/${basicSettings.data.onboardScreen[basicController.selectedIndex.value].image}",
            )),

            Obx(() => Positioned(
              bottom: 230,
              width: MediaQuery.of(context).size.width,
              child: TitleSubTitleWidget(
                title: basicSettings.data.onboardScreen[basicController.selectedIndex.value].title,
                subTitle: basicSettings.data.onboardScreen[basicController.selectedIndex.value].subTitle,
              ),
            )),

            Positioned(
              bottom: 150,
              right: 0,
              left: 0,
              child: InkWell(
                  borderRadius: BorderRadius.circular(Dimensions.radius  * 10),
                  onTap: (){
                    if((basicController.selectedIndex.value + 1) == basicSettings.data.onboardScreen.length){
                      Get.find<OnboardController>().goNextBTNClicked();
                    }else{
                      basicController.selectedIndex.value ++;
                    }
                  },
                  child: Animate(
                      effects: const [FadeEffect(), ScaleEffect()],child: SvgPicture.string(SVGAssets.circleButton))
              ),
            )
          ],
        ),
      ),
    );
  }
}
