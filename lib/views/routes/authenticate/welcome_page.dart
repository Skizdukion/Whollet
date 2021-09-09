import 'package:flutter/material.dart';
import 'package:whollet/global/constant/color.dart';
import 'package:whollet/routing/routes.dart';
import 'package:whollet/widget/auth_nav.dart';
import 'package:whollet/widget/custom_button.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        width: size.width,
        color: AppColors.darkBlueColor,
        child: Column(
          children: [
            SizedBox(height: 120),
            Image.asset('assets/images/logo.png'),
            SizedBox(height: 30),
            Text(
              "Welcome to",
              style: TextStyle(
                fontSize: 28,
                color: Colors.white.withOpacity(.5),
              ),
            ),
            Text(
              "WHOLLET",
              style: TextStyle(
                fontSize: 48,
                color: Colors.white,
              ),
            ),
            Spacer(),
            CustomButton(
              onPress: () {
                Navigator.pushNamed(context, Routes.loginRoute);
              },
              text: "Sign In",
            ),
            SizedBox(height: 16),
            AuthNavigation(
              text: 'Don’t have an account?',
              buttonText: 'Sign Up',
              textColor: Colors.white,
              buttonTextColor: Colors.white,
              onPress: (){
                Navigator.pushNamed(context, Routes.signUpRoute);
              },
            ),
            SizedBox(height: 40,)
          ],
        ),
      ),
    );
  }
}