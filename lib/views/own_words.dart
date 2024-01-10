import 'package:cumb/widgets/dialog/own_words_dialog.dart';
import 'package:flutter/material.dart';

class OwnWords extends StatelessWidget {
  const OwnWords({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Kendi hazırladıkların"),
      ),
      body: Center(child: Text("Kendi hazırladıkların")),
      floatingActionButton: FloatingActionButton(
          onPressed: () {
            showDialog(
              context: context,
              builder: (BuildContext context) {
                double screenHeight = MediaQuery.of(context).size.height;
                double screenWidth = MediaQuery.of(context).size.width;
                return OwnWordsDialog(
                  screenHeight: screenHeight,
                  screenWidth: screenWidth,
                );
              },
            );
          },
          child: Icon(Icons.add)),
    );
  }
}
