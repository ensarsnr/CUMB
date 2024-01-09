import 'package:flutter/material.dart';

class HomeButton extends StatelessWidget {
  const HomeButton({
    super.key,
    required this.onPressed,
    required this.child,
    required this.height,
    required this.backgroundColor,
  });

  final VoidCallback onPressed;
  final Widget child;
  final double height;
  final Color backgroundColor;
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        // padding: , responsive olarak ayarlarız burayı
        backgroundColor: backgroundColor,
      ),
      child: child,
    );
  }
}
