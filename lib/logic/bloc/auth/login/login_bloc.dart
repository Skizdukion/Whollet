
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:whollet/logic/bloc/auth/login/login_event.dart';
import 'package:whollet/logic/bloc/auth/login/login_state.dart';
import 'package:whollet/logic/repository/user_repository.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState>{
  LoginBloc() : super(NormalLoginState());

  @override
  Stream<LoginState> mapEventToState(LoginEvent event) async*{
    if (event is VerifyLogin){
      yield LoginLoading();
      try {
        UserCredential userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword( email: event.email, password: event.password,);
        if (userCredential.user != null) {
          FirebaseUserRepository.userId = event.email;
          yield LoginSuccess();
        }
      } on FirebaseAuthException catch (e) {
        yield NormalLoginState();
        yield LoginFailed(errorString: e.code);        
      } on Exception catch (e){
        yield NormalLoginState();
        yield LoginFailed(errorString: e.toString());
      }
    }
    if (event is Failed){
      yield NormalLoginState();
      yield LoginFailed(errorString: event.errorString);
    }
  }
}