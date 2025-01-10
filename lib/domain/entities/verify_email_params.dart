import 'package:equatable/equatable.dart';

class VerifyEmailParams extends Equatable {

  final String userId;
  final String email;
  final String otp;
  const VerifyEmailParams({required this.userId ,required this.email, required this.otp});

  Map<String, dynamic> toJson()=>{
    "userId": userId,
    "email": email,
    "otp": otp
  };

  @override
  List<Object?> get props => [otp];

}