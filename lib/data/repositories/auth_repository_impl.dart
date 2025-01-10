import 'package:primed_health/data/data_sources/auth_remote_data_source.dart';

import 'package:primed_health/domain/entities/verify_email_params.dart';
import 'package:primed_health/domain/entities/login_params.dart';
import 'package:primed_health/domain/entities/register_params.dart';

import 'package:primed_health/domain/repositories/auth_repository.dart';

class AuthRepositoryImpl extends AuthRepository {

  final AuthRemoteDataSource dataSource;
  AuthRepositoryImpl({required this.dataSource});

  @override
  Future<dynamic> loginUser({required LoginParams params}) async {
    return await dataSource.loginUser(params: params);
  }

  @override
  Future<dynamic> registerUser({required RegisterParams params}) async {
    return await dataSource.registerUser(params: params);
  }

  @override
  Future<dynamic> verifyEmail({required VerifyEmailParams params}) async {
    return await dataSource.verifyEmail(params: params);
  }

}