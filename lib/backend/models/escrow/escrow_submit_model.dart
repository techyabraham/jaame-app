class EscrowSubmitModel {
  final Data data;

  EscrowSubmitModel({
    required this.data,
  });

  factory EscrowSubmitModel.fromJson(Map<String, dynamic> json) => EscrowSubmitModel(
    data: Data.fromJson(json["data"]),
  );
}

class Data {
  final EscrowInformation escrowInformation;
  final String returnUrl;
  final String method;

  Data({
    required this.escrowInformation,
    required this.returnUrl,
    required this.method,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    escrowInformation: EscrowInformation.fromJson(json["escrow_information"]),
    returnUrl: json["return_url"],
    method: json["method"],
  );
}

class EscrowInformation {
  final String trx;
  final String title;
  final String category;
  final String myRole;
  final String totalAmount;
  final String chargePayer;
  final String fee;
  final String sellerAmount;
  final String payWith;
  final String exchangeRate;
  final String buyerAmount;

  EscrowInformation({
    required this.trx,
    required this.title,
    required this.category,
    required this.myRole,
    required this.totalAmount,
    required this.chargePayer,
    required this.fee,
    required this.sellerAmount,
    required this.payWith,
    required this.exchangeRate,
    required this.buyerAmount,
  });

  factory EscrowInformation.fromJson(Map<String, dynamic> json) => EscrowInformation(
    trx: json["trx"],
    title: json["title"],
    category: json["category"],
    myRole: json["my_role"],
    totalAmount: json["total_amount"],
    chargePayer: json["charge_payer"],
    fee: json["fee"],
    sellerAmount: json["seller_amount"],
    payWith: json["pay_with"],
    exchangeRate: json["exchange_rate"],
    buyerAmount: json["buyer_amount"],
  );

}