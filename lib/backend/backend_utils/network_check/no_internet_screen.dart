import '../../../routes/routes.dart';
import '../../../utils/basic_screen_imports.dart';

class NoInternetScreen extends StatelessWidget {
  const NoInternetScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // ignore: deprecated_member_use
      body: WillPopScope(
          onWillPop: () async => false,
          child: Padding(
            padding: EdgeInsets.symmetric(
                horizontal: Dimensions.paddingSizeHorizontal * 1
            ),
            child: Center(
              child: Column(
                mainAxisAlignment: mainCenter,
                children: [
                  Image.asset("assets/logo/app_launcher.jpg"),
                  verticalSpace(Dimensions.heightSize * 1),
                  const TitleHeading3Widget(text: "Internet Connection!"),
                  verticalSpace(Dimensions.heightSize * 1),
                  const TitleHeading4Widget(
                      text: "Please Check Your Internet Connection. And Reload The Page"),

                  const Spacer(),
                  PrimaryButton(
                    title: "Reload",
                    onPressed: () {
                      Get.offAllNamed(Routes.splashScreen);
                    },
                  ),
                  verticalSpace(Dimensions.heightSize * 1),

                ],
              ),
            ),
          )),
    );
  }
}
