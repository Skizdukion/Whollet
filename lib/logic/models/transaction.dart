
import 'package:whollet/logic/utils/enum/transaction_type.dart';

class TransactionModel{
  TransactionModel({this.type, required this.icxBalance, required this.createdDate, this.fromEmail, this.toEmail, this.uid});

  final TransactionType? type;
  final double icxBalance;
  final DateTime createdDate;
  final String? fromEmail;
  final String? toEmail;  
  final String? uid;
}