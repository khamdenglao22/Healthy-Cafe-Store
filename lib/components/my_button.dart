import 'package:flutter/material.dart';

class MyButton extends StatelessWidget {
  const MyButton({
    Key? key,
    required this.child,
    required this.onPressed,
    this.backColor,
    this.foredkColor,
    this.radius,
    this.height,
    this.width,
    this.padding,
    this.margin,
  }) : super(key: key);
  final VoidCallback? onPressed;
  final Widget child;
  final Color? backColor;
  final Color? foredkColor;
  final double? radius;
  final double? height;
  final double? width;
  final EdgeInsets? padding;
  final EdgeInsets? margin;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height ?? 45,
      width: width,
      margin: margin,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
            backgroundColor: backColor,
            foregroundColor: foredkColor,
            padding: padding,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(radius ?? 12))),
        onPressed: onPressed,
        child: child,
      ),
    );
  }
}
