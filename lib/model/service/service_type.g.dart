// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'service_type.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ServiceTypeAdapter extends TypeAdapter<ServiceType> {
  @override
  final int typeId = 4;

  @override
  ServiceType read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ServiceType(
      typeName: fields[0] as String,
      typePrice: fields[1] as int,
      typeDesc: fields[2] as String,
    );
  }

  @override
  void write(BinaryWriter writer, ServiceType obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.typeName)
      ..writeByte(1)
      ..write(obj.typePrice)
      ..writeByte(2)
      ..write(obj.typeDesc);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ServiceTypeAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
