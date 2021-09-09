import 'package:equatable/equatable.dart';

abstract class LoginEvent extends Equatable{

  @override
  List<Object> get props => [];
}

class VerifyLogin extends LoginEvent {
  VerifyLogin({required this.email, required this.password});
  final email;
  final password;

  @override
  List<Object> get props => [email, password];
}


class Failed extends LoginEvent{
  Failed({required this.errorString});
  final errorString;

  @override
  List<Object> get props => [errorString];
}

