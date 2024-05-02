
class PaymentInformations {
  final String trx;
  final String gatewayCurrencyName;
  final String requestAmount;
  final String exchangeRate;
  final String totalCharge;
  final String willGet;
  final String payableAmount;

  PaymentInformations({
    required this.trx,
    required this.gatewayCurrencyName,
    required this.requestAmount,
    required this.exchangeRate,
    required this.totalCharge,
    required this.willGet,
    required this.payableAmount,
  });

  factory PaymentInformations.fromJson(Map<String, dynamic> json) => PaymentInformations(
    trx: json["trx"],
    gatewayCurrencyName: json["gateway_currency_name"],
    requestAmount: json["request_amount"],
    exchangeRate: json["exchange_rate"],
    totalCharge: json["total_charge"],
    willGet: json["will_get"] ?? "",
    payableAmount: json["payable_amount"],
  );
}