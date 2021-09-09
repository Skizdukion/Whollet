import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:whollet/global/constant/color.dart';
import 'package:whollet/global/constant/decoration/text_decoration.dart';
import 'package:whollet/global/constant/error.dart';
import 'package:whollet/global/constant/image_path.dart';
import 'package:whollet/logic/bloc/auth/register/register_bloc.dart';
import 'package:whollet/logic/bloc/auth/register/register_event.dart';
import 'package:whollet/routing/routes.dart';
import 'package:whollet/widget/auth_nav.dart';
import 'package:whollet/widget/custom_button.dart';
import 'package:whollet/logic/utils/extensions/string_extension.dart';

class SignUpBody extends StatefulWidget {
  const SignUpBody({ Key? key }) : super(key: key);

  @override
  _SignUpBodyState createState() => _SignUpBodyState();
}

class _SignUpBodyState extends State<SignUpBody> {

  ValueNotifier<bool> _obscureText = ValueNotifier(true);
  TextEditingController _emailController = TextEditingController();
  TextEditingController _firstNameController = TextEditingController();
  TextEditingController _lastNameController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Column(
        children: [
          Expanded(
            child: Column(
              children: [
                SizedBox(height: 20,),
                Text('Create Account', style: AppTextDecoration.dark26W600,),
                Spacer(),
                Container(
                  width: size.width,
                  height: 250,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage(
                        AppImagePath.register,
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
                padding: const EdgeInsets.only(top: 0, left: 25, right: 25),
                child: Column(
                  children: [
                    TextFormField(
                      controller: _firstNameController,
                      validator: (val) => val!.isNotEmpty
                          ? null
                          : 'Please enter your first name',
                      decoration: InputDecoration(
                        hintText: 'First name',
                        labelText: 'First name',
                      ),
                    ),
                    SizedBox(height: 10,),
                    TextFormField(
                      controller: _lastNameController,
                      decoration: InputDecoration(
                        hintText: 'Last name',
                        labelText: 'Last name',
                      ),
                    ),
                    SizedBox(height: 10,),
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
                    Spacer(),
                    CustomButton(onPress: () async{
                      signUp();
                    }, text: "Let's get started", outline: false,),                      
                    AuthNavigation(
                      text: "Already have an account?",
                      buttonText: "Login", 
                      textColor: AppColors.ligtGreyColor, 
                      buttonTextColor: AppColors.darkBlueColor, 
                      onPress: (){
                        Navigator.pushNamed(context, Routes.loginRoute);
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

  void signUp() async{
    RegisterBloc registerBloc = BlocProvider.of<RegisterBloc>(context);
    if (_firstNameController.text.isEmpty){
      registerBloc.add(Failed(errorString: ErrorString.emptyFirstName));
      return;
    }
    if (_lastNameController.text.isEmpty){     
      registerBloc.add(Failed(errorString: ErrorString.emptyLastName));
      return;
    }
    if (_emailController.text.isEmpty){
      registerBloc.add(Failed(errorString: ErrorString.emptyEmailAddress));
      return;
    }
    if (_passwordController.text.isEmpty){
      registerBloc.add(Failed(errorString: ErrorString.emptyPassword));
      return;
    }
    if (!_emailController.text.isValidEmail()){
      registerBloc.add(Failed(errorString: ErrorString.unvalidEmailAddress));
      return;
    }
    if (_passwordController.text.length < 6){
      registerBloc.add(Failed(errorString: ErrorString.notEnoughPasswordLength));
      return;
    }
    registerBloc.add(VerifyRegister(firstName: _firstNameController.text, lastName: _lastNameController.text, email: _emailController.text, password: _passwordController.text));
  }
}