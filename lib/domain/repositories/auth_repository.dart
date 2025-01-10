import 'package:primed_health/domain/entities/register_params.dart';
import 'package:primed_health/domain/entities/verify_email_params.dart';
import 'package:primed_health/domain/entities/login_params.dart';

abstract class AuthRepository {
  Future<dynamic> registerUser({required RegisterParams params});
  Future<dynamic> verifyEmail({required VerifyEmailParams params});
  Future<dynamic> loginUser({required LoginParams params});
}