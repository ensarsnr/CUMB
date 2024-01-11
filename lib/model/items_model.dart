import 'package:hive/hive.dart';

part 'items_model.g.dart';

@HiveType(typeId: 0)
class ItemModel {
  @HiveField(0)
  final String title;

  @HiveField(1)
  final String desc;

  const ItemModel(
    this.title,
    this.desc,
  );
}
