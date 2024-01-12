// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'words_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class WordsModelAdapter extends TypeAdapter<WordsModel> {
  @override
  final int typeId = 1;

  @override
  WordsModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return WordsModel(
      (fields[0] as List).cast<dynamic>(),
      fields[1] as int,
    );
  }

  @override
  void write(BinaryWriter writer, WordsModel obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.words)
      ..writeByte(1)
      ..write(obj.itemId);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is WordsModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
