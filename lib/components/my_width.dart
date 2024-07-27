import 'package:flutter/material.dart';

class MyWidth extends StatelessWidget {
  const MyWidth({super.key, this.width});
  final double? width;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width ?? 20,
    );
  }
}
