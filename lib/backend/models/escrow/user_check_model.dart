class UserCheckModel {
  final Data data;

  UserCheckModel({
    required this.data,
  });

  factory UserCheckModel.fromJson(Map<String, dynamic> json) => UserCheckModel(
    data: Data.fromJson(json["data"]),
  );
}

class Data {
  final bool userCheck;

  Data({
    required this.userCheck,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    userCheck: json["user_check"],
  );
}