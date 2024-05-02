import 'package:adescrow_app/utils/basic_screen_imports.dart';
import 'package:flutter_animate/flutter_animate.dart';

class NoDataWidget extends StatelessWidget {
  const NoDataWidget({super.key, this.isScaffold = false, this.msg});

  final bool isScaffold;
  final String? msg;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      padding: EdgeInsets.symmetric(
        horizontal: Dimensions.paddingSizeHorizontal,
        vertical: Dimensions.paddingSizeVertical,
      ),
      decoration: BoxDecoration(
        color: isScaffold ? Theme.of(context).scaffoldBackgroundColor : CustomColor.whiteColor,
        borderRadius: BorderRadius.circular(Dimensions.radius)
      ),
      child: Animate(
        effects: const [FadeEffect(), ScaleEffect()],
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            TitleHeading2Widget(
              text: msg ?? Strings.noDataFound,
              color: Theme.of(context).primaryColor,
            ),
          ],
        ),
      ),
    );
  }
}
