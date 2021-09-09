import 'package:equatable/equatable.dart';

abstract class PinState extends Equatable{
  PinState({required this.title, required this.description, required this.pin});
  final String title;
  final String description;
  final String pin;

  PinState copyWith({
    required String newPin,
  });

  List<Object?> get props => [pin];
}

class CreatePIN extends PinState{
  CreatePIN({String? pin}) : super(title: 'Create a PIN', description: 'Enhance the security of your account by creating a PIN code', pin: pin ?? '');

  @override
  CreatePIN copyWith({required String newPin}) {
    CreatePIN createPIN = CreatePIN(pin: newPin);
    return createPIN;
  }
}

class ConfirmPIN extends PinState{
  ConfirmPIN({required this.confirmPin, String? pin}) : super(title: 'Confirm PIN', description: 'Repeat a PIN to continue', pin: pin ?? '');  
  final String confirmPin;

  @override
  ConfirmPIN copyWith({required String newPin}) {
    return ConfirmPIN(confirmPin: this.confirmPin, pin: newPin);
  }
}

class VerifyPIN extends PinState{
  VerifyPIN({required this.confirmPin, String? pin}) : super(title: 'Verification Required', description: 'Please enter your PIN to proceed', pin: pin ?? ''); 
  final String confirmPin;

  @override
  VerifyPIN copyWith({required String newPin}) {
    return VerifyPIN(confirmPin: this.confirmPin, pin: newPin);
  } 
}

class CreatePinSuccess extends PinState{
  CreatePinSuccess(): super(title: 'Success', description: 'Success', pin: ''); 

  @override
  CreatePinSuccess copyWith({required String newPin}) {
    return CreatePinSuccess();
  } 
}

class VerifySuccess extends PinState{
  VerifySuccess(): super(title: 'Success', description: 'Success', pin: ''); 

  @override
  VerifySuccess copyWith({required String newPin}) {
    return VerifySuccess();
  } 
}
