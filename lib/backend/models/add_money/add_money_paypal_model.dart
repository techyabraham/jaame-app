import 'payment_information_model.dart';

class AddMoneyPaypalModel {
  final Data data;

  AddMoneyPaypalModel({
    required this.data,
  });

  factory AddMoneyPaypalModel.fromJson(Map<String, dynamic> json) => AddMoneyPaypalModel(
    data: Data.fromJson(json["data"]),
  );
}

class Data {
  final String gategayType;
  final String gatewayCurrencyName;
  final String alias;
  final String identify;
  final PaymentInformations paymentInformations;
  final List<Url> url;
  final String method;

  Data({
    required this.gategayType,
    required this.gatewayCurrencyName,
    required this.alias,
    required this.identify,
    required this.paymentInformations,
    required this.url,
    required this.method,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    gategayType: json["gategay_type"],
    gatewayCurrencyName: json["gateway_currency_name"],
    alias: json["alias"],
    identify: json["identify"],
    paymentInformations: PaymentInformations.fromJson(json["payment_informations"]),
    url: List<Url>.from(json["url"].map((x) => Url.fromJson(x))),
    method: json["method"],
  );
}


class Url {
  final String href;
  final String rel;
  final String method;

  Url({
    required this.href,
    required this.rel,
    required this.method,
  });

  factory Url.fromJson(Map<String, dynamic> json) => Url(
    href: json["href"],
    rel: json["rel"],
    method: json["method"],
  );
}
