import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:whollet/logic/models/transaction.dart';
import 'package:whollet/logic/repository/user_repository.dart';
import 'package:whollet/logic/utils/enum/transaction_type.dart';
import 'package:uuid/uuid.dart';

abstract class TransactionRepository{

}

class FirebaseTransactionRepository{

  Stream<List<TransactionModel>> getStreamTransList(){
    return FirebaseFirestore.instance.collection('users_data').doc(FirebaseUserRepository.userId).collection('transaction').orderBy('createdDate', descending: true).snapshots().map(_transListDataFromSnapshot);
  }

  List<TransactionModel> _transListDataFromSnapshot(QuerySnapshot  snapshot){
    return snapshot.docs.map((doc){
      return _transDataFromSnapShot(doc);
    }).toList();
  }

  TransactionModel _transDataFromSnapShot(DocumentSnapshot snapshot){
    if (snapshot['type'] == 'sent'){
      return TransactionModel(
        type: TransactionType.sent,
        toEmail: snapshot['toUser'],
        icxBalance: snapshot['icxBalance'],
        createdDate: (snapshot['createdDate'] as Timestamp).toDate(),
        uid: snapshot.reference.id,
      );
    }
    else return TransactionModel(
      type: TransactionType.receive,
      fromEmail: snapshot['fromUser'],
      icxBalance: snapshot['icxBalance'],
      createdDate: (snapshot['createdDate'] as Timestamp).toDate(),
      uid: snapshot.reference.id,
    );
  }

  Future addNewTransaction(double icxBalance, String email) async{
    var uuid = Uuid();
    String randomId = uuid.v4();
    await FirebaseFirestore.instance.collection('users_data').doc(FirebaseUserRepository.userId).collection('transaction').doc(randomId).set({
      'createdDate': Timestamp.fromDate(DateTime.now()),
      'toUser': email,
      'icxBalance': icxBalance,
      'type': 'sent',
    });
    await FirebaseFirestore.instance.collection('users_data').doc(email).collection('transaction').doc(randomId).set({
      'createdDate': Timestamp.fromDate(DateTime.now()),
      'fromUser': email,
      'icxBalance': icxBalance,
      'type': 'recieve',
    });
  }
}