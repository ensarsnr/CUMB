import 'package:flutter/material.dart';

class ButtonWT extends StatelessWidget {
  const ButtonWT({
    super.key,
    required this.onPressed,
    required this.child,
    required this.height,
    required this.width,
    required this.backgroundColor,
  });

  final VoidCallback onPressed;
  final Widget child;
  final double height;
  final double width;
  final Color backgroundColor;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: backgroundColor,
          elevation: 3,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        child: child,
      ),
    );
  }
}
