import '../../../../backend/models/conversation/conversation_model.dart';

enum MessageType {own, opposite, admin}

class MessageModel {
  MessageModel({
    required this.message,
    required this.messageType,
    required this.attachments,
  });

  final String message;
  final MessageType messageType;
  final List<Attachment> attachments;
}