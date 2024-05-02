import 'package:adescrow_app/utils/basic_screen_imports.dart';

import '../text_labels/title_heading5_widget.dart';

class TextButtonWithBGWidget extends StatelessWidget {
  const TextButtonWithBGWidget(
      {super.key,
      required this.onTap,
      required this.text,
       this.colorCode = 1,
        this.isLoading = false
      });

  final VoidCallback onTap;
  final String text;
  final int colorCode;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.symmetric(
          horizontal: Dimensions.paddingSizeHorizontal * .15
        ),
        padding: EdgeInsets.symmetric(
          horizontal: Dimensions.paddingSizeHorizontal * .4,
          vertical: Dimensions.paddingSizeHorizontal * .3,
        ),
        decoration: BoxDecoration(
          color: colorCode == 1
              ? Theme.of(context).primaryColor
              : colorCode == 2
                ? CustomColor.blueColor
                : CustomColor.orangeColor,
          borderRadius: BorderRadius.circular(Dimensions.radius * .6)
        ),
        child: Row(
          children: [
            TitleHeading5Widget(
              text: text,
              color: CustomColor.whiteColor,
              fontWeight: FontWeight.w600,
            ),
            Visibility(
              visible: isLoading,
                child: const SizedBox(
                  height: 15,
                  width: 15,
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                    color: CustomColor.whiteColor,
                  ),
                )
            )
          ],
        ),
      ),
    );
  }
}
