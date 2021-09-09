
import 'package:bloc/bloc.dart';
import 'package:whollet/logic/bloc/on_boarding/on_boarding_event.dart';
import 'package:whollet/logic/bloc/on_boarding/on_boarding_state.dart';

class OnBoardingBloc extends Bloc<OnBoardingEvent, OnBoardingState>{
  OnBoardingBloc() : super(OnBoardingState(title: 'Welcome to Whollet', content: "Manage all your crypto assets! It's simple and easy", pageIndex: 0));

  @override
  Stream<OnBoardingState> mapEventToState(OnBoardingEvent event) async*{
    if (event is SwitchPage){
      yield* _mapSwitchScreeen(event, state);
    }
  }
  
  Stream<OnBoardingState> _mapSwitchScreeen(SwitchPage event, OnBoardingState state) async*{
    try {
      if ((event.pageIndex == 0)) yield OnBoardingState(
        title: 'Welcome to Whollet',
        content: "Manage all your crypto assets! It's simple and easy!",
        pageIndex: 0,
      );
      if ((event.pageIndex == 1)) yield OnBoardingState(
        title: 'Nice and Tidy Crypto Portfolio',
        content: "Keep BTC, ETH, XRP, and many other ERC-20 based tokens.",
        pageIndex: 1,
      );
      if ((event.pageIndex == 2)) yield OnBoardingState(
        title: 'Receive and Send Money to Friends!',
        content: "Send crypto to your friends with a personal message attached.",
        pageIndex: 2,
      );
      if ((event.pageIndex == 3)) yield OnBoardingState(
        title: 'Your Safety is Our Top Priority',
        content: "Our top-notch security features will keep you completely safe.",
        pageIndex: 3,
      );
    } catch (e) {
      print(e);
    }
  }
}