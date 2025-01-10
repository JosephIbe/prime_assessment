class VerifyEmailResponseModel {
  bool success;
  String message;

  VerifyEmailResponseModel({
    required this.success,
    required this.message,
  });

  factory VerifyEmailResponseModel.fromJson(Map<String, dynamic> json) => VerifyEmailResponseModel(
    success: json["success"],
    message: json["message"],
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "message": message,
  };
}