import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:whollet/logic/bloc/pin/pin_event.dart';
import 'package:whollet/logic/bloc/pin/pin_state.dart';
import 'package:whollet/logic/repository/user_repository.dart';

class PinBloc extends Bloc<PinEvent, PinState>{
  PinBloc(PinState initialState) : super(initialState);

  @override
  Stream<PinState> mapEventToState(PinEvent event) async*{
    if(event is AddNum){
      String newPin = state.pin + event.num;
      yield state.copyWith(newPin: newPin);   
      if (newPin.length == 4){
        yield* _verifyWithDifferentState(state);
      }
    }
    if(event is DeletePrevNum){
      if (state.pin.length > 0){
        yield state.copyWith(newPin: state.pin.substring(0, state.pin.length - 1));
      }
    }
  }

  Stream<PinState> _verifyWithDifferentState(PinState state) async*{
    if (state is CreatePIN){
      yield ConfirmPIN(confirmPin: state.pin);
    }
    if (state is ConfirmPIN){
      if (state.confirmPin == state.pin){
        await FirebaseUserRepository().changePinCurrentUser(state.confirmPin);
        yield CreatePinSuccess();
      } 
      else{
        yield CreatePIN();
      }
    }
    if (state is VerifyPIN){
      if (state.confirmPin == state.pin){
        yield VerifySuccess();
      } 
      else yield VerifyPIN(confirmPin: state.confirmPin, pin: '');
    }
  }
  
}