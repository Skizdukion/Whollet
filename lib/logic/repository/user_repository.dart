import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:whollet/logic/models/user.dart';

abstract class UserRepository{

}


class FirebaseUserRepository extends UserRepository {

  static String userId = '';

  FirebaseUserRepository();
  Stream<UserModel?> getUserWithId(String id){
    return FirebaseFirestore.instance
      .collection('user_data')
      .doc(id)
      .snapshots()
      .map(_userDataFromSnapShot);

  }

  Stream<UserModel> getCurrentUser(){
    return FirebaseFirestore.instance
      .collection('users_data')
      .doc(userId)
      .snapshots()
      .map(_userDataFromSnapShot);
  }

  Future<String> getPinCurrentUser(){
    if(userId.isEmpty) return Future.value('');
    else return FirebaseFirestore.instance
      .collection('users_data')
      .doc(userId)
      .get()
      .then(_userPinFromFirebase);
  }

  Future<String> getCurrentWalletKey(){
    return FirebaseFirestore.instance.collection('users_data').doc(userId).get().then(_keyFromFirebase);
  }

  String _keyFromFirebase(DocumentSnapshot doc){
    if(doc.exists) return doc['wallet_key'];
    else throw NullThrownError();
  }

  Future<String> getWalletIdWithEmail(String email){
    return FirebaseFirestore.instance.collection('users_data').doc(email).get().then(_walletIdFromFirebase);
  }

  String _walletIdFromFirebase(DocumentSnapshot doc){
    if(doc.exists) return doc['wallet_address'];
    else throw NullThrownError();
  }

  Future<bool> isEmailExist(String email){
    return FirebaseFirestore.instance.collection('users_data').doc(email).get().then(_isEmailExistFromFirebase);
  }

  bool _isEmailExistFromFirebase(DocumentSnapshot doc){
    if(doc.exists) return true;
    else return false;
  } 

  Future changePinCurrentUser(String pin){
    return FirebaseFirestore.instance.collection('users_data').doc(userId).update({
      'pin': pin,
    });
  }

  UserModel _userDataFromSnapShot(DocumentSnapshot snapshot) {
    return UserModel(
      firstName: snapshot['first_name'],
      lastName: snapshot['last_name'],
      emailAddress: snapshot.reference.id,
      pin: snapshot['pin'],
      walletAddress:  snapshot['wallet_address'],
      walletKey: snapshot['wallet_key'],
    );    
  }

  String _userPinFromFirebase(DocumentSnapshot snapshot){
    if(snapshot.exists) return snapshot['pin'];
    else throw NullThrownError();
  }
}