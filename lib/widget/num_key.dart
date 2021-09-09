import 'package:flutter/material.dart';
import 'package:whollet/global/constant/decoration/text_decoration.dart';

class NumKey extends StatelessWidget {
  const NumKey({ Key? key, required this.numPress, required this.deleteNumPress }) : super(key: key);
  final ValueSetter<String> numPress;
  final Function deleteNumPress;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 15),
      child: Container(
        height: 300,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            for (int i = 0; i < 3; i++) Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                for (int j = 0; j < 3; j++) NumButton(num: i*3 + j + 1, numPress: numPress,),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                TextButton(
                  onPressed: () => numPress('.'),
                  child: Text('.', style: AppTextDecoration.pinNumber,),
                ),
                NumButton(num: 0, numPress: numPress,),
                TextButton(
                  onPressed: () => deleteNumPress(),
                  child: Icon(Icons.backspace_outlined),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class NumButton extends StatelessWidget {
  const NumButton({ Key? key, required this.num, required this.numPress }) : super(key: key);
  final int num;
  final ValueSetter<String> numPress;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () => numPress(num.toString()),
      child: Text(num.toString(), style: AppTextDecoration.pinNumber,),
    );
  }
}