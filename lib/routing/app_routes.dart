import 'package:flutter/material.dart';
import 'package:whollet/logic/utils/exceptions/routes_exception.dart';
import 'package:whollet/views/routes/authenticate/login/login_page.dart';
import 'package:whollet/views/routes/authenticate/pin_page.dart';
import 'package:whollet/views/routes/authenticate/sign_up/sign_up_page.dart';
import 'package:whollet/views/routes/authenticate/welcome_page.dart';
import 'package:whollet/views/routes/home/home.dart';
import 'package:whollet/views/routes/on_boarding/on_boarding_page.dart';

import 'routes.dart';

class AppRoutes {
  AppRoutes._();

  static Route<dynamic> onGenerateAppRoute(RouteSettings settings) {
    switch (settings.name) {
      case Routes.onBoardingRoute:
        return MaterialPageRoute(builder: (_) => OnBoardingPage());
      case Routes.welcomeRoute:
        return MaterialPageRoute(builder: (_) => WelcomePage());
      case Routes.loginRoute:
        return MaterialPageRoute(builder: (_) => LoginPage());
      case Routes.signUpRoute:
        return MaterialPageRoute(builder: (_) => SignUpPage());
      case Routes.createPinRoute:
        return MaterialPageRoute(builder: (_) => PinPage(isCreatePin: true,));
      case Routes.verifyPinRoute:
        return MaterialPageRoute(builder: (_) => PinPage(isCreatePin: false,));
      case Routes.homeRoute:
        return MaterialPageRoute(builder: (_) => HomePage());
      default:
        throw RouteException('Route not found');
    }
      
  }
}