import 'package:flutter/material.dart';

import 'package:primed_health/common/route_constants.dart';

import 'package:primed_health/presentation/journeys/auth/login.dart';

import 'package:primed_health/presentation/blocs/auth/auth_bloc.dart';

import 'package:primed_health/presentation/widgets/common/cta_button.dart';

import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mocktail/mocktail.dart';

// class MockAuthBloc extends Mock implements AuthBloc {}
//
// void main() {
//   late MockAuthBloc mockAuthBloc;
//
//   setUp(() {
//     mockAuthBloc = MockAuthBloc();
//   });
//
//   group('Login Widget Tests', () {
//     late Widget loginWidget;
//
//     setUp(() {
//       loginWidget = MaterialApp(
//         home: BlocProvider<AuthBloc>(
//           create: (_) => mockAuthBloc,
//           child: Login(),
//         ),
//         onGenerateRoute: (settings) {
//           if (settings.name == RouteLiterals.createAccountRoute) {
//             return MaterialPageRoute(
//               builder: (_) => const Scaffold(body: Text('Create Account Page')),
//             );
//           }
//           return null;
//         },
//       );
//     });
//
//     testWidgets('Email validator works correctly', (WidgetTester tester) async {
//       await tester.
//       pumpWidget(loginWidget);
//
//       // Find the email input field
//       final emailField = find.byType(TextFormField).first;
//
//       // Enter invalid email
//       await tester.enterText(emailField, 'invalid-email');
//       await tester.pumpAndSettle();
//
//       // Ensure validation error is shown
//       expect(find.text('Enter a valid email'), findsOneWidget);
//
//       // Enter valid email
//       await tester.enterText(emailField, 'test@example.com');
//       await tester.pumpAndSettle();
//
//       // Ensure validation error disappears
//       expect(find.text('Enter a valid email'), findsNothing);
//     });
//
//     testWidgets('Password validator works correctly', (WidgetTester tester) async {
//       await tester.pumpWidget(loginWidget);
//
//       // Find the password input field
//       final passwordField = find.byType(TextFormField).last;
//
//       // Enter invalid password
//       await tester.enterText(passwordField, 'short');
//       await tester.pumpAndSettle();
//
//       // Ensure validation error is shown
//       expect(find.text('Password must be at least 8 characters long'), findsOneWidget);
//
//       // Enter valid password
//       await tester.enterText(passwordField, 'longpassword');
//       await tester.pumpAndSettle();
//
//       // Ensure validation error disappears
//       expect(find.text('Password must be at least 8 characters long'), findsNothing);
//     });
//
//     testWidgets('CTAButton is enabled only when inputs are valid', (WidgetTester tester) async {
//       await tester.pumpWidget(loginWidget);
//
//       // Find email and password fields
//       final emailField = find.byType(TextFormField).first;
//       final passwordField = find.byType(TextFormField).last;
//
//       // Find CTA button
//       final ctaButton = find.byType(CTAButton);
//
//       // Initially, the button is disabled
//       expect(tester.widget<CTAButton>(ctaButton).isEnabled, false);
//
//       // Enter valid email and invalid password
//       await tester.enterText(emailField, 'test@example.com');
//       await tester.enterText(passwordField, 'short');
//       await tester.pumpAndSettle();
//       expect(tester.widget<CTAButton>(ctaButton).isEnabled, false);
//
//       // Enter valid password
//       await tester.enterText(passwordField, 'longpassword');
//       await tester.pumpAndSettle();
//       expect(tester.widget<CTAButton>(ctaButton).isEnabled, true);
//     });
//
//     testWidgets('Navigation to Create Account page works', (WidgetTester tester) async {
//       await tester.pumpWidget(loginWidget);
//
//       // Find the "Create Account" link
//       final createAccountLink = find.text('Create Account');
//
//       // Tap on the link
//       await tester.tap(createAccountLink);
//       await tester.pumpAndSettle();
//
//       // Ensure navigation to the Create Account page occurred
//       expect(find.text('Create Account Page'), findsOneWidget);
//     });
//   });
// }


// import 'dart:async';
//
// import 'package:flutter/material.dart';
//
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_test/flutter_test.dart';
// import 'package:mocktail/mocktail.dart';
//
// import 'package:primed_health/presentation/blocs/auth/auth_bloc.dart';
// import 'package:primed_health/presentation/journeys/auth/login.dart';
//
// class MockAuthBloc extends Mock implements AuthBloc {
//   final _controller = StreamController<AuthState>();
//
//   @override
//   Stream<AuthState> get stream => _controller.stream;
//
//   void addState(AuthState state) => _controller.add(state);
//
//   void dispose() => _controller.close();
// }
//
// void main() {
//   late MockAuthBloc mockAuthBloc;
//
//   setUp(() {
//     mockAuthBloc = MockAuthBloc();
//   });
//
//   tearDown(() {
//     mockAuthBloc.dispose();
//   });
//
//   testWidgets('Email validator works correctly', (WidgetTester tester) async {
//     await tester.pumpWidget(
//       BlocProvider<AuthBloc>(
//         create: (_) => mockAuthBloc,
//         child: MaterialApp(home: Login()),
//       ),
//     );
//
//     // Locate the email field
//     final emailFieldFinder = find.byKey(Key('emailFieldKey'));
//
//     expect(emailFieldFinder, findsOneWidget);
//
//     // Enter valid email
//     await tester.enterText(emailFieldFinder, 'test@example.com');
//     await tester.pumpAndSettle();
//
//     // Add further assertions as needed
//   });
// }

class MockAuthBloc extends Mock implements AuthBloc {}

void main() {
  late MockAuthBloc mockAuthBloc;

  setUp(() {
    mockAuthBloc = MockAuthBloc();
    when(() => mockAuthBloc.state).thenReturn(AuthStateInitial());
  });

  testWidgets('Email validator works correctly', (WidgetTester tester) async {
    // Arrange
    await tester.pumpWidget(
      BlocProvider<AuthBloc>(
        create: (_) => mockAuthBloc,
        child: MaterialApp(
          home: Login(),
        ),
      ),
    );

    // Act
    final emailField = find.byKey(const Key('emailFieldKey'));
    await tester.enterText(emailField, 'invalid-email');
    await tester.pump();

    // Assert
    expect(emailField, findsOneWidget);
    expect(find.text('Please enter a valid email'), findsOneWidget);
  });
}
