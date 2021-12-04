// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'service_comment.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ServiceCommentAdapter extends TypeAdapter<ServiceComment> {
  @override
  final int typeId = 5;

  @override
  ServiceComment read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ServiceComment(
      userId: fields[0] as String,
      userFullName: fields[1] as String,
      userRatings: fields[2] as String,
      comment: fields[3] as String,
      vote: fields[4] as int,
    );
  }

  @override
  void write(BinaryWriter writer, ServiceComment obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.userId)
      ..writeByte(1)
      ..write(obj.userFullName)
      ..writeByte(2)
      ..write(obj.userRatings)
      ..writeByte(3)
      ..write(obj.comment)
      ..writeByte(4)
      ..write(obj.vote);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ServiceCommentAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
