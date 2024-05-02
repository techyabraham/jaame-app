// To parse this JSON data, do
//
//     final checkStudentModel = checkStudentModelFromJson(jsonString);

class RegistrationModel {
  final Message message;
  final Data data;

  RegistrationModel({
    required this.message,
    required this.data,
  });

  factory RegistrationModel.fromJson(Map<String, dynamic> json) => RegistrationModel(
    message: Message.fromJson(json["message"]),
    data: Data.fromJson(json["data"]),
  );
}

class Data {
  final String token;
  final User user;

  Data({
    required this.token,
    required this.user,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    token: json["token"],
    user: User.fromJson(json["user"]),
  );
}

class User {
  final int emailVerified;
  final int kycVerified;

  User({
    required this.emailVerified,
    required this.kycVerified,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
    emailVerified: json["email_verified"],
    kycVerified: json["kyc_verified"],
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
