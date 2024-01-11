import 'package:flutter/material.dart';

class ReadyWords extends StatelessWidget {
  const ReadyWords({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Hazır Kelimeler"),
      ),
      body: const Center(
        child: Text("Hazır kelimeler"),
      ),
    );
  }
}
