import 'package:flutter/material.dart';

class AuthNavigation extends StatelessWidget {
  const AuthNavigation({
    Key? key,
    required this.text,
    required this.buttonText,
    required this.textColor,  
    required this.buttonTextColor,  
    required this.onPress
  }) : super(key: key);

  final String text;
  final String buttonText;
  final Color textColor;
  final Color buttonTextColor;
  final Function onPress;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          this.text,
          style: TextStyle(
            color: textColor,
            fontSize: 15,
          ),
        ),
        TextButton(
          onPressed: () => onPress(),
          child: Text(
            buttonText,
            style: TextStyle(
              color: buttonTextColor,
              fontWeight: FontWeight.w600,
              fontSize: 15,
            ),
          )
        ),
      ],
    );
  }
}