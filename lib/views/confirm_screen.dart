
import 'package:adescrow_app/utils/basic_screen_imports.dart';
import 'package:adescrow_app/utils/responsive_layout.dart';

import '../../../widgets/text_labels/title_sub_title_widget.dart';

class ConfirmScreen extends StatelessWidget{
  const ConfirmScreen({super.key,
    required this.message,
    required this.onOkayTap,
    this.onApproval = false
  });
  final String message;
  final bool onApproval;
  final VoidCallback onOkayTap;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      // ignore: deprecated_member_use
      child: WillPopScope(
        onWillPop: () async {
          onOkayTap;
          return false;
        },
        child: ResponsiveLayout(
          mobileScaffold: Scaffold(
            backgroundColor: Theme.of(context).scaffoldBackgroundColor,
            body: Column(
              children: [
                _upperIconWidget(context),
                _bottomBodyWidget(context),
              ],
            ),
          ),
        ),
      ),
    );
  }

  _upperIconWidget(BuildContext context) {
    return Expanded(
      flex: 6,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeHorizontal * .5,
        vertical: Dimensions.paddingSizeVertical * .5),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Image.asset(  onApproval ? "assets/placeholder/warn.png": "assets/placeholder/confirmation.png"),
          ],
        ),
      ),
    );
  }

  _bottomBodyWidget(BuildContext context) {
    return Expanded(
      flex: 5,
      child: Container(
        decoration: BoxDecoration(
            color: CustomColor.whiteColor,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(Dimensions.radius * 3),
              topRight: Radius.circular(Dimensions.radius * 3),
            )),
        child: ListView(
          shrinkWrap: true,
          physics: const BouncingScrollPhysics(),
          children: [
            SizedBox(
              width: MediaQuery.of(context).size.width,
              child: TitleSubTitleWidget(
                title: Strings.congratulations,
                subTitle: message,
              ),
            ),

            verticalSpace(Dimensions.paddingSizeVertical * 1),

            // primary button
            Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: Dimensions.paddingSizeHorizontal * .5
              ),
              child: PrimaryButton(
                title: Strings.okay,
                onPressed: onOkayTap,
              ),
            ),

          ],
        ),
      ),
    );
  }
}
