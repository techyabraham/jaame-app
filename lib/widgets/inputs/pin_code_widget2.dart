import 'package:pin_code_fields/pin_code_fields.dart';

import '../../utils/basic_widget_imports.dart';

class PinCodeWidget extends StatelessWidget {
  const PinCodeWidget({super.key, required this.textController});

  final TextEditingController textController;

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(0),
        child: Center(
            child: PinCodeTextField(
              textStyle: CustomStyle.darkHeading4TextStyle.copyWith(
                  color: Theme.of(context).primaryColor,
                  fontSize: Dimensions.headingTextSize2 * .8
              ),
          controller: textController,
          appContext: context,
          cursorColor: Theme.of(context).primaryColor,
          keyboardType: TextInputType.number,
          length: 6,
          onChanged: (value) {
            // Handle PIN code changes
          },
          onCompleted: (value) {
            // Handle PIN code entry completion
            // If the text length is 6, close the keyboard
            if (value.length == 6) {
              FocusManager.instance.primaryFocus?.unfocus();
            }
          },
          pinTheme: PinTheme(
            shape: PinCodeFieldShape.box,
            borderRadius: BorderRadius.circular(5),
            fieldHeight: 45,
            fieldWidth: 40,
            selectedColor: Theme.of(context).primaryColor.withOpacity(1),
            activeFillColor: Theme.of(context).primaryColor.withOpacity(1),
            activeColor: Theme.of(context).primaryColor.withOpacity(1),
            inactiveColor: Theme.of(context).primaryColor.withOpacity(.3),
            inactiveFillColor: Theme.of(context).primaryColor.withOpacity(.3),
            errorBorderColor: Theme.of(context).primaryColor.withOpacity(.3),
            disabledColor: Theme.of(context).primaryColor.withOpacity(.3),
            selectedFillColor: Theme.of(context).primaryColor.withOpacity(1),
            selectedBorderWidth: 1,
            activeBorderWidth: 1,
            borderWidth: 1,
          ),
        )));
  }
}
