// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'subscribed_services.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class SubscribedServiceAdapter extends TypeAdapter<SubscribedService> {
  @override
  final int typeId = 1;

  @override
  SubscribedService read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return SubscribedService(
      isRunning: fields[0] as bool,
      service: fields[2] as Service,
      isPremium: fields[1] as bool,
    );
  }

  @override
  void write(BinaryWriter writer, SubscribedService obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.isRunning)
      ..writeByte(1)
      ..write(obj.isPremium)
      ..writeByte(2)
      ..write(obj.service);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SubscribedServiceAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
