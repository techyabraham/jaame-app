class BasicSettingModel {
  final Data data;

  BasicSettingModel({
    required this.data,
  });

  factory BasicSettingModel.fromJson(Map<String, dynamic> json) => BasicSettingModel(
    data: Data.fromJson(json["data"]),
  );
}

class Data {
  final String siteName;
  final String defaultImage;
  final String imagePath;
  final List<OnboardScreen> onboardScreen;
  final SplashScreen splashScreen;
  final AppUrl appUrl;
  final AllLogo allLogo;
  final String logoImagePath;

  Data({
    required this.siteName,
    required this.defaultImage,
    required this.imagePath,
    required this.onboardScreen,
    required this.splashScreen,
    required this.appUrl,
    required this.allLogo,
    required this.logoImagePath,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    siteName: json["site_name"],
    defaultImage: json["default_image"],
    imagePath: json["image_path"],
    onboardScreen: List<OnboardScreen>.from(json["onboard_screen"].map((x) => OnboardScreen.fromJson(x))),
    splashScreen: SplashScreen.fromJson(json["splash_screen"]),
    appUrl: AppUrl.fromJson(json["app_url"]),
    allLogo: AllLogo.fromJson(json["all_logo"]),
    logoImagePath: json["logo_image_path"],
  );
}

class AllLogo {
  final String siteLogoDark;
  final String siteLogo;
  final String siteFavDark;
  final String siteFav;

  AllLogo({
    required this.siteLogoDark,
    required this.siteLogo,
    required this.siteFavDark,
    required this.siteFav,
  });

  factory AllLogo.fromJson(Map<String, dynamic> json) => AllLogo(
    siteLogoDark: json["site_logo_dark"],
    siteLogo: json["site_logo"],
    siteFavDark: json["site_fav_dark"],
    siteFav: json["site_fav"],
  );
}

class AppUrl {
  final int id;
  final dynamic androidUrl;
  final dynamic isoUrl;
  final DateTime createdAt;
  final DateTime updatedAt;

  AppUrl({
    required this.id,
    required this.androidUrl,
    required this.isoUrl,
    required this.createdAt,
    required this.updatedAt,
  });

  factory AppUrl.fromJson(Map<String, dynamic> json) => AppUrl(
    id: json["id"],
    androidUrl: json["android_url"],
    isoUrl: json["iso_url"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
  );
}

class OnboardScreen {
  final int id;
  final String title;
  final String subTitle;
  final String image;
  final int status;
  final DateTime createdAt;
  final DateTime updatedAt;

  OnboardScreen({
    required this.id,
    required this.title,
    required this.subTitle,
    required this.image,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
  });

  factory OnboardScreen.fromJson(Map<String, dynamic> json) => OnboardScreen(
    id: json["id"],
    title: json["title"],
    subTitle: json["sub_title"],
    image: json["image"],
    status: json["status"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
  );
}

class SplashScreen {
  final int id;
  final String splashScreenImage;
  final String version;
  final DateTime createdAt;
  final DateTime updatedAt;

  SplashScreen({
    required this.id,
    required this.splashScreenImage,
    required this.version,
    required this.createdAt,
    required this.updatedAt,
  });

  factory SplashScreen.fromJson(Map<String, dynamic> json) => SplashScreen(
    id: json["id"],
    splashScreenImage: json["splash_screen_image"],
    version: json["version"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
  );
}