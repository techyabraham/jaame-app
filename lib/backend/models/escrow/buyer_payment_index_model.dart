import 'escrow_create_model.dart';

class BuyerPaymentIndexModel {
  final Data data;

  BuyerPaymentIndexModel({
    required this.data,
  });

  factory BuyerPaymentIndexModel.fromJson(Map<String, dynamic> json) => BuyerPaymentIndexModel(
    data: Data.fromJson(json["data"]),
  );
}

class Data {
  final EscrowInformation escrowInformation;
  final UserWallet userWallet;
  final List<GatewayCurrency> gatewayCurrencies;

  Data({
    required this.escrowInformation,
    required this.userWallet,
    required this.gatewayCurrencies,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    escrowInformation: EscrowInformation.fromJson(json["escrow_information"]),
    userWallet: UserWallet.fromJson(json["user_wallet"]),
    gatewayCurrencies: List<GatewayCurrency>.from(json["gateway_currencies"].map((x) => GatewayCurrency.fromJson(x))),
  );
}

class EscrowInformation {
  final int id;
  final String title;
  final String role;
  final String amount;
  final String escrowCurrency;
  final String category;
  final String chargePayer;
  final String totalCharge;
  final int status;
  final DateTime createdAt;

  EscrowInformation({
    required this.id,
    required this.title,
    required this.role,
    required this.amount,
    required this.escrowCurrency,
    required this.category,
    required this.chargePayer,
    required this.totalCharge,
    required this.status,
    required this.createdAt,
  });

  factory EscrowInformation.fromJson(Map<String, dynamic> json) => EscrowInformation(
    id: json["id"],
    title: json["title"],
    role: json["role"],
    amount: json["amount"],
    escrowCurrency: json["escrow_currency"],
    category: json["category"],
    chargePayer: json["charge_payer"],
    totalCharge: json["total_charge"],
    status: json["status"],
    createdAt: DateTime.parse(json["created_at"]),
  );
}

// class GatewayCurrency {
//   final int id;
//   final int paymentGatewayId;
//   final String type;
//   final String name;
//   final String alias;
//   final String currencyCode;
//   final String currencySymbol;
//   final dynamic image;
//   final double minLimit;
//   final double maxLimit;
//   final double percentCharge;
//   final double fixedCharge;
//   final double rate;
//   final DateTime createdAt;
//   final DateTime updatedAt;
//
//   GatewayCurrency({
//     required this.id,
//     required this.paymentGatewayId,
//     required this.type,
//     required this.name,
//     required this.alias,
//     required this.currencyCode,
//     required this.currencySymbol,
//     required this.image,
//     required this.minLimit,
//     required this.maxLimit,
//     required this.percentCharge,
//     required this.fixedCharge,
//     required this.rate,
//     required this.createdAt,
//     required this.updatedAt,
//   });
//
//   factory GatewayCurrency.fromJson(Map<String, dynamic> json) => GatewayCurrency(
//     id: json["id"],
//     paymentGatewayId: json["payment_gateway_id"],
//     type: json["type"],
//     name: json["name"],
//     alias: json["alias"],
//     currencyCode: json["currency_code"],
//     currencySymbol: json["currency_symbol"],
//     image: json["image"] ?? "",
//     minLimit: json["min_limit"].toDouble(),
//     maxLimit: json["max_limit"].toDouble(),
//     percentCharge: json["percent_charge"].toDouble(),
//     fixedCharge: json["fixed_charge"].toDouble(),
//     rate: json["rate"].toDouble(),
//     createdAt: DateTime.parse(json["created_at"]),
//     updatedAt: DateTime.parse(json["updated_at"]),
//   );
// }

class UserWallet {
  final String amount;

  UserWallet({
    required this.amount,
  });

  factory UserWallet.fromJson(Map<String, dynamic> json) => UserWallet(
    amount: json["amount"],
  );
}