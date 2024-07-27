import 'package:flutter/material.dart';

class MyTitle extends StatelessWidget {
  const MyTitle({
    super.key,
    this.padding,
    required this.title,
    this.fontSize,
    this.fontColor,
  });
  final EdgeInsets? padding;
  final String title;
  final double? fontSize;
  final Color? fontColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding ?? const EdgeInsets.all(5),
      child: Text(
        title,
        style: TextStyle(
          fontSize: fontSize ?? 18,
          color: fontColor ?? Colors.black,
        ),
      ),
    );
  }
}
