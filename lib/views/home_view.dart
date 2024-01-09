import 'dart:io';

import 'package:cumb/constants/button_colors/home_button_colors.dart';
import 'package:cumb/constants/home/const_text_home.dart';
import 'package:cumb/constants/nav_colors/home_nav_colors.dart';
import 'package:cumb/views/own_words.dart';
import 'package:cumb/views/ready_words.dart';
import 'package:cumb/widgets/buttons/home_buttons.dart';
import 'package:cumb/widgets/texts/home_button_text.dart';
import 'package:flutter/material.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    // responsive yapı için aldığım değerler
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 53, 53, 53),
      appBar: AppBar(
        toolbarHeight: screenHeight * 0.15,
        backgroundColor: HomeNavColors.navColors,
        centerTitle: true,
        title: HomeButtonText(
          text: HomeText.title,
          fontSize: screenWidth * 0.10,
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            HomeButton(
              onPressed: () => gotoReadyWords(context),
              height: screenHeight * 0.10,
              width: screenWidth * 0.8,
              backgroundColor: HomeButtonColors.buttonColor,
              child: HomeButtonText(
                text: HomeText.readyWords,
                fontSize: screenWidth * 0.06,
              ),
            ),
            SizedBox(height: screenHeight * 0.03),
            HomeButton(
              onPressed: () => gotoOwnWords(context),
              height: screenHeight * 0.10,
              width: screenWidth * 0.8,
              backgroundColor: HomeButtonColors.buttonColor,
              child: HomeButtonText(
                text: HomeText.ownWords,
                fontSize: screenWidth * 0.06,
              ),
            ),
            SizedBox(height: screenHeight * 0.03),
            HomeButton(
              onPressed: () {
                // uygulamayı sonlandırır.
                exit(0);
              },
              height: screenHeight * 0.10,
              width: screenWidth * 0.8,
              backgroundColor: HomeButtonColors.buttonColor,
              child: HomeButtonText(
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
