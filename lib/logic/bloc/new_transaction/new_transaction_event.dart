import 'package:equatable/equatable.dart';

abstract class NewTransEvent extends Equatable{

  @override
  List<Object> get props => [];
}

class VerifyTrans extends NewTransEvent {
  VerifyTrans({required this.email, required this.icxBalance});
  final String email;
  final double icxBalance;

  @override
  List<Object> get props => [email, icxBalance];
}


class Failed extends NewTransEvent{
  Failed({required this.errorString});
  final errorString;

  @override
  List<Object> get props => [errorString];
}

class Transfer extends NewTransEvent{
  Transfer({required this.email, required this.icxBalance});
  final String email;
  final double icxBalance;
}