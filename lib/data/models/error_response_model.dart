class ErrorResponseModel {
  bool success;
  String message;

  ErrorResponseModel({
    required this.success,
    required this.message,
  });

  factory ErrorResponseModel.fromJson(Map<String, dynamic> json) => ErrorResponseModel(
    success: json["success"],
    message: json["message"],
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "message": message,
  };
}