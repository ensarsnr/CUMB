import 'package:flutter/material.dart';

class OwnDetails extends StatelessWidget {
  final String title;

  OwnDetails({required this.title});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: Center(
        child: Text(
          'Burada $title kelimesi ile ilgili detayları görebilirsiniz.',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
