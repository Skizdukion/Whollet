import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:whollet/logic/bloc/auth/login/login_bloc.dart';
import 'package:whollet/logic/bloc/auth/login/login_state.dart';
import 'package:whollet/routing/routes.dart';
import 'package:whollet/views/routes/authenticate/login/login_body.dart';
import 'package:whollet/views/utils/extension/snack_bar.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({ Key? key }) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: BlocProvider<LoginBloc>(
        create: (_) => LoginBloc(),
        child: BlocConsumer<LoginBloc, LoginState>(
          listener: (context, state){
            if (state is LoginFailed){
              ScaffoldMessenger.of(context).showSnackBar(ExpandedSnackBar.failureSnackBar(context, state.errorString));
            }
            if (state is LoginSuccess){
              Navigator.pushNamed(context, Routes.homeRoute);
            }
          },
          builder: (context, state){            
            return Scaffold(
              resizeToAvoidBottomInset: false,
              body: (state is LoginLoading) ? Center(child: CircularProgressIndicator(),) : LoginBody(),
            );
          },
        ),
      ),
    );
  }

}