import 'package:equatable/equatable.dart';

abstract class OnBoardingEvent extends Equatable{
  const OnBoardingEvent();

  @override
  List<Object> get props => [];
}

class SwitchPage extends OnBoardingEvent{
  const SwitchPage({required this.pageIndex});
  final int pageIndex;
  
  @override
  List<Object> get props => [pageIndex];
}