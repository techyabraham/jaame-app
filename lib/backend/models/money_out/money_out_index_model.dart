import '../../../widgets/custom_dropdown_widget/custom_dropdown_widget.dart';
import '../../services/api_endpoint.dart';

class MoneyOutIndexModel {
  final Data data;

  MoneyOutIndexModel({
    required this.data,
  });

  factory MoneyOutIndexModel.fromJson(Map<String, dynamic> json) => MoneyOutIndexModel(
    data: Data.fromJson(json["data"]),
  );
}

class Data {
  final String baseCurr;
  final String baseCurrRate;
  final String defaultImage;
  final String imagePath;
  final String baseUrl;
  final List<UserWallet> userWallet;
  final List<GatewayCurrency> gatewayCurrencies;

  Data({
    required this.baseCurr,
    required this.baseCurrRate,
    required this.defaultImage,
    required this.imagePath,
    required this.baseUrl,
    required this.userWallet,
    required this.gatewayCurrencies,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    baseCurr: json["base_curr"],
    baseCurrRate: json["base_curr_rate"],
    defaultImage: json["default_image"],
    imagePath: json["image_path"],
    baseUrl: json["base_url"],
    userWallet: List<UserWallet>.from(json["userWallet"].map((x) => UserWallet.fromJson(x))),
    gatewayCurrencies: List<GatewayCurrency>.from(json["gatewayCurrencies"].map((x) => GatewayCurrency.fromJson(x))),
  );
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
  // TODO: implement code
  String get mcode => alias;

  @override
  // TODO: implement img
  String get img => image;

  @override
  // TODO: implement title
  String get title => name;

  @override
  // TODO: implement fCharge
  double get fCharge => fixedCharge.toDouble();

  @override
  // TODO: implement max
  double get max => maxLimit.toDouble();

  @override
  // TODO: implement min
  double get min => minLimit.toDouble();

  @override
  // TODO: implement pCharge
  double get pCharge => percentCharge.toDouble();

  @override
  // TODO: implement currencyCode
  String get currencyCode => mCurrencyCode;

  @override
  // TODO: implement currencySymbol
  String get currencySymbol => mCurrencySymbol;

  @override
  // TODO: implement rate
  double get rate => mRate;

  @override
  // TODO: implement type
  String get type => mType;

  @override
  // TODO: implement id
  String get id => paymentGatewayId.toString();
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
  // TODO: implement code
  String get mcode => throw UnimplementedError();

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
  // TODO: implement img
  String get img => "${ApiEndpoint.mainDomain}/$imagePath/$flag";

  @override
  // TODO: implement max
  double get max => throw UnimplementedError();

  @override
  // TODO: implement min
  double get min => throw UnimplementedError();

  @override
  // TODO: implement pCharge
  double get pCharge => throw UnimplementedError();

  @override
  // TODO: implement rate
  double get rate => double.parse(mRate.toString());

  @override
  // TODO: implement title
  String get title => mCurrencyCode;

  @override
  // TODO: implement type
  String get type => throw UnimplementedError();

  @override
  // TODO: implement id
  String get id => throw UnimplementedError();
}