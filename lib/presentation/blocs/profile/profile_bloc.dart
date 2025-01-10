import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:primed_health/common/db_constants.dart';

import 'package:primed_health/data/models/error_response_model.dart';

import 'package:primed_health/domain/entities/delete_my_account_params.dart';

import 'package:primed_health/domain/repositories/profile_repository.dart';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:hive/hive.dart';
import 'package:http/http.dart';

part 'profile_event.dart';
part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {

  final ProfileRepository _repository;

  ProfileBloc({required ProfileRepository repository})
      : _repository = repository,
        super(ProfileStateInitial()) {
    // on<GetUserProfileEvent>(_getUserProfile);
    on<DeleteMyAccountEvent>(_deleteMyAccount);
  }

  _deleteMyAccount(DeleteMyAccountEvent event, Emitter<ProfileState> emit) async {

    Response response = await _repository.deleteMyAccount(params: event.params);

    if(response.statusCode == 200){
      emit(ProfileStateDeleteMyAccountSuccess());
    } else {

      final failure = ErrorResponseModel.fromJson(jsonDecode(response.body));
      log('failure in bloc:\n${failure.message}');
      emit(ProfileStateFailure(errorMessage: failure.message));

    }

  }

}