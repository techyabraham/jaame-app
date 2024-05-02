import 'package:adescrow_app/widgets/others/custom_loading_widget.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../../utils/basic_widget_imports.dart';
import '../../utils/responsive_layout.dart';
import '../buttons/primary_button.dart';

class KeyboardScreenWidget extends StatefulWidget {
  const KeyboardScreenWidget(
      {super.key,
      required this.buttonText,
      required this.onTap,
      required this.amountController,
      this.isLoading,
      required this.widget});

  final String buttonText;
  final VoidCallback onTap;
  final Widget widget;
  final bool? isLoading;
  final TextEditingController amountController;

  @override
  State<KeyboardScreenWidget> createState() => _KeyboardScreenWidgetState();
}

class _KeyboardScreenWidgetState extends State<KeyboardScreenWidget> {
  List<String> keyboardItemList = [
    '1',
    '2',
    '3',
    '4',
    '5',
    '6',
    '7',
    '8',
    '9',
    '.',
    '0',
    '<'
  ];

  @override
  Widget build(BuildContext context) {
    return _bodyWidget(context);
  }

  _bodyWidget(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: CustomColor.whiteColor,
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(Dimensions.radius * 3),
            topLeft: Radius.circular(Dimensions.radius * 3),
          )),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            verticalSpace(Dimensions.heightSize * 1),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                widget.widget,
              ],
            ),
            verticalSpace(Dimensions.heightSize * 2),
            _customNumKeyBoardWidget(context),
            verticalSpace(Dimensions.marginSizeVertical * .5),
            _buttonWidget(context),
            verticalSpace(Dimensions.heightSize)
          ],
        ),
      ),
    );
  }

  _customNumKeyBoardWidget(BuildContext context) {
    return ResponsiveLayout(
      mobileScaffold: GridView.count(
        physics: const NeverScrollableScrollPhysics(),
        crossAxisCount: 3,
        crossAxisSpacing: 10.0,
        mainAxisSpacing: 10.0,
        childAspectRatio: 3 / 1.7,
        shrinkWrap: true,
        children: List.generate(
          keyboardItemList.length,
              (index) {
            return inputItem(index);
          },
        ),
      ),
      tabletScaffold: GridView.count(
        padding: EdgeInsets.symmetric(
          horizontal: Dimensions.paddingSizeHorizontal * 2
        ),
        physics: const NeverScrollableScrollPhysics(),
        crossAxisCount: 3,
        crossAxisSpacing: 10.0,
        mainAxisSpacing: 10.0,
        childAspectRatio: 3 / 1.7,
        shrinkWrap: true,
        children: List.generate(
          keyboardItemList.length,
              (index) {
            return inputItem(index);
          },
        ),
      ),
    );
  }

  _buttonWidget(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(
        horizontal: Dimensions.marginSizeHorizontal * 0.8,
      ),
      child: keyboard(),
    );
  }

  keyboard() {
    return Row(
      children: [
        Expanded(
          child: widget.isLoading!
              ? const CustomLoadingWidget()
              : PrimaryButton(
                  title: widget.buttonText,
                  onPressed: widget.onTap,
                ),
        ),
      ],
    );
  }

  List<String> totalAmount = [];
  RxBool inLength = true.obs;

  inputItem(int index) {
    return Obx(() => InkWell(
          splashColor: inLength.value ? Colors.white : Colors.red,
          borderRadius: BorderRadius.circular(100),
          onLongPress: () {
            setState(() {
              if (index == 11) {
                if (totalAmount.isNotEmpty) {
                  totalAmount.clear();
                  widget.amountController.text = totalAmount.join('');
                } else {
                  return;
                }
              }
            });
          },
          onTap: () {
            setState(() {
              if (widget.amountController.text.length < 6) {
                inLength.value = true;
                if (index == 11) {
                  if (totalAmount.isNotEmpty) {
                    totalAmount.removeLast();
                    widget.amountController.text = totalAmount.join('');
                  } else {
                    return;
                  }
                } else {
                  if (totalAmount.contains('.') && index == 9) {
                    return;
                  } else {
                    totalAmount.add(keyboardItemList[index]);
                    widget.amountController.text = totalAmount.join('');
                    debugPrint(totalAmount.join(''));
                  }
                }
              } else {
                inLength.value = false;
                if (index == 11) {
                  inLength.value = true;
                  if (totalAmount.isNotEmpty) {
                    totalAmount.removeLast();
                    widget.amountController.text = totalAmount.join('');
                  } else {
                    return;
                  }
                }
              }
            });
          },
          child: Center(
            child: Animate(
              effects: const [FadeEffect(), ScaleEffect()],
              child: TitleHeading1Widget(
                text: keyboardItemList[index],
                fontSize: Dimensions.headingTextSize3 * 2,
              ),
            ),
          ),
        ));
  }
}
