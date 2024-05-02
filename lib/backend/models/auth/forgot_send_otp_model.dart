class ForgetSendOtpModel {
  final Message message;
  final Data data;

  ForgetSendOtpModel({
    required this.message,
    required this.data,
  });

  factory ForgetSendOtpModel.fromJson(Map<String, dynamic> json) => ForgetSendOtpModel(
    message: Message.fromJson(json["message"]),
    data: Data.fromJson(json["data"]),
  );
}

class Data {
  final User user;

  Data({
    required this.user,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    user: User.fromJson(json["user"]),
  );
}

class User {
  final String token;

  User({
    required this.token,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
    token: json["token"],
  );
}

class Message {
  final List<String> success;

  Message({
    required this.success,
  });

  factory Message.fromJson(Map<String, dynamic> json) => Message(
    success: List<String>.from(json["success"].map((x) => x)),
  );
}