import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

import 'package:primed_health/common/route_constants.dart';

import 'package:primed_health/data/models/product.dart';

import 'package:primed_health/presentation/journeys/auth/verify_email.dart';
import 'package:primed_health/presentation/journeys/auth/create_account.dart';
import 'package:primed_health/presentation/journeys/auth/login.dart';
import 'package:primed_health/presentation/journeys/dashboard/app_notifications.dart';

import 'package:primed_health/presentation/journeys/dashboard/home.dart';
import 'package:primed_health/presentation/journeys/dashboard/product_details.dart';


class AppRouter {

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case RouteLiterals.createAccountRoute:
        return CupertinoPageRoute(builder: (_) => const CreateAccount());
      case RouteLiterals.loginRoute:
        return CupertinoPageRoute(builder: (_) => const Login());
      case RouteLiterals.verifyEmailRoute:
        final email = settings.arguments;
        return CupertinoPageRoute(builder: (_) => VerifyEmail(email: email,));
      case RouteLiterals.homeRoute:
        return CupertinoPageRoute(builder: (_) => const Home());
      case RouteLiterals.notificationsRoute:
        dynamic offers = settings.arguments;
        return CupertinoPageRoute(builder: (_) => const AppNotifications());
      case RouteLiterals.productDetailsRoute:
        final product = settings.arguments;
        return CupertinoPageRoute(builder: (_) => ProductDetails(product: product as Product));
      // case RouteLiterals.aboutUsRoute:
      //   return CupertinoPageRoute(builder: (_) => const AboutUs());
      // case RouteLiterals.contactUsRoute:
      //   return CupertinoPageRoute(builder: (_) => const ContactUs());

      default:
        return CupertinoPageRoute(
            builder: (_) => Scaffold(
                  body: Center(
                    child: Text('No route specified for ${settings.name}'),
                  ),
                ));
    }
  }

}