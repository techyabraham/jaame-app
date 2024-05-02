class EscrowAutomaticPaymentModel {
  final Data data;

  EscrowAutomaticPaymentModel({
    required this.data,
  });

  factory EscrowAutomaticPaymentModel.fromJson(Map<String, dynamic> json) => EscrowAutomaticPaymentModel(
    data: Data.fromJson(json["data"]),
  );
}

class Data {
  final String url;

  Data({
    required this.url,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    url: json["url"],
  );
}