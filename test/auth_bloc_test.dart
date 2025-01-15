// import 'dart:convert';
// import 'dart:io';
//
// import 'package:primed_health/data/models/error_response_model.dart';
// import 'package:primed_health/data/models/login_response_model.dart';
// import 'package:primed_health/data/models/register_response_model.dart';
// import 'package:primed_health/data/models/user.dart';
// import 'package:primed_health/data/models/verify_email_response_model.dart';
//
// import 'package:primed_health/domain/entities/login_params.dart';
// import 'package:primed_health/domain/entities/register_params.dart';
// import 'package:primed_health/domain/entities/verify_email_params.dart';
//
// import 'package:primed_health/domain/repositories/auth_repository.dart';
//
// import 'package:primed_health/presentation/blocs/auth/auth_bloc.dart';
//
// import 'package:bloc_test/bloc_test.dart';
// import 'package:flutter_test/flutter_test.dart';
// import 'package:mocktail/mocktail.dart';
// import 'package:http/http.dart' as http;
// import 'package:hive/hive.dart';
// import 'package:path_provider/path_provider.dart';
//
// class MockAuthRepository extends Mock implements AuthRepository {}
//
// class MockHttpResponse extends Mock implements http.Response {}
//
// main() {
//
//   late AuthBloc authBloc;
//   late MockAuthRepository mockRepository;
//
//   const String token = 'Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjY3ODQ2MjA5M2U4Yzk5YTRjOThiZDVjNCIsImlhdCI6MTczNjcyOTk5NiwiZXhwIjoxNzM5MzIxOTk2fQ.VfdPGFVx9KiHQSNpjb3oH7UT_Dk28-Ly3kYaogUtisA';
//
//   setUpAll(() async {
//     mockRepository = MockAuthRepository();
//     authBloc = AuthBloc(repository: mockRepository);
//
//     final appDocumentDir = await getApplicationDocumentsDirectory();
//     Hive.init(appDocumentDir.path); // Initialize Hive with a test directory
//
//     await Hive.openBox('PrimeBox');
//
//   });
//
//   tearDownAll(() {
//     authBloc.close();
//   });
//
//   group('Auth Bloc Tests', (){
//
//     const registerParams = RegisterParams(
//       firstName: 'Joseph',
//       lastName: 'Ibeawuchi',
//       email: 'joseph.ibeawuchi@gmail.com',
//       password: 'Prime@2025',
//     );
//
//     const loginParams = LoginParams(
//       email: 'john.doe@example.com',
//       password: 'Prime@2025',
//     );
//
//     const verifyEmailParams = VerifyEmailParams(
//       userId: '678462093e8c99a4c98bd5c4',
//       email: 'joseph.ibeawuchi@gmail.com',
//       otp: '123456',
//     );
//
//     test('Initial state is AuthStateInitial', () {
//       expect(authBloc.state, AuthStateInitial());
//     });
//
//     blocTest<AuthBloc, AuthState>(
//       'emits [AuthStateLoading, AuthStateRegisterSuccess] when RegisterUserEvent is successful',
//       setUp: () {
//         final registerResponseModel = RegisterResponseModel(
//           message: "Registration Successful",
//           success: true,
//           user: User(
//             id: '678462093e8c99a4c98bd5c4',
//             firstName: 'Joseph',
//             lastName: 'Ibeawuchi',
//             email: 'joseph.ibeawuchi@gmail.com',
//             verifiedEmail: false,
//           ),
//           token: 'dummyToken',
//         );
//
//         when(() => mockRepository.registerUser(params: any(named: 'params')))
//             .thenAnswer((_) async => http.Response(
//           jsonEncode(registerResponseModel.toJson()),
//           201,
//         ));
//       },
//       build: () => authBloc,
//       act: (bloc) => bloc.add(const RegisterUserEvent(registerParams: registerParams)),
//       expect: () => [
//         AuthStateLoading(),
//         isA<AuthStateRegisterSuccess>(),
//       ],
//     );
//
//     blocTest<AuthBloc, AuthState>(
//       'emits [AuthStateLoading, AuthStateFailure] when RegisterUserEvent fails',
//       setUp: () {
//         final errorResponse = ErrorResponseModel(
//           message: 'Registration failed',
//           success: false
//         );
//
//         when(() => mockRepository.registerUser(params: any(named: 'params')))
//             .thenAnswer((_) async => http.Response(
//           jsonEncode(errorResponse.toJson()),
//           400,
//         ));
//       },
//       build: () => authBloc,
//       act: (bloc) => bloc.add(const RegisterUserEvent(registerParams: registerParams)),
//       expect: () => [
//         AuthStateLoading(),
//         const AuthStateFailure(failureMessage: 'Registration failed'),
//       ],
//     );
//
//     blocTest<AuthBloc, AuthState>(
//       'emits [AuthStateLoading, AuthStateLoginSuccess, AuthStateAuthenticated] when LoginEvent is successful',
//       setUp: () {
//         final loginResponseModel = LoginResponseModel(
//           success: true,
//           message: "Login Successful",
//           user: User(
//             id: '678462093e8c99a4c98bd5c4',
//             firstName: 'Joseph',
//             lastName: 'Ibeawuchi',
//             email: 'joseph.ibeawuchi@gmail.com',
//             verifiedEmail: true,
//           ),
//           token: token,
//         );
//
//         when(() => mockRepository.loginUser(params: any(named: 'params')))
//             .thenAnswer((_) async => http.Response(
//           jsonEncode(loginResponseModel.toJson()),
//           200,
//         ));
//       },
//       build: () => authBloc,
//       act: (bloc) => bloc.add(const LoginEvent(loginParams: loginParams)),
//       expect: () => [
//         AuthStateLoading(),
//         isA<AuthStateLoginSuccess>(),
//         AuthStateAuthenticated(),
//       ],
//     );
//
//     blocTest<AuthBloc, AuthState>(
//       'emits [AuthStateLoading, AuthStateFailure] when LoginEvent fails',
//       setUp: () {
//         final errorResponse = ErrorResponseModel(
//           success: false,
//           message: 'Login failed',
//         );
//
//         when(() => mockRepository.loginUser(params: any(named: 'params')))
//             .thenAnswer((_) async => http.Response(
//           jsonEncode(errorResponse.toJson()),
//           401,
//         ));
//       },
//       build: () => authBloc,
//       act: (bloc) => bloc.add(const LoginEvent(loginParams: loginParams)),
//       expect: () => [
//         AuthStateLoading(),
//         const AuthStateFailure(failureMessage: 'Login failed'),
//       ],
//     );
//
//     blocTest<AuthBloc, AuthState>(
//       'emits [AuthStateLoading, AuthStateVerifyEmailSuccess, AuthStateAuthenticated] when VerifyEmailEvent is successful',
//       setUp: () {
//         final verifyEmailResponseModel = VerifyEmailResponseModel(
//           message: "Email Verified Successfully",
//           success: true,
//         );
//
//         when(() => mockRepository.verifyEmail(params: any(named: 'params')))
//             .thenAnswer((_) async => http.Response(
//           jsonEncode(verifyEmailResponseModel.toJson()),
//           200,
//         ));
//       },
//       build: () => authBloc,
//       act: (bloc) => bloc.add(const VerifyEmailEvent(verifyEmailParams: verifyEmailParams)),
//       expect: () => [
//         AuthStateLoading(),
//         isA<AuthStateVerifyEmailSuccess>(),
//         AuthStateAuthenticated(),
//       ],
//     );
//
//     blocTest<AuthBloc, AuthState>(
//       'emits [AuthStateLoading, AuthStateFailure] when VerifyEmailEvent fails',
//       setUp: () {
//         final errorResponse = ErrorResponseModel(
//           success: false,
//           message: 'Email Verification Failed',
//         );
//
//         when(() => mockRepository.verifyEmail(params: any(named: 'params')))
//             .thenAnswer((_) async => http.Response(
//           jsonEncode(errorResponse.toJson()),
//           400,
//         ));
//       },
//       build: () => authBloc,
//       act: (bloc) => bloc.add(const VerifyEmailEvent(verifyEmailParams: verifyEmailParams)),
//       expect: () => [
//         AuthStateLoading(),
//         const AuthStateFailure(failureMessage: 'Verification failed'),
//       ],
//     );
//
//   });
//
// }

//todo 2.0

// import 'dart:convert';
// import 'package:primed_health/data/models/error_response_model.dart';
// import 'package:primed_health/data/models/login_response_model.dart';
// import 'package:primed_health/data/models/register_response_model.dart';
// import 'package:primed_health/data/models/user.dart';
// import 'package:primed_health/data/models/verify_email_response_model.dart';
//
// import 'package:primed_health/domain/entities/login_params.dart';
// import 'package:primed_health/domain/entities/register_params.dart';
// import 'package:primed_health/domain/entities/verify_email_params.dart';
//
// import 'package:primed_health/domain/repositories/auth_repository.dart';
//
// import 'package:primed_health/presentation/blocs/auth/auth_bloc.dart';
//
// import 'package:bloc_test/bloc_test.dart';
// import 'package:flutter_test/flutter_test.dart';
// import 'package:mocktail/mocktail.dart';
// import 'package:hive/hive.dart';
// import 'package:hive_test/hive_test.dart'; // Use hive_test for in-memory testing
//
// class MockAuthRepository extends Mock implements AuthRepository {}
//
// main() {
//   late AuthBloc authBloc;
//   late MockAuthRepository mockRepository;
//
//   const String token = 'Bearer dummyToken';
//
//   setUpAll(() async {
//     mockRepository = MockAuthRepository();
//     authBloc = AuthBloc(repository: mockRepository);
//
//     await setUpTestHive(); // Initialize Hive in memory for testing
//     await Hive.openBox('PrimeBox'); // Open a Hive box for tests
//   });
//
//   tearDownAll(() async {
//     await tearDownTestHive(); // Clean up Hive after tests
//     authBloc.close();
//   });
//
//   group('Auth Bloc Tests', () {
//     const registerParams = RegisterParams(
//       firstName: 'Joseph',
//       lastName: 'Ibeawuchi',
//       email: 'joseph.ibeawuchi@gmail.com',
//       password: 'Prime@2025',
//     );
//
//     const loginParams = LoginParams(
//       email: 'john.doe@example.com',
//       password: 'Prime@2025',
//     );
//
//     const verifyEmailParams = VerifyEmailParams(
//       userId: '678462093e8c99a4c98bd5c4',
//       email: 'joseph.ibeawuchi@gmail.com',
//       otp: '123456',
//     );
//
//     test('Initial state is AuthStateInitial', () {
//       expect(authBloc.state, AuthStateInitial());
//     });
//
//     blocTest<AuthBloc, AuthState>(
//       'emits [AuthStateLoading, AuthStateRegisterSuccess] when RegisterUserEvent is successful',
//       setUp: () {
//         final registerResponseModel = RegisterResponseModel(
//           message: "Registration Successful",
//           success: true,
//           user: User(
//             id: '678462093e8c99a4c98bd5c4',
//             firstName: 'Joseph',
//             lastName: 'Ibeawuchi',
//             email: 'joseph.ibeawuchi@gmail.com',
//             verifiedEmail: false,
//           ),
//           token: 'dummyToken',
//         );
//
//         when(() => mockRepository.registerUser(params: any(named: 'params')))
//             .thenAnswer((_) async => registerResponseModel);
//       },
//       build: () => authBloc,
//       act: (bloc) => bloc.add(const RegisterUserEvent(registerParams: registerParams)),
//       expect: () => [
//         AuthStateLoading(),
//         isA<AuthStateRegisterSuccess>(),
//       ],
//     );
//
//     blocTest<AuthBloc, AuthState>(
//       'emits [AuthStateLoading, AuthStateFailure] when RegisterUserEvent fails',
//       setUp: () {
//         final errorResponse = ErrorResponseModel(
//           message: 'Registration failed',
//           success: false,
//         );
//
//         when(() => mockRepository.registerUser(params: any(named: 'params')))
//             .thenThrow(errorResponse);
//       },
//       build: () => authBloc,
//       act: (bloc) => bloc.add(const RegisterUserEvent(registerParams: registerParams)),
//       expect: () => [
//         AuthStateLoading(),
//         const AuthStateFailure(failureMessage: 'Registration failed'),
//       ],
//     );
//
//     // Repeat similar tests for LoginEvent and VerifyEmailEvent...
//   });
// }


import 'dart:convert';
import 'dart:io';

import 'package:primed_health/data/models/error_response_model.dart';
import 'package:primed_health/data/models/login_response_model.dart';
import 'package:primed_health/data/models/register_response_model.dart';
import 'package:primed_health/data/models/user.dart';
import 'package:primed_health/data/models/verify_email_response_model.dart';

import 'package:primed_health/domain/entities/login_params.dart';
import 'package:primed_health/domain/entities/register_params.dart';
import 'package:primed_health/domain/entities/verify_email_params.dart';

import 'package:primed_health/domain/repositories/auth_repository.dart';

import 'package:primed_health/presentation/blocs/auth/auth_bloc.dart';

import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:http/http.dart' as http;
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';

class MockAuthRepository extends Mock implements AuthRepository {}

class MockHttpResponse extends Mock implements http.Response {}

void main() {
  late AuthBloc authBloc;
  late MockAuthRepository mockRepository;
  late Box mockHiveBox;

  const String token =
      'Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjY3ODQ2MjA5M2U4Yzk5YTRjOThiZDVjNCIsImlhdCI6MTczNjcyOTk5NiwiZXhwIjoxNzM5MzIxOTk2fQ.VfdPGFVx9KiHQSNpjb3oH7UT_Dk28-Ly3kYaogUtisA';

  setUpAll(() async {
    mockRepository = MockAuthRepository();
    final appDocumentDir = await getApplicationDocumentsDirectory();
    Hive.init(appDocumentDir.path); // Initialize Hive with a test directory

    // Open a mock box
    mockHiveBox = await Hive.openBox('PrimeBox');

    authBloc = AuthBloc(repository: mockRepository);
  });

  tearDownAll(() async {
    await mockHiveBox.close(); // Close Hive box after all tests
    await Hive.deleteBoxFromDisk('PrimeBox'); // Clean up mock data
    authBloc.close(); // Close the bloc
  });

  group('Auth Bloc Tests', () {
    const registerParams = RegisterParams(
      firstName: 'Joseph',
      lastName: 'Ibeawuchi',
      email: 'joseph.ibeawuchi@gmail.com',
      password: 'Prime@2025',
    );

    const loginParams = LoginParams(
      email: 'john.doe@example.com',
      password: 'Prime@2025',
    );

    const verifyEmailParams = VerifyEmailParams(
      userId: '678462093e8c99a4c98bd5c4',
      email: 'joseph.ibeawuchi@gmail.com',
      otp: '123456',
    );

    test('Initial state is AuthStateInitial', () {
      expect(authBloc.state, AuthStateInitial());
    });

    blocTest<AuthBloc, AuthState>(
      'emits [AuthStateLoading, AuthStateRegisterSuccess] when RegisterUserEvent is successful',
      setUp: () {
        final registerResponseModel = RegisterResponseModel(
          message: "Registration Successful",
          success: true,
          user: User(
            id: '678462093e8c99a4c98bd5c4',
            firstName: 'Joseph',
            lastName: 'Ibeawuchi',
            email: 'joseph.ibeawuchi@gmail.com',
            verifiedEmail: false,
          ),
          token: 'dummyToken',
        );

        when(() => mockRepository.registerUser(params: any(named: 'params')))
            .thenAnswer((_) async => http.Response(
          jsonEncode(registerResponseModel.toJson()),
          201,
        ));
      },
      build: () => authBloc,
      act: (bloc) =>
          bloc.add(const RegisterUserEvent(registerParams: registerParams)),
      expect: () => [
        AuthStateLoading(),
        isA<AuthStateRegisterSuccess>(),
      ],
    );

    // Additional tests...
  });
}
