class NotificationModel {
  final Data data;

  NotificationModel({
    required this.data,
  });

  factory NotificationModel.fromJson(Map<String, dynamic> json) => NotificationModel(
    data: Data.fromJson(json["data"]),
  );
}

class Data {
  final List<NotificationData> notifications;

  Data({
    required this.notifications,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    notifications: List<NotificationData>.from(json["notifications"].map((x) => NotificationData.fromJson(x))),
  );
}

class NotificationData {
  // final int id;
  // final int userId;
  final String type;
  final Message message;
  // final int seen;
  final DateTime createdAt;

  NotificationData({
    required this.type,
    required this.message,
    required this.createdAt,
  });

  factory NotificationData.fromJson(Map<String, dynamic> json) => NotificationData(

    type: json["type"],
    message: Message.fromJson(json["message"]),
    createdAt: DateTime.parse(json["created_at"]),
  );
}

class Message {
  final String title;
  final String message;
  final String time;

  Message({
    required this.title,
    required this.message,
    required this.time,
  });

  factory Message.fromJson(Map<String, dynamic> json) => Message(
    title: json["title"],
    message: json["message"],
    time: json["time"] ?? "",
  );
}