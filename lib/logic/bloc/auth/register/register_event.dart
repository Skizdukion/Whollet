import 'package:equatable/equatable.dart';

abstract class RegisterEvent extends Equatable{

  @override
  List<Object> get props => [];
}

class VerifyRegister extends RegisterEvent {
  VerifyRegister({required this.email, required this.password, required this.firstName, required this.lastName});
  final email;
  final password;
  final firstName;
  final lastName;

  @override
  List<Object> get props => [email, password];
}


class Failed extends RegisterEvent{
  Failed({required this.errorString});
  final errorString;

  @override
  List<Object> get props => [errorString];
}
