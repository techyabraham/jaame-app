import '../../../widgets/custom_dropdown_widget/custom_dropdown_widget.dart';

class ProfileModel {
  final Data data;

  ProfileModel({
    required this.data,
  });

  factory ProfileModel.fromJson(Map<String, dynamic> json) => ProfileModel(
    data: Data.fromJson(json["data"]),
  );
}

class Data {
  final String defaultImage;
  final String imagePath;
  final String baseUr;
  final User user;
  final List<Country> countries;


  Data({
    required this.defaultImage,
    required this.imagePath,
    required this.baseUr,
    required this.user,
    required this.countries,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    defaultImage: json["default_image"],
    imagePath: json["image_path"],
    baseUr: json["base_ur"],
    user: User.fromJson(json["user"]),
    countries: List<Country>.from(json["countries"].map((x) => Country.fromJson(x))),
  );
}

class Country extends DropdownModel{
  final String name;
  final String mobileCode;

  Country({
    required this.name,
    required this.mobileCode
  });

  factory Country.fromJson(Map<String, dynamic> json) =>
      Country(
        name: json["name"],
        mobileCode: json["mobile_code"]
      );

  @override
  // TODO: implement currencyCode
  String get currencyCode => throw UnimplementedError();

  @override
  // TODO: implement currencySymbol
  String get currencySymbol => throw UnimplementedError();

  @override
  // TODO: implement fCharge
  double get fCharge => throw UnimplementedError();

  @override
  // TODO: implement id
  String get id => throw UnimplementedError();

  @override
  // TODO: implement img
  String get img => throw UnimplementedError();

  @override
  // TODO: implement max
  double get max => throw UnimplementedError();

  @override
  // TODO: implement mcode
  String get mcode => mobileCode;

  @override
  // TODO: implement min
  double get min => throw UnimplementedError();

  @override
  // TODO: implement pCharge
  double get pCharge => throw UnimplementedError();

  @override
  // TODO: implement rate
  double get rate => throw UnimplementedError();

  @override
  // TODO: implement title
  String get title => name;

  @override
  // TODO: implement type
  String get type => throw UnimplementedError();
}

class User{
  final int id;
  final String firstname;
  final String lastname;
  final String username;
  final String email;
  final String type;
  final dynamic mobileCode;
  final dynamic mobile;
  final dynamic fullMobile;
  final String image;
  final Address address;
  final String fullname;
  final String userImage;

  User({
    required this.id,
    required this.firstname,
    required this.lastname,
    required this.username,
    required this.email,
    required this.type,
    required this.mobileCode,
    required this.mobile,
    required this.fullMobile,
    required this.image,
    required this.address,
    required this.fullname,
    required this.userImage,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
    id: json["id"],
    firstname: json["firstname"],
    lastname: json["lastname"],
    username: json["username"],
    email: json["email"],
    type: json["type"],
    mobileCode: json["mobile_code"] ?? "",
    mobile: json["mobile"] ?? "",
    fullMobile: json["full_mobile"] ?? "",
    image: json["image"] ?? "",
    address: Address.fromJson(json["address"] ?? {}),
    fullname: json["fullname"],
    userImage: json["userImage"],
  );
}

class Address {
  final dynamic country;
  final dynamic state;
  final dynamic city;
  final dynamic zip;
  final dynamic address;

  Address({
    required this.country,
    required this.state,
    required this.city,
    required this.zip,
    required this.address,
  });

  factory Address.fromJson(Map<String, dynamic> json) => Address(
    country: json["country"] ?? "",
    state: json["state"] ?? "",
    city: json["city"] ?? "",
    zip: json["zip"] ?? "",
    address: json["address"] ?? "",
  );
}