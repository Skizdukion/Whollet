import 'package:flutter/material.dart';
import 'package:whollet/global/constant/color.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({
    Key? key,
    required this.onPress,
    required this.text,
    this.outline = true,
  }) : super(key: key);

  final Function onPress;
  final String text;
  final bool outline;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 200,
      height: 50,
      child: ElevatedButton(
        onPressed: () => onPress(),
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all<Color>(outline ? Colors.white : AppColors.darkBlueColor),
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(23.0),
              side: BorderSide(color: AppColors.darkBlueColor,)
            ),
          ),
          elevation: MaterialStateProperty.all(0),
        ),
        child: Text(
          text,
          style: TextStyle(color: outline ? AppColors.darkBlueColor : Colors.white, fontSize: 18),
        ),
      ),
    );
  }
}