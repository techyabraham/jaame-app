import 'package:adescrow_app/utils/basic_screen_imports.dart';
import 'package:adescrow_app/widgets/text_labels/title_heading5_widget.dart';


class DialogHelper{
  static void showAlertDialog(BuildContext context, {required String title, String? btnText, required String content, required VoidCallback onTap}) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: TitleHeading3Widget(text: title),
          content: TitleHeading4Widget(text: content, opacity: .6),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Get.close(1); // Close the dialog
              },
              child: const TitleHeading5Widget(text: Strings.cancel, color: CustomColor.redColor),
            ),
            TextButton(
              onPressed: onTap,
              child: TitleHeading5Widget(text: btnText ?? title),
            ),
          ],
        );
      },
    );
  }

}
