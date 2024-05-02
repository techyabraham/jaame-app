class TwoFaInfoModel {
  final Data data;

  TwoFaInfoModel({
    required this.data,
  });

  factory TwoFaInfoModel.fromJson(Map<String, dynamic> json) => TwoFaInfoModel(
    data: Data.fromJson(json["data"]),
  );
}

class Data {
  final String qrCode;
  final String qrSecrete;
  final int qrStatus;
  final String alert;

  Data({
    required this.qrCode,
    required this.qrSecrete,
    required this.qrStatus,
    required this.alert,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    qrCode: json["qr_code"],
    qrSecrete: json["qr_secrete"],
    qrStatus: json["qr_status"],
    alert: json["alert"],
  );
}