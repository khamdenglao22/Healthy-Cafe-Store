import 'package:flutter/material.dart';

class CustomButtonWidget extends StatelessWidget {
  final VoidCallback onPressed;
  final Color bgColor;
  final Color textColor;
  final String textTitle;
  final double? fontSize;
  final FontWeight? fontWeight;
  final double pHorizontal;
  final double pVertical;

  const CustomButtonWidget({
    super.key,
    required this.onPressed,
    required this.bgColor,
    required this.textColor,
    required this.textTitle,
    this.fontSize,
    this.fontWeight,
    required this.pHorizontal,
    required this.pVertical,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: bgColor,
        padding: EdgeInsets.symmetric(
          horizontal: pHorizontal,
          vertical: pVertical,
        ),
      ),
      onPressed: onPressed,
      child: Text(
        textTitle,
        style: TextStyle(
          color: textColor,
          fontSize: fontSize,
          fontWeight: fontWeight,
        ),
      ), // trying to move to the bottom
    );
  }
}
