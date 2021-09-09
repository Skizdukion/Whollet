import 'package:equatable/equatable.dart';

class OnBoardingState extends Equatable{
  const OnBoardingState({
    required this.title,
    required this.content,
    required this.pageIndex
  });

  final String title;
  final String content;
  final int pageIndex;

  @override
  List<Object?> get props => [pageIndex];
}
