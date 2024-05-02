import 'payment_information_model.dart';

class AddMoneyAutomaticModel {
  final Data data;

  AddMoneyAutomaticModel({
    required this.data,
  });

  factory AddMoneyAutomaticModel.fromJson(Map<String, dynamic> json) => AddMoneyAutomaticModel(
    data: Data.fromJson(json["data"]),
  );
}

class Data {
  final String gatewayType;
  final String gatewayCurrencyName;
  final String alias;
  final String identify;
  final PaymentInformations paymentInformations;
  final String url;
  final String method;

  Data({
    required this.gatewayType,
    required this.gatewayCurrencyName,
    required this.alias,
    required this.identify,
    required this.paymentInformations,
    required this.url,
    required this.method,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    gatewayType: json["gateway_type"],
    gatewayCurrencyName: json["gateway_currency_name"],
    alias: json["alias"],
    identify: json["identify"],
    paymentInformations: PaymentInformations.fromJson(json["payment_informations"]),
    url: json["url"],
    method: json["method"],
  );
}