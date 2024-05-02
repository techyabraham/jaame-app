
import '../../backend/models/dashboard/notification_model.dart';
import '../../extensions/custom_extensions.dart';
import '../../utils/basic_widget_imports.dart';
import '../text_labels/title_heading5_widget.dart';

class NotificationTileWidget extends StatelessWidget {
  const NotificationTileWidget({super.key, required this.notification});

  final NotificationData notification;

  @override
  Widget build(BuildContext context) {
    return Container(
      // height: Dimensions.buttonHeight * 1.2,
      // width: Dimensions.widthSize * 22,
      padding: EdgeInsets.symmetric(
                horizontal: Dimensions.paddingSizeHorizontal * .4,
                vertical: Dimensions.paddingSizeVertical * .3,
            ),
      decoration: BoxDecoration(
          color: CustomColor.whiteColor,
          borderRadius: BorderRadius.circular(Dimensions.radius)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            padding: EdgeInsets.symmetric(
                horizontal: Dimensions.paddingSizeHorizontal * .3,
                vertical: Dimensions.paddingSizeVertical * .25),
            decoration: BoxDecoration(
                color: Theme.of(context).scaffoldBackgroundColor,
                borderRadius: BorderRadius.circular(Dimensions.radius)),
            child: Column(
              children: [
                TitleHeading1Widget(
                  text: getDate(notification.createdAt.toString())["day"].toString(),
                  color: Theme.of(context).primaryColor,
                  fontWeight: FontWeight.w800,
                  fontSize: Dimensions.headingTextSize3 * 1.7,
                ),
                TitleHeading5Widget(
                  text: getDate(notification.createdAt.toString())["month"].toString(),
                  color: Theme.of(context).primaryColor,
                  fontWeight: FontWeight.w500,
                  fontSize: Dimensions.headingTextSize6 * .85,
                )
              ],
            ),
          ),
          horizontalSpace(Dimensions.marginSizeHorizontal * .5),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TitleHeading2Widget(
                      text: notification.message.title,
                      fontSize: Dimensions.headingTextSize3 * .85,
                    ),

                    TitleHeading5Widget(
                      text: notification.message.time,
                      fontSize: Dimensions.headingTextSize5 * .75,
                      // maxLines: 2,
                      opacity: .7,
                    )
                  ],
                ),
                TitleHeading5Widget(
                  text: notification.message.message,
                  fontSize: Dimensions.headingTextSize5 * .85,
                  // maxLines: 2,
                  opacity: 1,
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
