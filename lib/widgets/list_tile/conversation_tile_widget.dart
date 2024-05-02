import '../../backend/models/escrow/escrow_index_model.dart';
import '../../extensions/custom_extensions.dart';
import '../../utils/basic_widget_imports.dart';
import '../text_labels/title_heading5_widget.dart';
import 'status_widget.dart';

class EscrowTileWidget extends StatelessWidget {
  const EscrowTileWidget({
    super.key, required this.data,
  });

  final EscrowDatum data;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
        left: Dimensions.paddingSizeHorizontal * .7,
        right: Dimensions.paddingSizeHorizontal * .7,
      ),
      padding: EdgeInsets.symmetric(
        horizontal: Dimensions.paddingSizeHorizontal * .5,
        vertical: Dimensions.paddingSizeVertical * .3,
      ),
      decoration: BoxDecoration(
          color: Theme.of(context).scaffoldBackgroundColor,
          borderRadius: BorderRadius.circular(Dimensions.radius)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            padding: EdgeInsets.symmetric(
              horizontal: Dimensions.paddingSizeHorizontal * .3,
              vertical: Dimensions.paddingSizeVertical * .2,
            ),
            decoration: BoxDecoration(
                color: CustomColor.whiteColor,
                borderRadius: BorderRadius.circular(Dimensions.radius)),
            child: Column(
              children: [
                TitleHeading1Widget(
                  text: getDate(data.createdAt.toString())["day"].toString(),
                  color: Theme.of(context).primaryColor,
                  fontWeight: FontWeight.w800,
                  fontSize: Dimensions.headingTextSize3 * 1.7,
                ),
                TitleHeading5Widget(
                  text: getDate(data.createdAt.toString())["month"].toString(),
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
                  children: [
                    TitleHeading2Widget(
                      text: data.category,
                      fontSize: Dimensions.headingTextSize3 * .85,
                    ),
                    horizontalSpace(4),
                    StatusWidget(
                      statusValue: data.status,
                    )
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TitleHeading5Widget(
                      text: data.escrowId,
                      fontSize: Dimensions.headingTextSize5 * .85,
                      opacity: 1,
                    ),
            
                    TitleHeading3Widget(
                      text: data.amount,
                      fontSize: Dimensions.headingTextSize3 * .85,
                      color: Theme.of(context).primaryColor,
                      opacity: 1,
                    )
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
