import 'dart:core';
import 'package:adescrow_app/utils/basic_screen_imports.dart';
import 'package:adescrow_app/widgets/others/custom_loading_widget.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

import '../../routes/routes.dart';


class WebViewScreen extends StatefulWidget {
  final String link, appTitle;
  final Function? onFinished;
  final bool beforeAuth;

  const WebViewScreen({super.key, required this.link, required this.appTitle, this.onFinished, this.beforeAuth = false});

  @override
  State<WebViewScreen> createState() => _WebViewScreenState();
}

class _WebViewScreenState extends State<WebViewScreen> {
  bool isLoading = false;


  @override
  Widget build(BuildContext context) {

      return SafeArea(
        // ignore: deprecated_member_use
        child: WillPopScope(
          onWillPop: ()async{
            widget.beforeAuth ?  Get.offAllNamed(Routes.loginScreen): Get.offAllNamed(Routes.dashboardScreen);
            return false;
          },
          child: Scaffold(
            appBar: PrimaryAppBar(
              title: widget.appTitle,
              onTap: (){
                widget.beforeAuth ?  Get.offAllNamed(Routes.loginScreen): Get.offAllNamed(Routes.dashboardScreen);
              },
            ),

            body: Stack(
              children: [
                InAppWebView(
                  initialUrlRequest: URLRequest(url: WebUri(widget.link)), // Replace with your checkout URL
                  onWebViewCreated: (InAppWebViewController controller) {},
                  onLoadStart: (InAppWebViewController controller, Uri? url) {
                    widget.onFinished!(url);
                    setState(() {
                      isLoading = true;
                    });
                  },
                  onLoadStop: (InAppWebViewController controller, Uri? url) {
                    setState(() {
                      isLoading = false;
                    });
                  },
                ),
                Visibility(visible: isLoading, child: const CustomLoadingWidget())
              ],
            )
          ),
        ),
      );

  }
}