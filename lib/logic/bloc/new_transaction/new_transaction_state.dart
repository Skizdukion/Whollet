import 'package:equatable/equatable.dart';
import 'package:whollet/logic/bloc/new_transaction/new_transaction_event.dart';

abstract class NewTransState extends Equatable {
  const NewTransState();

  @override
  List<Object?> get props => [];
}

class NormalTransState extends NewTransState{
  const NormalTransState();
}

class TransLoading extends NewTransState{
  const TransLoading();
}

class TransFailed extends NewTransState{
  const TransFailed({required this.errorString});

  final String errorString;

  @override
  List<Object?> get props => [errorString];
}

class VerifyPinTrans extends NewTransState{
  const VerifyPinTrans();
}

class TransSuccess extends NewTransState{
  const TransSuccess();
}


