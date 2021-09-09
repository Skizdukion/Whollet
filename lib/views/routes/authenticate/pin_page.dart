import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:whollet/global/constant/decoration/text_decoration.dart';
import 'package:whollet/logic/bloc/pin/pin_bloc.dart';
import 'package:whollet/logic/bloc/pin/pin_event.dart';
import 'package:whollet/logic/bloc/pin/pin_state.dart';
import 'package:whollet/logic/repository/user_repository.dart';
import 'package:whollet/routing/routes.dart';
import 'package:whollet/widget/num_key.dart';

class PinPage extends StatelessWidget {
  const PinPage({ Key? key, required this.isCreatePin }) : super(key: key);
  final bool isCreatePin;  

  void loadPin() async {
    await  FirebaseUserRepository().getPinCurrentUser();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: FutureBuilder<String>(
        future: FirebaseUserRepository().getPinCurrentUser(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(
              child: Text(snapshot.error.toString()),
            );
          }
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }
          return BlocProvider(
            create: (_) => PinBloc(isCreatePin ? CreatePIN() : VerifyPIN(confirmPin: snapshot.data!)),
            child: BlocConsumer<PinBloc, PinState>(
              listener: (context, state){
                if (state is VerifySuccess){
                  Navigator.pop(context, true);
                }
                if (state is CreatePinSuccess){
                  Navigator.pushNamed(context, Routes.homeRoute);
                }
              },
              builder: (context, state){
                return Scaffold(
                  resizeToAvoidBottomInset: false,
                  body: Column(
                    children: [
                      SizedBox(height: 8,),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 32),
                        child: Container(
                          height: 50,
                          child: Text(
                            state.description, 
                            style: AppTextDecoration.ligtGrey15W600, 
                            textAlign: TextAlign.center,
                          ),
                        ),              
                      ),
                      Expanded(child: Center(child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [                     
                          for (int i = 0; i < 4; i++)
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 10),
                            child: Container(
                              width: 22,
                              height: 22,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: i < state.pin.length ? Color(0xFF75BF72) : Color(0xFF9EA5B1),
                              ),
                            ),
                          ) 
                        ],
                      ))),
                      NumKey(
                        numPress: (val){
                          context.read<PinBloc>().add(AddNum(num: val));
                        }, 
                        deleteNumPress: () => context.read<PinBloc>().add(DeletePrevNum()),
                      ),
                      SizedBox(height: 10,),
                    ],
                  ),
                  appBar: buildAppBar(state.title),
                );
              },
            ),
          );
        }
      ),
    );
  }

  AppBar buildAppBar(String title,){
    return AppBar(
      title: Text(title, style: AppTextDecoration.dark26W600),    
      automaticallyImplyLeading: isCreatePin ? false : true,  
      backgroundColor: Colors.transparent,
      elevation: 0,
      centerTitle: true,
      iconTheme: IconThemeData(
        color: Colors.black, 
      ),
    );
  }
}