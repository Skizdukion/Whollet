import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icon_network/flutter_icon_network.dart';
import 'package:whollet/global/theme/app_theme.dart';
import 'package:whollet/routing/app_routes.dart';
import 'package:whollet/routing/routes.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());  
  await FlutterIconNetwork.instance!.init(host: "https://bicon.net.solidwallet.io/api/v3", isTestNet: true);
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: AppTheme.getOnboardingTheme(),
      initialRoute: Routes.onBoardingRoute,
      onGenerateRoute: AppRoutes.onGenerateAppRoute,
    );
  }
}

