class ConversationModel {
  final Data data;

  ConversationModel({
    required this.data,
  });

  factory ConversationModel.fromJson(Map<String, dynamic> json) => ConversationModel(
    data: Data.fromJson(json["data"]),
  );
}

class Data {
  final int status;
  final List<EscrowConversation> escrowConversations;

  Data({
    required this.status,
    required this.escrowConversations,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    status: json["status"],
    escrowConversations: List<EscrowConversation>.from(json["escrow_conversations"].map((x) => EscrowConversation.fromJson(x))),
  );
}

class EscrowConversation {
  // final int sender;
  final String messageSender;
  final String message;
  final List<Attachment> attachments;
  final String profileImg;

  EscrowConversation({
    // required this.sender,
    required this.messageSender,
    required this.message,
    required this.attachments,
    required this.profileImg,
  });

  factory EscrowConversation.fromJson(Map<String, dynamic> json) => EscrowConversation(
    // sender: json["sender"],
    messageSender: json["message_sender"],
    message: json["message"] ?? "",
    attachments: List<Attachment>.from(json["attachments"].map((x) => Attachment.fromJson(x))),
    profileImg: json["profile_img"],
  );
}

class Attachment {
  final String fileName;
  final String fileType;
  final String filePath;

  Attachment({
    required this.fileName,
    required this.fileType,
    required this.filePath,
  });

  factory Attachment.fromJson(Map<String, dynamic> json) => Attachment(
    fileName: json["file_name"],
    fileType: json["file_type"],
    filePath: json["file_path"],
  );
}