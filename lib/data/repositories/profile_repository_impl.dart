import 'package:primed_health/data/data_sources/profile_remote_data_source.dart';

import 'package:primed_health/domain/entities/delete_my_account_params.dart';

import 'package:primed_health/domain/repositories/profile_repository.dart';

class ProfileRepositoryImpl extends ProfileRepository {

  final ProfileRemoteDataSource dataSource;
  ProfileRepositoryImpl({required this.dataSource});

  @override
  Future deleteMyAccount({required DeleteMyAccountParams params}) async {
    return await dataSource.deleteMyAccount(params: params);
  }

}