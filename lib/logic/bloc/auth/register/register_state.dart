import 'package:equatable/equatable.dart';

abstract class RegisterState extends Equatable {
  const RegisterState();

  @override
  List<Object?> get props => [];
}

class NormalRegisterState extends RegisterState{
  const NormalRegisterState();
}

class RegisterLoading extends RegisterState{
  const RegisterLoading();
}

class RegisterFailed extends RegisterState{
  const RegisterFailed({required this.errorString});

  final String errorString;

  @override
  List<Object?> get props => [errorString];
}

class RegisterSuccess extends RegisterState{
  const RegisterSuccess();
}


