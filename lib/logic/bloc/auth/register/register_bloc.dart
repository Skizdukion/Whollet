
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_icon_network/flutter_icon_network.dart';
import 'package:whollet/logic/bloc/auth/register/register_event.dart';
import 'package:whollet/logic/bloc/auth/register/register_state.dart';
import 'package:whollet/logic/repository/firebase_repository.dart';
import 'package:whollet/logic/repository/user_repository.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState>{
  RegisterBloc() : super(NormalRegisterState());

  @override
  Stream<RegisterState> mapEventToState(RegisterEvent event) async*{
    if (event is VerifyRegister){
      yield RegisterLoading();
      try {
        UserCredential userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword( email: event.email, password: event.password,);
        if (userCredential.user != null) {
            final wallet = await FlutterIconNetwork.instance!.createWallet;
            await FirebaseFirestore.instance
                .collection('users_data')
                .doc(event.email)
                .set({
                  'first_name': event.firstName,
                  'last_name': event.lastName,
                  'wallet_address': wallet.address,
                  'wallet_key': wallet.privateKey,
                  'pin': '1111',
                });
          FirebaseUserRepository.userId = event.email;
          yield RegisterSuccess();
        }
      } on FirebaseAuthException catch (e) {
        yield NormalRegisterState();
        yield RegisterFailed(errorString: e.message.toString());        
      } on Exception catch (e){
        yield NormalRegisterState();
        yield RegisterFailed(errorString: e.toString());
      }
    }
    if (event is Failed){
      yield NormalRegisterState();
      yield RegisterFailed(errorString: event.errorString);
    }
  }
}