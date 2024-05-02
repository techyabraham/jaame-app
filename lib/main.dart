import 'package:adescrow_app/routes/routes.dart';
import 'package:adescrow_app/utils/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import 'backend/backend_utils/network_check/dependency_injection.dart';
import 'language/english.dart';
import 'language/language_controller.dart';

void main() async {
  // Locking Device Orientation
  WidgetsFlutterBinding.ensureInitialized();
  await ScreenUtil.ensureScreenSize();

  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  InternetCheckDependencyInjection.init();
  // main app
  runApp(const MyApp());
}

// This widget is the root of your application.
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(414, 896),
      builder: (_, child) => GetMaterialApp(
        title: Strings.appName,
        debugShowCheckedModeBanner: false,
        theme: Themes.light,
        darkTheme: Themes.dark,
        themeMode: Themes().theme,

        navigatorKey: Get.key,
        initialRoute: Routes.splashScreen,
        getPages: Routes.list,
        // translations: LocalString(),
        locale: const Locale('en'),
        initialBinding: BindingsBuilder(
              () {
            Get.put(LanguageSettingController(),permanent: true);
          },
        ),
        builder: (context, widget) {
          ScreenUtil.init(context);
          return Obx(() => MediaQuery(
            data: MediaQuery.of(context).copyWith(textScaler: const TextScaler.linear(1.0)),
            child: Directionality(
              textDirection: Get.find<LanguageSettingController>().isLoading
                  ? TextDirection.ltr
                  // : TextDirection.ltr,
                  : Get.find<LanguageSettingController>().languageDirection,
              child: widget!,
            ),
          ));
        },
      ),
    );
  }
}
