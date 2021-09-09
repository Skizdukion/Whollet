import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:whollet/logic/bloc/on_boarding/on_boarding_bloc.dart';
import 'component/on_boarding_body.dart';

class OnBoardingPage extends StatefulWidget {
  const OnBoardingPage({ Key? key }) : super(key: key);

  @override
  _OnBoardingPageState createState() => _OnBoardingPageState();
}

class _OnBoardingPageState extends State<OnBoardingPage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: BlocProvider(
          create: (_) => OnBoardingBloc(),
          child: OnBoardingBody(),
        ),
      ),
    );
  }
}

