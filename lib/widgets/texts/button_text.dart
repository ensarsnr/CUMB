import 'package:flutter/material.dart';

class ButtonText extends StatelessWidget {
  const ButtonText({super.key, required this.text, required this.fontSize});

  final String text;
  final double fontSize;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      maxLines: 3,
      overflow: TextOverflow.ellipsis,
      style: TextStyle(
        color: Colors.grey[300],
        fontWeight: FontWeight.w900,
        fontStyle: FontStyle.italic,
        // fontFamily: 'Open Sans',
        fontSize: fontSize,
      ),
    );
  }
}
