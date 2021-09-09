import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:whollet/global/constant/decoration/text_decoration.dart';
import 'package:whollet/global/constant/exchange.dart';

class UserInfoPanel extends StatelessWidget {
  const UserInfoPanel({
    Key? key,
    required this.icxBalance,
  }) : super(key: key);
  final double icxBalance;


  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(height: 15,),
          Text('\$${(icxBalance * Exchange.icxToDollar).toStringAsFixed(4)}', style: AppTextDecoration.white32W600,),
          SizedBox(height: 5,),
          Text('${icxBalance.toStringAsFixed(4)} ICX', style: AppTextDecoration.white15W400,),
          SizedBox(height: 30),
          Expanded(
            child: Image(
              image: NetworkImage('https://cryptologos.cc/logos/icon-icx-logo.png'),
            )
          ),
          SizedBox(height: 20,),
          Text(DateFormat('MMM d,yyyy').format(DateTime.now()), style: AppTextDecoration.white15W400,),
          SizedBox(height: 20,),
        ],
      ),
    );
  }
}