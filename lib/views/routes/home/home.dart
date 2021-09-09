import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_icon_network/flutter_icon_network.dart';
import 'package:whollet/global/constant/color.dart';
import 'package:whollet/global/constant/decoration/text_decoration.dart';
import 'package:whollet/logic/models/user.dart';
import 'package:whollet/logic/repository/user_repository.dart';
import 'package:whollet/routing/routes.dart';
import 'package:whollet/views/routes/home/home_component/bottom_app_bar.dart';
import 'package:whollet/views/routes/home/home_component/create_transaction.dart';
import 'package:whollet/views/routes/home/home_component/trans_history.dart';
import 'package:whollet/logic/utils/extensions/string_extension.dart';

import 'home_component/user_info_panel.dart';
class HomePage extends StatefulWidget {
  const HomePage({ Key? key }) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  FirebaseUserRepository _userRepository = FirebaseUserRepository();
  late Stream<UserModel> _userStream;
  late ValueNotifier<double> _balance = ValueNotifier(-1);
  late String userKey;
  
  @override
  void initState() {
    _userStream = _userRepository.getCurrentUser();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    
    Size size = MediaQuery.of(context).size;
    return SafeArea(
      child: StreamBuilder<UserModel>(
        stream: _userStream,
        builder: (context, userSnapShot){ 
          if (userSnapShot.hasError) {
            return Center(
              child: Text(userSnapShot.error.toString()),
            );
          }
          if (!userSnapShot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }
          UserModel userData = userSnapShot.data!;
          userKey = userData.walletKey;
          return Scaffold(    
            resizeToAvoidBottomInset: false, 
            backgroundColor: AppColors.darkBlueColor, 
            appBar: AppBar(
              automaticallyImplyLeading: false,
              title: Text('Your Wallet', style: AppTextDecoration.white26W600),
              backgroundColor: Colors.transparent,
              elevation: 0,
              centerTitle: true,
              actions: [
                IconButton(
                  onPressed: () {
                    Navigator.pushNamed(context, Routes.welcomeRoute);
                  },
                  icon: Icon(
                    Icons.logout,
                    color: Colors.white,
                  ),
                )
              ],
            ),
            body: Column(
              children: [
                Expanded(
                  child: FutureBuilder<Balance>(
                    future: FlutterIconNetwork.instance!.getIcxBalance(privateKey: userKey),
                    builder: (context, snapshot){
                      if (snapshot.hasError) {
                        return Center(
                          child: Text(snapshot.error.toString()),
                        );
                      }
                      if (!snapshot.hasData) {
                        return const Center(child: CircularProgressIndicator());
                      }
                      Balance balanceData = snapshot.data!;
                      _balance.value = balanceData.icxBalance;
                      return ValueListenableBuilder(
                        valueListenable: _balance,
                        builder: (context, bool, child){ 
                          return UserInfoPanel(icxBalance: _balance.value,);
                        }
                      );
                    }
                  ),
                  flex: 30,
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
                    child: Column(
                      children: [
                        SizedBox(height: 5,),
                        Text('Welcome, ${userData.firstName} ${userData.lastName}'.limitString(28), style: AppTextDecoration.dark26W600,),
                        TransactionHistory(),
                      ],
                    ),
                  ),
                  flex: 70,
                ),
              ],
            ),
            floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
            floatingActionButton: FloatingActionButton(
              onPressed: () => _showAddMenu(),
              tooltip: "Centre FAB",
              child: Container(
                margin: EdgeInsets.all(15.0),
                child: Icon(Icons.add),
              ),
              elevation: 4.0,
              backgroundColor: AppColors.darkBlueColor,
            ),
            bottomNavigationBar: FABBottomAppBar(
              items: [
                FABBottomAppBarItem(iconData: Icons.replay_outlined, text: 'Reload Balance', onPress: ()async{
                  _balance.value = (await FlutterIconNetwork.instance!.getIcxBalance(privateKey: userKey)).icxBalance;
                }),
                FABBottomAppBarItem(iconData: Icons.create_outlined, text: 'Copy Wallet ID',  onPress: (){
                  Clipboard.setData(ClipboardData(text: userData.walletAddress));
                }),
              ],
              centerItemText: '',
              backgroundColor: AppColors.extremeLightGreyColor,
              color: AppColors.ligtGreyColor,
            ),
          );
        }
      )
    );
  }

    _showAddMenu() {
      showDialog(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
          child: Dialog(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
            backgroundColor: Colors.white,
            child: CreateTransaction(),
          )
        );
      }
    ); 
  }  
}