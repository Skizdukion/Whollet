import 'package:equatable/equatable.dart';

class UserModel extends Equatable{

  UserModel({required this.emailAddress, required this.pin, required this.firstName, required this.lastName, required this.walletAddress, required this.walletKey});

  final String firstName;
  final String lastName;
  final String emailAddress;
  final String pin;
  final String walletAddress;
  final String walletKey;
  @override
  List<Object?> get props => [emailAddress];

}