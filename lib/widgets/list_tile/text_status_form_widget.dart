import '../../utils/basic_widget_imports.dart';
import 'status_widget.dart';

class TextStatusFormWidget extends StatelessWidget {
  const TextStatusFormWidget(
      {super.key,
      required this.text,
        required this.status,
      });

  final String text;
  final int status;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        TitleHeading4Widget(
          opacity: .6,
          text: text,
          fontSize: Dimensions.headingTextSize4 * .85,
          fontWeight: FontWeight.w500,
        ),

        StatusWidget(
          statusValue: status,
        )
      ],
    );
  }
}
