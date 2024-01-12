import 'package:cumb/model/items_model.dart';
import 'package:cumb/model/words_model.dart'; // Import WordsModel
import 'package:cumb/views/home_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hive_flutter/hive_flutter.dart';

void main() async {
  await Hive.initFlutter();

  Hive.registerAdapter(ItemModelAdapter());
  Hive.registerAdapter(WordsModelAdapter());

  // Open ItemModel and WordsModel boxes
  await Hive.openBox<ItemModel>("itemBox");
  await Hive.openBox<WordsModel>("wordsBox");

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);

    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Cumb',
      home: HomeView(),
    );
  }
}
