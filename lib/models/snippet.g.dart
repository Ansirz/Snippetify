// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'snippet.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class SnippetAdapter extends TypeAdapter<Snippet> {
  @override
  final int typeId = 0;

  @override
  Snippet read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Snippet(
      code: fields[3] as String?,
      date: fields[2] as DateTime,
      description: fields[1] as String?,
      title: fields[0] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, Snippet obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.title)
      ..writeByte(1)
      ..write(obj.description)
      ..writeByte(2)
      ..write(obj.date)
      ..writeByte(3)
      ..write(obj.code);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SnippetAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
