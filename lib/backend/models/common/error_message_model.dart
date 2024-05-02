class ErrorResponse {
  final Message? message;

  ErrorResponse({
    this.message,
  });

  factory ErrorResponse.fromJson(Map<String, dynamic> json) => ErrorResponse(
    message: json["message"] == null ? null : Message.fromJson(json["message"]),
  );

  Map<String, dynamic> toJson() => {
    "message": message?.toJson(),
  };
}

class Message {
  final List<String>? error;

  Message({
    this.error,
  });

  factory Message.fromJson(Map<String, dynamic> json) => Message(
    error: json["error"] == null ? [] : List<String>.from(json["error"]!.map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "error": error == null ? [] : List<dynamic>.from(error!.map((x) => x)),
  };
}
