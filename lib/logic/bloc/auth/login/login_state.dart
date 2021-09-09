import 'package:equatable/equatable.dart';

abstract class LoginState extends Equatable {
  const LoginState();

  @override
  List<Object?> get props => [];
}

class NormalLoginState extends LoginState{
  const NormalLoginState();
}

class LoginLoading extends LoginState{
  const LoginLoading();
}

class LoginFailed extends LoginState{
  const LoginFailed({required this.errorString});

  final String errorString;

  @override
  List<Object?> get props => [errorString];
}

class LoginSuccess extends LoginState{
  const LoginSuccess();
}


