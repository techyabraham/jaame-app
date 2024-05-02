import '../add_money/payment_information_model.dart';
import 'cached_tatum_model.dart';

class TatumModel {
  final Data data;

  TatumModel({
    required this.data,
  });

  factory TatumModel.fromJson(Map<String, dynamic> json) => TatumModel(
    data: Data.fromJson(json["data"]),
  );
}

class Data {
  final String gatewayType;
  final String gatewayCurrencyName;
  final String alias;
  final String identify;
  final PaymentInformations paymentInformations;
  final String actionType;
  final AddressInfo addressInfo;

  Data({
    required this.gatewayType,
    required this.gatewayCurrencyName,
    required this.alias,
    required this.identify,
    required this.paymentInformations,
    required this.actionType,
    required this.addressInfo,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    gatewayType: json["gateway_type"] ?? "",
    gatewayCurrencyName: json["gateway_currency_name"],
    alias: json["alias"],
    identify: json["identify"],
    paymentInformations: PaymentInformations.fromJson(json["payment_informations"]),
    actionType: json["action_type"],
    addressInfo: AddressInfo.fromJson(json["address_info"]),
  );
}
