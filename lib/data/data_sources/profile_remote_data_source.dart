import 'package:primed_health/common/db_constants.dart';

import 'package:primed_health/data/core/api_client.dart';
import 'package:primed_health/data/core/api_constants.dart';

import 'package:primed_health/domain/entities/delete_my_account_params.dart';

abstract class ProfileRemoteDataSource {
  Future<dynamic> deleteMyAccount({required DeleteMyAccountParams params});
}

class ProfileRemoteDataSourceImpl extends ProfileRemoteDataSource {

  final APIClient client;
  ProfileRemoteDataSourceImpl({required this.client});

  @override
  Future deleteMyAccount({required DeleteMyAccountParams params}) async {
    return await client.deleteMyAccount(pathSegment: APIConstants.deleteMyAccount, params: params);
  }

}