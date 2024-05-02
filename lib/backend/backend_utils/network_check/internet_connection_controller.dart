import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/foundation.dart';


import '../../../utils/basic_screen_imports.dart';
import '../custom_snackbar.dart';

class NetworkController extends GetxController {
  final Connectivity _connectivity = Connectivity();
  late ConnectivityResult connectivityResult;
  late StreamSubscription<ConnectivityResult> _streamSubscription;

  @override
  void onInit() async {
    super.onInit();
    initConnectivity();
    _streamSubscription =
        _connectivity.onConnectivityChanged.listen(_updateConnectionStatus);
  }

  Future<void> initConnectivity() async {
    connectivityResult = await _connectivity.checkConnectivity();
  }

  void _updateConnectionStatus(ConnectivityResult connectivityResult) {
    if (kDebugMode) print("STATUS : $connectivityResult");

    if (connectivityResult == ConnectivityResult.none) {
      // Get.dialog(
      //     barrierDismissible: false,
      //     barrierColor: Get.isDarkMode
      //         ? CustomColor.primaryBGDarkColor
      //         : CustomColor.primaryBGLightColor,
      //     Container(
      //       height: Dimensions.buttonHeight * 5,
      //       margin: EdgeInsets.symmetric(
      //         vertical: Dimensions.paddingSizeVertical * 3
      //       ),
      //       padding: EdgeInsets.symmetric(
      //           horizontal: Dimensions.paddingSizeHorizontal * 1
      //       ),
      //       color: Colors.transparent,
      //       child: Scaffold(
      //         body: WillPopScope(
      //             onWillPop: () async => false,
      //             child: Padding(
      //               padding: EdgeInsets.symmetric(
      //                   horizontal: Dimensions.paddingSizeHorizontal * 1
      //               ),
      //               child: Center(
      //                 child: Column(
      //                   mainAxisAlignment: mainCenter,
      //                   children: [
      //                     Image.asset("assets/logo/app_launcher.jpg"),
      //                     verticalSpace(Dimensions.heightSize * 1),
      //                     const TitleHeading3Widget(text: "Internet Connection!"),
      //                     verticalSpace(Dimensions.heightSize * 1),
      //                     const TitleHeading4Widget(
      //                         text: "Please Check Your Internet Connection. And Reload The Page"),
      //
      //                     const Spacer(),
      //                     PrimaryButton(
      //                       title: "Reload",
      //                       onPressed: () {
      //                         initConnectivity();
      //                       },
      //                     ),
      //                     verticalSpace(Dimensions.heightSize * 1),
      //
      //                   ],
      //                 ),
      //               ),
      //             )),
      //       ),
      //     ));
      CustomSnackBar.error("Please Check Your Internet Connection And Reload The Page");
    } else {
      if ((Get.isDialogOpen ?? false)) {
        Get.back();
      }
    }
  }

  @override
  void onClose() {
    _streamSubscription.cancel();
  }
}
