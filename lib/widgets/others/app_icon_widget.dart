
import 'package:adescrow_app/widgets/others/custom_loading_widget.dart';

import '../../controller/before_auth/basic_settings_controller.dart';
import '../../utils/basic_widget_imports.dart';
import 'custom_cached_network_image.dart';


class AppIconWidget extends StatelessWidget {
  const AppIconWidget({super.key, this.height, this.width});

  final double? height, width;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal: Dimensions.paddingSizeHorizontal * 3
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Obx(() => Get.find<BasicSettingsController>().isLoading ? const CustomLoadingWidget(): CustomCachedNetworkImage(
            imageUrl: Get.find<BasicSettingsController>().appIconLink,
            height: height ?? 80,
            width: width,
              radius: 0,
              isCircle: false
          )),
          verticalSpace(height == null ? Dimensions.paddingSizeVertical : 0),
        ],
      ),
    );
  }
}
