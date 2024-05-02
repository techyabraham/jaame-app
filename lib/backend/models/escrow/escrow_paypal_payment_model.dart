class EscrowPaypalPaymentModel {
  final Data data;

  EscrowPaypalPaymentModel({
    required this.data,
  });

  factory EscrowPaypalPaymentModel.fromJson(Map<String, dynamic> json) => EscrowPaypalPaymentModel(
    data: Data.fromJson(json["data"]),
  );
}

class Data {
  final List<Url> url;

  Data({
    required this.url,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    url: List<Url>.from(json["url"].map((x) => Url.fromJson(x))),
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