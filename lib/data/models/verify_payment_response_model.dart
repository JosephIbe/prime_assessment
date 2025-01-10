class VerifyPaymentResponseModel {
  bool success;
  String message;

  VerifyPaymentResponseModel({
    required this.success,
    required this.message,
  });

  factory VerifyPaymentResponseModel.fromJson(Map<String, dynamic> json) => VerifyPaymentResponseModel(
    success: json["success"],
    message: json["message"],
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "message": message,
  };
}