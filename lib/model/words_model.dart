import 'package:hive/hive.dart';

part 'words_model.g.dart';

@HiveType(typeId: 1)
class WordsModel {
  @HiveField(0)
  final List words;
  @HiveField(1)
  final int itemId;

  WordsModel(
    this.words,
    this.itemId,
  );
}
