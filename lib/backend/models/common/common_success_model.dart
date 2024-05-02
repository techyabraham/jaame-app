// To parse this JSON data, do
//
//     final commonSuccessModel = commonSuccessModelFromJson(jsonString);

import 'dart:convert';

CommonSuccessModel commonSuccessModelFromJson(String str) => CommonSuccessModel.fromJson(json.decode(str));

String commonSuccessModelToJson(CommonSuccessModel data) => json.encode(data.toJson());

class CommonSuccessModel {
  final Message? message;

  CommonSuccessModel({
    this.message,
  });

  factory CommonSuccessModel.fromJson(Map<String, dynamic> json) => CommonSuccessModel(
    message: json["message"] == null ? null : Message.fromJson(json["message"]),
  );

  Map<String, dynamic> toJson() => {
    "message": message?.toJson(),
  };
}

class Message {
  final List<String>? success;

  Message({
    this.success,
  });

  factory Message.fromJson(Map<String, dynamic> json) => Message(
    success: json["success"] == null ? [] : List<String>.from(json["success"]!.map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "success": success == null ? [] : List<dynamic>.from(success!.map((x) => x)),
  };
}
