import 'package:primed_health/data/core/api_client.dart';
import 'package:primed_health/data/core/api_constants.dart';

import 'package:primed_health/domain/entities/register_params.dart';
import 'package:primed_health/domain/entities/verify_email_params.dart';
import 'package:primed_health/domain/entities/login_params.dart';

abstract class AuthRemoteDataSource {
  Future<dynamic> loginUser({required LoginParams params});
  Future<dynamic> registerUser({required RegisterParams params});
  Future<dynamic> verifyEmail({required VerifyEmailParams params});
}

class AuthRemoteDataSourceImpl extends AuthRemoteDataSource {

  final APIClient client;
  AuthRemoteDataSourceImpl({required this.client});

  @override
  Future<void> registerUser({required RegisterParams params}) async {
    return await client.register(pathSegment: APIConstants.register, params: params);
  }

  @override
  Future<void> loginUser({required LoginParams params}) async {
    return await client.login(pathSegment: APIConstants.login, params: params);
  }

  @override
  Future<void> verifyEmail({required VerifyEmailParams params}) async {
    return await client.verifyEmail(pathSegment: APIConstants.verifyEmail, params: params);
  }

}