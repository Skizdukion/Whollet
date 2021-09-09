import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:whollet/global/constant/color.dart';
import 'package:whollet/global/constant/decoration/text_decoration.dart';
import 'package:whollet/global/constant/error.dart';
import 'package:whollet/logic/bloc/auth/login/login_bloc.dart';
import 'package:whollet/logic/bloc/auth/login/login_event.dart';
import 'package:whollet/routing/routes.dart';
import 'package:whollet/widget/auth_nav.dart';
import 'package:whollet/widget/custom_button.dart';
import 'package:whollet/logic/utils/extensions/string_extension.dart';

class LoginBody extends StatefulWidget {
  const LoginBody({ Key? key }) : super(key: key);

  @override
  _LoginBodyState createState() => _LoginBodyState();
}

class _LoginBodyState extends State<LoginBody> {

  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  ValueNotifier<bool> _obscureText = ValueNotifier(true);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return  Scaffold(
      resizeToAvoidBottomInset: false,
      body: Column(
        children: [
          Expanded(
            child: Column(
              children: [
                SizedBox(height: 20,),
                Text('Welcome Back!', style: AppTextDecoration.dark26W600,),
                Spacer(),
                Container(
                  width: size.width,
                  height: 250,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage(
                        'assets/images/login.png',
                      ),
                    ),
                  ),
                ),
              ] 
            ),
            flex: 40,
          ),
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(20),
                  topLeft: Radius.circular(20),
                ),
              ),
              width: size.width,
              child: Padding(
                padding: const EdgeInsets.only(top: 30, left: 25, right: 25),
                child: Column(
                  children: [
                    TextFormField(
                      controller: _emailController,
                      decoration: InputDecoration(
                        hintText: 'Email address',
                        labelText: 'Email address',
                      ),
                    ),
                    SizedBox(height: 10,),
                    ValueListenableBuilder(
                      valueListenable: _obscureText,
                      builder: (context, bool, child){
                        return TextFormField(
                          controller: _passwordController,
                          obscureText: _obscureText.value,
                          obscuringCharacter: '●',
                          decoration: InputDecoration(
                            hintText: 'Password',
                            labelText: 'Password',
                            suffix: InkWell(
                              onTap: (){
                                _obscureText.value = !_obscureText.value;
                              },
                              child: Icon(
                                _obscureText.value ? Icons.visibility_outlined : Icons.visibility_off_outlined,
                                color: AppColors.textLightColor,
                              ),
                            ),
                          ),                        
                        );
                      }
                    ),
                    SizedBox(height: 7,),
                    Row(
                      children: [
                        Spacer(),
                        InkWell(
                          onTap: (){},
                          child: Text('Forgot your password?', style: AppTextDecoration.darkBlue15W600,),
                        ),
                      ],
                    ),
                    Spacer(),
                    CustomButton(onPress: () async{
                      login();
                    }, text: 'Login', outline: false,),                      
                    AuthNavigation(
                      text: "Don't have an account",
                      buttonText: "Sign Up", 
                      textColor: AppColors.ligtGreyColor, 
                      buttonTextColor: AppColors.darkBlueColor, 
                      onPress: (){
                        Navigator.pushNamed(context, Routes.signUpRoute);
                      }
                    ),
                    SizedBox(height: 40,),
                  ],
                ),
              ),
            ),
            flex: 60,
          ),
        ],
      ),
    );
  }

  
  void login() async{
    LoginBloc loginBloc = BlocProvider.of<LoginBloc>(context);
    if (_emailController.text.isEmpty){
      loginBloc.add(Failed(errorString: ErrorString.emptyEmailAddress));
      return;
    }
    if (_passwordController.text.isEmpty){
      loginBloc.add(Failed(errorString: ErrorString.emptyPassword));
      return;
    }
    if (!_emailController.text.isValidEmail()){
      loginBloc.add(Failed(errorString: ErrorString.unvalidEmailAddress));
      return;
    }
    if (_passwordController.text.length < 6){
      loginBloc.add(Failed(errorString: ErrorString.notEnoughPasswordLength));
      return;
    }
    loginBloc.add(VerifyLogin(email: _emailController.text, password: _passwordController.text));
  }
}