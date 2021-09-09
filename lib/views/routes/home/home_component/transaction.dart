import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:whollet/global/constant/color.dart';
import 'package:whollet/global/constant/decoration/text_decoration.dart';
import 'package:whollet/global/constant/exchange.dart';
import 'package:whollet/global/constant/image_path.dart';
import 'package:whollet/logic/models/transaction.dart';
import 'package:whollet/logic/utils/enum/transaction_type.dart';

class TransactionItem extends StatelessWidget {
  const TransactionItem({ Key? key, required this.transaction }) : super(key: key);
  final TransactionModel transaction;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Container(
        width: double.infinity,
        height: 60,
        decoration: BoxDecoration(
          color: AppColors.extremeLightGreyColor,
          borderRadius: BorderRadius.circular(30),        
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(width: 10,),
            CircleAvatar(
              radius: 12,
              backgroundColor: Colors.white,   
              backgroundImage: (transaction.type == TransactionType.sent) ? AssetImage(AppImagePath.sent) : AssetImage(AppImagePath.receive),           
            ),
            SizedBox(width: 10,),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('\$${(transaction.icxBalance * Exchange.icxToDollar).toStringAsFixed(4)}', style: AppTextDecoration.dark15W600,),
                  Text('${transaction.icxBalance.toStringAsFixed(4)} ICX', style: AppTextDecoration.lightGrey15W400,),
                ],
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(transaction.type.toString().split('.').last, style: AppTextDecoration.red15W600,),
                Text(DateFormat('MMM d,yyyy').format(transaction.createdDate), style: AppTextDecoration.lightGrey15W400,),
              ],
            ),
            SizedBox(width: 20,),
          ],
        ),
      ),
    );
  }
}