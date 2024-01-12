import 'package:flutter/material.dart';

class OwnDetails extends StatelessWidget {
  final String title;

  const OwnDetails({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: Center(
        child: Text(
          'Burada $title kelimesi ile ilgili detayları görebilirsiniz.',
          style: const TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
