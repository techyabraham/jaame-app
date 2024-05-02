import '../conversation/conversation_model.dart';

class EscrowIndexModel {
  final Data data;

  EscrowIndexModel({
    required this.data,
  });

  factory EscrowIndexModel.fromJson(Map<String, dynamic> json) => EscrowIndexModel(
    data: Data.fromJson(json["data"]),
  );
}

class Data {
  final List<EscrowDatum> escrowData;
  final String baseUrl;

  Data({
    required this.escrowData,
    required this.baseUrl,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    escrowData: List<EscrowDatum>.from(json["escrow_data"].map((x) => EscrowDatum.fromJson(x))),
    baseUrl: json["base_url"],
  );
}

class EscrowDatum {
  final int id;
  final int userId;
  final String escrowId;
  final String title;
  final String role;
  final String amount;
  final String escrowCurrency;
  final String category;
  final String totalCharge;
  final String chargePayer;
  final dynamic remarks;
  final List<Attachment>? attachments;
  final int status;
  final DateTime createdAt;

  EscrowDatum({
    required this.id,
    required this.userId,
    required this.escrowId,
    required this.title,
    required this.role,
    required this.amount,
    required this.escrowCurrency,
    required this.category,
    required this.totalCharge,
    required this.chargePayer,
    required this.remarks,
    required this.attachments,
    required this.status,
    required this.createdAt,
  });

  factory EscrowDatum.fromJson(Map<String, dynamic> json) => EscrowDatum(
    id: json["id"],
    userId: json["user_id"],
    escrowId: json["escrow_id"],
    title: json["title"],
    role: json["role"],
    amount: json["amount"],
    escrowCurrency: json["escrow_currency"],
    category: json["category"],
    totalCharge: json["total_charge"],
    chargePayer: json["charge_payer"],
    remarks: json["remarks"] ?? "",
    attachments: List<Attachment>.from(json["attachments"].map((x) => Attachment.fromJson(x)) ?? []),
    status: json["status"],
    createdAt: DateTime.parse(json["created_at"]),
  );
}