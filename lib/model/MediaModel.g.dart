// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'MediaModel.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class MediaModelAdapter extends TypeAdapter<MediaModel> {
  @override
  final int typeId = 0;

  @override
  MediaModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return MediaModel(
      id: fields[0] as int?,
      createdAt: fields[1] as String?,
      title: fields[2] as String?,
      thumbnail: fields[3] as String?,
      thumbnailUrl: fields[4] as String?,
      video: fields[5] as String?,
      videoUrl: fields[6] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, MediaModel obj) {
    writer
      ..writeByte(7)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.createdAt)
      ..writeByte(2)
      ..write(obj.title)
      ..writeByte(3)
      ..write(obj.thumbnail)
      ..writeByte(4)
      ..write(obj.thumbnailUrl)
      ..writeByte(5)
      ..write(obj.video)
      ..writeByte(6)
      ..write(obj.videoUrl);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MediaModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
