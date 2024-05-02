import '../../../widgets/custom_dropdown_widget/custom_dropdown_widget.dart';

class MoneyExchangeIndexModel {
  final Data data;

  MoneyExchangeIndexModel({
    required this.data,
  });

  factory MoneyExchangeIndexModel.fromJson(Map<String, dynamic> json) => MoneyExchangeIndexModel(
    data: Data.fromJson(json["data"]),
  );
}

class Data {
  final List<UserWallet> userWallet;
  final Charges charges;

  Data({
    required this.userWallet,
    required this.charges,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    userWallet: List<UserWallet>.from(json["userWallet"].map((x) => UserWallet.fromJson(x))),
    charges: Charges.fromJson(json["charges"]),
  );
}

class Charges {
  final String title;
  final double fixedCharge;
  final double percentCharge;
  final double minLimit;
  final double maxLimit;
  final String currencyCode;
  final String currencySymbol;

  Charges({
    required this.title,
    required this.fixedCharge,
    required this.percentCharge,
    required this.minLimit,
    required this.maxLimit,
    required this.currencyCode,
    required this.currencySymbol,
  });

  factory Charges.fromJson(Map<String, dynamic> json) => Charges(
    title: json["title"],
    fixedCharge: double.parse(json["fixed_charge"].toString()),
    percentCharge: double.parse(json["percent_charge"].toString()),
    minLimit: double.parse(json["min_limit"].toString()),
    maxLimit: double.parse(json["max_limit"].toString()),
    currencyCode: json["currency_code"],
    currencySymbol: json["currency_symbol"],
  );
}

class UserWallet extends DropdownModel{
  final String name;
  final double balance;
  @override
  final String currencyCode;
  @override
  final String currencySymbol;
  final String currencyType;
  @override
  final double rate;
  final String flag;
  final String imagePath;

  UserWallet({
    required this.name,
    required this.balance,
    required this.currencyCode,
    required this.currencySymbol,
    required this.currencyType,
    required this.rate,
    required this.flag,
    required this.imagePath,
  });

  factory UserWallet.fromJson(Map<String, dynamic> json) => UserWallet(
    name: json["name"],
    balance: json["balance"].toDouble(),
    currencyCode: json["currency_code"],
    currencySymbol: json["currency_symbol"],
    currencyType: json["currency_type"],
    rate: json["rate"].toDouble(),
    flag: json["flag"],
    imagePath: json["image_path"],
  );

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
  String get mcode => throw UnimplementedError();

  @override
  // TODO: implement min
  double get min => throw UnimplementedError();

  @override
  // TODO: implement pCharge
  double get pCharge => throw UnimplementedError();

  @override
  // TODO: implement title
  String get title => currencyCode;

  @override
  // TODO: implement type
  String get type => currencyType;
}