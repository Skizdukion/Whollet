import 'package:flutter/material.dart';
import 'package:whollet/global/constant/decoration/text_decoration.dart';
import 'package:whollet/logic/models/transaction.dart';
import 'package:whollet/logic/repository/transaction_repository.dart';
import 'package:whollet/views/routes/home/home_component/transaction.dart';

class TransactionHistory extends StatefulWidget {
  const TransactionHistory({ Key? key }) : super(key: key);

  @override
  _TransactionHistoryState createState() => _TransactionHistoryState();
}

class _TransactionHistoryState extends State<TransactionHistory> {

  late Stream<List<TransactionModel>> streamTransList; 

  @override
  void initState() {
    streamTransList = FirebaseTransactionRepository().getStreamTransList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      width: size.width,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 20,),
            Text('Latest transactions', style: AppTextDecoration.ligtGrey15W600,),
            SizedBox(height: 20,),
            Container(
              height: size.height*0.7 - 200,
              child: StreamBuilder<List<TransactionModel>>(
                stream: streamTransList,
                builder: (context, snapshot) {
                  if (snapshot.hasError) {
                    return Center(
                      child: Text(snapshot.error.toString()),
                    );
                  }
                  if (!snapshot.hasData) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  List<TransactionModel> _tranListData = snapshot.data!;
                  return ListView.builder(
                    itemCount: _tranListData.length,
                    itemBuilder: (context, index){
                      return TransactionItem(transaction: _tranListData[index],);
                      // return TransactionItem(transaction: TransactionModel(type: TransactionType.receive, fromUser: 'sample@gmail.com', toUser: 'sample1@gmail.com', icxBalance: 5.0, createdDate: DateTime.now(), uid: '1'));
                    },
                    shrinkWrap: true,
                  );
                }
              ),
            ),
          ],
        ),
      ),
    );
  }
}

