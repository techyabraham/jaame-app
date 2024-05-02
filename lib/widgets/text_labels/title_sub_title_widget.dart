import 'package:adescrow_app/utils/basic_widget_imports.dart';
import 'package:flutter_animate/flutter_animate.dart';

class TitleSubTitleWidget extends StatelessWidget {
  const TitleSubTitleWidget({super.key,
    required this.title,
    required this.subTitle,
    this.fromStart = false,
    this.paddingRatio = 1,
  });
  final String title, subTitle;
  final bool fromStart;
  final double paddingRatio;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal: Dimensions.paddingSizeHorizontal * paddingRatio,
          vertical: Dimensions.paddingSizeVertical * paddingRatio),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: fromStart ? CrossAxisAlignment.start: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Visibility(
            visible: title.isNotEmpty,
            child: TitleHeading1Widget(
              text: title,
              fontWeight: FontWeight.w600,
              textAlign: fromStart ? TextAlign.start: TextAlign.center,
              fontSize: Dimensions.headingTextSize1 * .8,
            ).animate()
            .fadeIn(duration: 900.ms, delay: 300.ms)
            .move(begin: const Offset(-16, 0), curve: Curves.easeOutQuad),
          ),


          verticalSpace(Dimensions.heightSize * .55),
          TitleHeading4Widget(
            text: subTitle,
            fontWeight: FontWeight.w500,
            textAlign: fromStart ? TextAlign.start: TextAlign.center,
            fontSize: Dimensions.headingTextSize4 * .8,
            opacity: .4,
          ).animate()
              .fadeIn(duration: 900.ms, delay: 300.ms)
              .move(begin: const Offset(-16, 0), curve: Curves.easeOutQuad),
        ],
      ),
    );
  }
}
