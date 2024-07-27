import 'package:flutter/material.dart';

class MyHeight extends StatelessWidget {
  const MyHeight({super.key,this.height});
  final double? height;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height ?? 20,
    );
  }
}
