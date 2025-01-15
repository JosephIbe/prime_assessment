import 'dart:convert';
import 'dart:developer';

import 'package:primed_health/common/db_constants.dart';

import 'package:primed_health/data/models/error_response_model.dart';
import 'package:primed_health/data/models/verify_email_response_model.dart';
import 'package:primed_health/data/models/login_response_model.dart';
import 'package:primed_health/data/models/register_response_model.dart';

import 'package:primed_health/domain/entities/register_params.dart';
import 'package:primed_health/domain/entities/verify_email_params.dart';
import 'package:primed_health/domain/entities/login_params.dart';

import 'package:primed_health/domain/repositories/auth_repository.dart';

import 'package:hive/hive.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {

  final AuthRepository _repository;
  final box = Hive.box(DBConstants.appBoxName);

  AuthBloc({required AuthRepository repository})
      : _repository = repository,
        super(AuthStateInitial()) {
    on<RegisterUserEvent>(_registerUser);
    on<LoginEvent>(_loginUser);
    on<VerifyEmailEvent>(_verifyEmail);
    on<CheckAuthStatusEvent>(_checkAuthStatus);
    on<BackStackEvent>(_backStack);
  }

  _registerUser(RegisterUserEvent event, Emitter<AuthState> emit) async {
    emit(AuthStateLoading());

    log('register params in bloc :\n${event.registerParams}');

    http.Response response = await _repository.registerUser(params: event.registerParams);

    if(response.statusCode == 201){
      log('register response in bloc:\n$response');

      final responseModel = RegisterResponseModel.fromJson(jsonDecode(response.body));

      box.put(DBConstants.userId, responseModel.user.id);
      box.put(DBConstants.firstName, responseModel.user.firstName);
      box.put(DBConstants.lastName, responseModel.user.lastName);
      box.put(DBConstants.email, responseModel.user.email);
      box.put(DBConstants.jwtToken, responseModel.token);

      box.put(DBConstants.isEmailVerified, "false");

      emit(AuthStateRegisterSuccess(responseModel: responseModel));

    } else {
      log('register response status code:\t${response.statusCode}');

      final failure = ErrorResponseModel.fromJson(jsonDecode(response.body));
      log('failure in bloc:\n${failure.message}');
      emit(AuthStateFailure(failureMessage: failure.message));
    }

  }

  _verifyEmail(VerifyEmailEvent event, Emitter<AuthState> emit) async {
    emit(AuthStateLoading());

    http.Response response = await _repository.verifyEmail(params: event.verifyEmailParams);

    if(response.statusCode == 200){
      final responseModel = VerifyEmailResponseModel.fromJson(jsonDecode(response.body));
      emit(AuthStateVerifyEmailSuccess(responseModel: responseModel));

      box.put(DBConstants.isEmailVerified, "true");

    } else {
      final failure = ErrorResponseModel.fromJson(jsonDecode(response.body));
      emit(AuthStateFailure(failureMessage: failure.message));
    }

  }

  _loginUser(LoginEvent event, Emitter<AuthState> emit) async {
    emit(AuthStateLoading());

    http.Response response = await _repository.loginUser(params: event.loginParams);

    if(response.statusCode == 200){
      final loginResponseModel = LoginResponseModel.fromJson(jsonDecode(response.body));

      box.put(DBConstants.userId, loginResponseModel.user.id);
      box.put(DBConstants.firstName, loginResponseModel.user.firstName);
      box.put(DBConstants.lastName, loginResponseModel.user.lastName);
      box.put(DBConstants.email, loginResponseModel.user.email);
      box.put(DBConstants.jwtToken, loginResponseModel.token);

      box.put(DBConstants.isEmailVerified, "true");

      log('fn from response:\t${loginResponseModel.user.firstName}');

      emit(AuthStateLoginSuccess(responseModel: loginResponseModel));

    } else {

      final failure = ErrorResponseModel.fromJson(jsonDecode(response.body));
      log('failure in bloc:\n${failure.message}');
      emit(AuthStateFailure(failureMessage: failure.message));
    }

  }

  _checkAuthStatus(CheckAuthStatusEvent event, Emitter<AuthState> emit) async {
    final box = Hive.box(DBConstants.appBoxName);

    final token = box.get(DBConstants.jwtToken);
    final emailVerified = box.get(DBConstants.isEmailVerified);


    if (token != null && emailVerified == true) {
      emit(AuthStateAuthenticated());
    } else {
      emit(AuthStateInitial());
    }
  }

  _backStack(BackStackEvent event, Emitter<AuthState> emit) {
    if(state is AuthStateLoading) {
      emit(AuthStateInitial());
    }
    emit(AuthStateInitial());
  }

}