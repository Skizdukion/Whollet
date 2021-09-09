import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_icon_network/flutter_icon_network.dart';
import 'package:whollet/global/constant/error.dart';
import 'package:whollet/logic/bloc/new_transaction/new_transaction_event.dart';
import 'package:whollet/logic/bloc/new_transaction/new_transaction_state.dart';
import 'package:whollet/logic/repository/transaction_repository.dart';
import 'package:whollet/logic/repository/user_repository.dart';

class NewTransBloc extends Bloc<NewTransEvent, NewTransState>{
  NewTransBloc() : super(NormalTransState());
  
  @override
  Stream<NewTransState> mapEventToState(NewTransEvent event) async*{
    if (event is VerifyTrans){
      yield TransLoading();
      try {
        FirebaseUserRepository _firebaseUserRepository = FirebaseUserRepository();
        if(await _firebaseUserRepository.isEmailExist(event.email)){
          yield VerifyPinTrans();
        }
        else{
          yield NormalTransState();
          yield TransFailed(errorString: ErrorString.noEmailExist);
        }
      } on Exception catch (e){
        yield NormalTransState();
        yield TransFailed(errorString: e.toString());
      }
    }
    if (event is Failed){
      yield NormalTransState();
      yield TransFailed(errorString: event.errorString);
    }
    if (event is Transfer){
      FirebaseUserRepository _firebaseUserRepository = FirebaseUserRepository();
      try{
        final SendIcxResponse tHash = await FlutterIconNetwork.instance!.sendIcx(
            yourPrivateKey: await _firebaseUserRepository.getCurrentWalletKey(),
            destinationAddress: await _firebaseUserRepository.getWalletIdWithEmail(event.email),
            value: event.icxBalance.toString());
        FirebaseTransactionRepository().addNewTransaction(event.icxBalance, event.email);
        yield TransSuccess();
      }
      on PlatformException catch (e){
        yield NormalTransState();
        if (e.code == 'ICX_TRANSFER_ERROR_CODE')
          yield TransFailed(errorString: ErrorString.notEnoughBalance);
      }
    }
  }
}