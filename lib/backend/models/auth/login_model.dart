
class LoginModel {
  final Message message;
  final Data data;

  LoginModel({
    required this.message,
    required this.data,
  });

  factory LoginModel.fromJson(Map<String, dynamic> json) => LoginModel(
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
  final int smsVerified;
  final int kycVerified;
  final int twoFactorVerified;
  final int twoFactorStatus;

  User({
    required this.emailVerified,
    required this.smsVerified,
    required this.kycVerified,
    required this.twoFactorVerified,
    // required this.twoFactorSecret,
    required this.twoFactorStatus,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
    emailVerified: json["email_verified"],
    smsVerified: json["sms_verified"],
    kycVerified: json["kyc_verified"],
    twoFactorVerified: json["two_factor_verified"],
    // twoFactorSecret: json["two_factor_secret"],
    twoFactorStatus: json["two_factor_status"],
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