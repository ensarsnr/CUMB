import 'dart:io';

import 'package:cumb/constants/colors/constant_colors.dart';
import 'package:cumb/constants/texts/constant_texts.dart';
import 'package:cumb/views/own_words.dart';
import 'package:cumb/views/ready_words.dart';
import 'package:cumb/widgets/buttons/button_widget.dart';
import 'package:cumb/widgets/texts/button_text.dart';
import 'package:flutter/material.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 53, 53, 53),
      appBar: AppBar(
        toolbarHeight: screenHeight * 0.15,
        backgroundColor: HomeNavColors.navColors,
        centerTitle: true,
        title: ButtonText(
          text: HomeText.title,
          fontSize: screenWidth * 0.10,
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ButtonWT(
              onPressed: () => gotoReadyWords(context),
              height: screenHeight * 0.10,
              width: screenWidth * 0.8,
              backgroundColor: HomeButtonColors.buttonColor,
              child: ButtonText(
                text: HomeText.readyWords,
                fontSize: screenWidth * 0.06,
              ),
            ),
            SizedBox(height: screenHeight * 0.03),
            ButtonWT(
              onPressed: () => gotoOwnWords(context),
              height: screenHeight * 0.10,
              width: screenWidth * 0.8,
              backgroundColor: HomeButtonColors.buttonColor,
              child: ButtonText(
                text: HomeText.ownWords,
                fontSize: screenWidth * 0.06,
              ),
            ),
            SizedBox(height: screenHeight * 0.03),
            ButtonWT(
              onPressed: () {
                // uygulamayı sonlandırır.
                exit(0);
              },
              height: screenHeight * 0.10,
              width: screenWidth * 0.8,
              backgroundColor: HomeButtonColors.buttonColor,
              child: ButtonText(
                text: HomeText.exit,
                fontSize: screenWidth * 0.06,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

void gotoReadyWords(BuildContext context) {
  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => const ReadyWords(),
    ),
  );
}

void gotoOwnWords(BuildContext context) {
  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => const OwnWords(),
    ),
  );
}
