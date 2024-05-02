import 'package:flutter/material.dart';

import '../../utils/dimensions.dart';
import '../text_labels/title_heading5_widget.dart';

class SecondaryButton extends StatelessWidget {
  const SecondaryButton({super.key, required this.text, required this.onTap});

  final String text;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(Dimensions.radius * 2),
          child: Container(
            // width: MediaQuery.of(context).size.width * .3,
            padding: EdgeInsets.symmetric(
              horizontal: Dimensions.paddingSizeHorizontal * 2,
              vertical: Dimensions.paddingSizeHorizontal * .5,
            ),
            decoration: BoxDecoration(
                color: Theme.of(context).scaffoldBackgroundColor,
                borderRadius: BorderRadius.circular(Dimensions.radius * 2)),
            child: TitleHeading5Widget(
              text: text,
              fontWeight: FontWeight.w500,
              color: Theme.of(context).primaryColor,
            ),
          ),
        ),
      ],
    );
  }
}
