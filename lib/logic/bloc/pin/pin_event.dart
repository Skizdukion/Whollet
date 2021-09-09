
import 'package:equatable/equatable.dart';

abstract class PinEvent extends Equatable{
  const PinEvent();

  @override
  List<Object> get props => [];
}

class AddNum extends PinEvent{
  const AddNum({required this.num});
  final String num;
}

class DeletePrevNum extends PinEvent{
  const DeletePrevNum();
}