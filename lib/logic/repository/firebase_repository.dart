import 'package:firebase_auth/firebase_auth.dart';

abstract class AuthRepository{

}

class FireBaseAuthRepository extends AuthRepository{
  static String userId = '';
}