import 'package:adescrow_app/utils/basic_screen_imports.dart';
import 'package:adescrow_app/utils/responsive_layout.dart';

import '../../../backend/backend_utils/no_data_widget.dart';
import '../../../controller/dashboard/notification_controller.dart';
import '../../../widgets/list_tile/notification_tile_widget.dart';
import '../../../widgets/others/custom_loading_widget.dart';

class NotificationScreen extends GetView<NotificationController> {
  const NotificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: ResponsiveLayout(
        mobileScaffold: Scaffold(
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          appBar: const PrimaryAppBar(
            title: Strings.notifications,
          ),
          body: Obx(() => controller.isLoading ? const CustomLoadingWidget(): controller.notificationModel.data.notifications.isEmpty
              ? const Column(
                  children: [
                    NoDataWidget(),
                  ],
                )
              : ListView.separated(
                  shrinkWrap: true,
                  padding: EdgeInsets.only(
                    right: Dimensions.paddingSizeHorizontal * .85,
                    left: Dimensions.paddingSizeHorizontal * .85,
                    bottom: Dimensions.paddingSizeVertical * .85,
                  ),
                  scrollDirection: Axis.vertical,
                  physics: const BouncingScrollPhysics(),
                  itemBuilder: (context, index) {
                    return NotificationTileWidget(
                      notification: controller
                          .notificationModel.data.notifications[index],
                    );
                  },
                  separatorBuilder: (context, i) =>
                      verticalSpace(Dimensions.marginSizeVertical * .3),
                  itemCount:
                      controller.notificationModel.data.notifications.length)),
        ),
      ),
    );
  }
}
