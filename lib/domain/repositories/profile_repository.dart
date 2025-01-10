import 'package:primed_health/domain/entities/delete_my_account_params.dart';

abstract class ProfileRepository {
  Future<dynamic> deleteMyAccount({required DeleteMyAccountParams params});
}