import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:whollet/global/constant/color.dart';
import 'package:whollet/logic/bloc/on_boarding/on_boarding_bloc.dart';
import 'package:whollet/logic/bloc/on_boarding/on_boarding_event.dart';
import 'package:whollet/logic/bloc/on_boarding/on_boarding_state.dart';
import 'package:whollet/routing/app_routes.dart';
import 'package:whollet/routing/routes.dart';
import 'package:whollet/widget/custom_button.dart';

class OnBoardingBody extends StatefulWidget {
  const OnBoardingBody({ Key? key }) : super(key: key);

  @override
  _OnBoardingBodyState createState() => _OnBoardingBodyState();
}

class _OnBoardingBodyState extends State<OnBoardingBody> {
  
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return BlocBuilder<OnBoardingBloc, OnBoardingState>(
      builder: (context, state){
      return Column(
        children: [
          Expanded(
            flex: 50,
            child: Container(
              child: Column(
                children: [
                  Row(
                    children: [
                      Spacer(),
                      if (state.pageIndex != 3) TextButton(
                        onPressed: (){
                          Navigator.pushNamed(context, Routes.welcomeRoute);   
                        },
                        child: Text('Skip', style: TextStyle(
                          color: AppColors.darkBlueColor,
                          fontSize: 19,
                        ))
                      ),
                    ],
                  ),
                  Container(
                    width: size.width,
                    height: 250,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage(
                          'assets/images/onboarding_${state.pageIndex}.png',
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            flex: 50,
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(20),
                  topLeft: Radius.circular(20),
                ),
              ),
              width: size.width,
              child: Column(
                children: [
                  SizedBox(height: 30,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      for (int i = 0; i < 4; i++)
                      Padding(
                        padding: const EdgeInsets.only(right: 8),
                        child: Container(
                          width: 10,
                          height: 10,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: i == state.pageIndex ? AppColors.darkBlueColor : AppColors.extremeLightGreyColor,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 30,),
                  Text(
                    state.title,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: AppColors.textColor,
                      fontWeight: FontWeight.w700,
                      fontSize: 36,
                    ),
                  ),
                  SizedBox(height: 11),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 18),
                    child: Text(
                      state.content,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Color(0xFF485068),
                        fontSize: 16,
                      ),
                    ),
                  ),
                  Spacer(),
                  CustomButton(
                    onPress:() {
                      if(state.pageIndex < 3){
                        context.read<OnBoardingBloc>().add(SwitchPage(pageIndex: state.pageIndex + 1));
                      }
                      else  Navigator.pushNamed(context, Routes.welcomeRoute);                   
                    },
                    text: (state.pageIndex == 3) ? "Let's Get Started" : "Next Step",
                    outline: (state.pageIndex == 3) ? false : true,
                  ),
                  SizedBox(height: 40,),
                ],
              ),
            ),
          ),
        ],
      );
    }
    );
  }
}