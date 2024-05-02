
// ignore_for_file: constant_identifier_names

import '../../language/language_controller.dart';
import '../../utils/basic_widget_imports.dart';

class StatusWidget extends StatelessWidget {
  const StatusWidget({super.key, required this.statusValue});

  final int statusValue;
  /*

    const ONGOING           = 1;
    const PAYMENT_PENDING   = 2;
    const APPROVAL_PENDING  = 3;
    const RELEASED          = 4;
    const ACTIVE_DISPUTE    = 5;
    const DISPUTED          = 6;
    const CANCELED          = 7;
    const REFUNDED          = 8;
   */

  @override
  Widget build(BuildContext context) {
    return Container(
      // height: Dimensions.heightSize * 1.4,
      alignment: Alignment.center,
      padding: EdgeInsets.symmetric(
          horizontal: Dimensions.paddingSizeHorizontal * .15,
          vertical: Dimensions.paddingSizeVertical * .15),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(Dimensions.radius * .3),
        color: StatusConstants.getStatusColor(statusValue).withOpacity(.1)
      ),
      child: Text(
          Get.find<LanguageSettingController>().getTranslation(StatusConstants.getStatusString(statusValue)),
        style: TextStyle(
          fontWeight: FontWeight.w600,
          fontSize: Dimensions.headingTextSize6,
          color: StatusConstants.getStatusColor(statusValue)
        ),
      ),
    );
  }
}


class StatusConstants {
  static String getStatusString(int statusCode) {
    switch (statusCode) {
      case ONGOING:
        return Strings.ongoing;
      case PAYMENT_PENDING:
        return Strings.paymentPending;
      case APPROVAL_PENDING:
        return Strings.approvalPending;
      case RELEASED:
        return Strings.released;
      case ACTIVE_DISPUTE:
        return Strings.activeDispute;
      case DISPUTED:
        return Strings.disputed;
      case CANCELED:
        return Strings.canceled;
      case REFUNDED:
        return Strings.refunded;
      case PAYMENT_WAITING:
        return Strings.paymentWaiting;
      default:
        return "Unknown Status";
    }
  }

  static Color getStatusColor(int statusCode) {
    switch (statusCode) {
      case 1:
      case 2:
      case 3:
      case 9:
        return Colors.orange;
      case 4:
      case 8:
        return Colors.green;
      case 5:
        return Colors.blue;
      case 6:
      case 7:
        return Colors.red;
      default:
        return Colors.black; // Default color if status code doesn't match any condition
    }
  }


  static const ONGOING = 1;
  static const PAYMENT_PENDING = 2;
  static const APPROVAL_PENDING = 3;
  static const RELEASED = 4;
  static const ACTIVE_DISPUTE = 5;
  static const DISPUTED = 6;
  static const CANCELED = 7;
  static const REFUNDED = 8;
  static const PAYMENT_WAITING = 9;
}
