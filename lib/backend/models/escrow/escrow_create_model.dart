import '../../../widgets/custom_dropdown_widget/custom_dropdown_widget.dart';

class EscrowCreateModel {
  final Data data;

  EscrowCreateModel({
    required this.data,
  });

  factory EscrowCreateModel.fromJson(Map<String, dynamic> json) => EscrowCreateModel(
    data: Data.fromJson(json["data"]),
  );
}

class Data {
  final List<EscrowCategory> escrowCategories;
  final List<UserWallet> userWallet;
  final List<GatewayCurrency> gatewayCurrencies;
  final String userType;
  final String baseUrl;

  Data({
    required this.escrowCategories,
    required this.userWallet,
    required this.gatewayCurrencies,
    required this.userType,
    required this.baseUrl,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    escrowCategories: List<EscrowCategory>.from(json["escrow_categories"].map((x) => EscrowCategory.fromJson(x))),
    userWallet: List<UserWallet>.from(json["user_wallet"].map((x) => UserWallet.fromJson(x))),
    gatewayCurrencies: List<GatewayCurrency>.from(json["gateway_currencies"].map((x) => GatewayCurrency.fromJson(x))),
    baseUrl: json["base_url"],
    userType: json["user_type"],
  );
}

class EscrowCategory extends DropdownModel{
  final int mId;
  final String name;

  EscrowCategory({
    required this.mId,
    required this.name,
  });

  factory EscrowCategory.fromJson(Map<String, dynamic> json) => EscrowCategory(
    mId: json["id"],
    name: json["name"],
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
  String get id => mId.toString();

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
  // TODO: implement rate
  double get rate => throw UnimplementedError();

  @override
  // TODO: implement title
  String get title => name;

  @override
  // TODO: implement type
  String get type => throw UnimplementedError();
}

class GatewayCurrency extends DropdownModel{
  final int mId;
  final int paymentGatewayId;
  final String mType;
  final String name;
  final String alias;
  final String mCurrencyCode;
  final String mCurrencySymbol;
  final dynamic image;
  final double minLimit;
  final double maxLimit;
  final double percentCharge;
  final double fixedCharge;
  final double mRate;

  GatewayCurrency({
    required this.mId,
    required this.paymentGatewayId,
    required this.mType,
    required this.name,
    required this.alias,
    required this.mCurrencyCode,
    required this.mCurrencySymbol,
    required this.image,
    required this.minLimit,
    required this.maxLimit,
    required this.percentCharge,
    required this.fixedCharge,
    required this.mRate,
  });

  factory GatewayCurrency.fromJson(Map<String, dynamic> json) => GatewayCurrency(
    mId: json["id"],
    paymentGatewayId: json["payment_gateway_id"],
    mType: json["type"],
    name: json["name"],
    alias: json["alias"],
    mCurrencyCode: json["currency_code"],
    mCurrencySymbol: json["currency_symbol"],
    image: json["image"] ?? "",
    minLimit: json["min_limit"].toDouble(),
    maxLimit: json["max_limit"].toDouble(),
    percentCharge: json["percent_charge"].toDouble(),
    fixedCharge: json["fixed_charge"].toDouble(),
    mRate: json["rate"].toDouble(),
  );

  @override
  // TODO: implement currencyCode
  String get currencyCode => mCurrencyCode;

  @override
  // TODO: implement currencySymbol
  String get currencySymbol => mCurrencySymbol;

  @override
  // TODO: implement fCharge
  double get fCharge => fixedCharge;

  @override
  // TODO: implement id
  String get id => mId.toString();

  @override
  // TODO: implement img
  String get img => image;

  @override
  // TODO: implement max
  double get max => maxLimit;

  @override
  // TODO: implement mcode
  String get mcode => paymentGatewayId.toString();

  @override
  // TODO: implement min
  double get min => minLimit;

  @override
  // TODO: implement pCharge
  double get pCharge => percentCharge;

  @override
  // TODO: implement rate
  double get rate => mRate;

  @override
  // TODO: implement title
  String get title => name;

  @override
  // TODO: implement type
  String get type => mType;
}

class UserWallet extends DropdownModel{
  final String name;
  final double balance;
  final String mCurrencyCode;
  final String mCurrencySymbol;
  final String currencyType;
  final double mRate;
  final String flag;
  final String imagePath;

  UserWallet({
    required this.name,
    required this.balance,
    required this.mCurrencyCode,
    required this.mCurrencySymbol,
    required this.currencyType,
    required this.mRate,
    required this.flag,
    required this.imagePath,
  });

  factory UserWallet.fromJson(Map<String, dynamic> json) => UserWallet(
    name: json["name"],
    balance: json["balance"].toDouble(),
    mCurrencyCode: json["currency_code"],
    mCurrencySymbol: json["currency_symbol"],
    currencyType: json["currency_type"],
    mRate: json["rate"].toDouble(),
    flag: json["flag"],
    imagePath: json["image_path"],
  );

  @override
  // TODO: implement currencyCode
  String get currencyCode => mCurrencyCode;

  @override
  // TODO: implement currencySymbol
  String get currencySymbol => mCurrencySymbol;

  @override
  // TODO: implement fCharge
  double get fCharge => throw UnimplementedError();

  @override
  // TODO: implement id
  String get id => throw UnimplementedError();

  @override
  // TODO: implement img
  String get img => "$imagePath/$flag";

  @override
  // implement max is balance here
  double get max => balance;

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
  // TODO: implement rate
  double get rate => mRate;

  @override
  // TODO: implement title
  String get title => mCurrencyCode;

  @override
  // TODO: implement type
  String get type => currencyType;
}