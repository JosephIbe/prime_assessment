import 'package:primed_health/data/models/user.dart';

class LoginResponseModel {
  bool success;
  String message;
  User user;
  String token;

  LoginResponseModel({
    required this.success,
    required this.message,
    required this.user,
    required this.token,
  });

  factory LoginResponseModel.fromJson(Map<String, dynamic> json) => LoginResponseModel(
    success: json["success"],
    message: json["message"],
    user: User.fromJson(json["user"]),
    token: json["token"],
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "message": message,
    "user": user.toJson(),
    "token": token,
  };
}