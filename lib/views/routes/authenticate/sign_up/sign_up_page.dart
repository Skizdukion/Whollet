import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:whollet/global/constant/error.dart';
import 'package:whollet/logic/bloc/auth/register/register_bloc.dart';
import 'package:whollet/logic/bloc/auth/register/register_state.dart';
import 'package:whollet/routing/routes.dart';
import 'package:whollet/views/routes/authenticate/sign_up/sign_up_body.dart';
import 'package:whollet/views/utils/extension/snack_bar.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({ Key? key }) : super(key: key);  

  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: BlocProvider<RegisterBloc>(
        create: (_) => RegisterBloc(),
        child: BlocConsumer<RegisterBloc, RegisterState>(
          listener: (context, state){
            if (state is RegisterFailed){
              ScaffoldMessenger.of(context).showSnackBar(ExpandedSnackBar.failureSnackBar(context, state.errorString));
            }
            if (state is RegisterSuccess){
               Navigator.pushNamed(context, Routes.createPinRoute);
            }
          },
          builder: (context, state){
            return Scaffold(
              resizeToAvoidBottomInset: false,
              body: (state is RegisterLoading) ? Center(child: CircularProgressIndicator(),) : SignUpBody(),
            );
          }
        ),
      ),
    );
  }
}