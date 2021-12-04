// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'services_list.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ServicesListAdapter extends TypeAdapter<ServicesList> {
  @override
  final int typeId = 3;

  @override
  ServicesList read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ServicesList(
      services: (fields[0] as List)?.cast<Service>(),
    );
  }

  @override
  void write(BinaryWriter writer, ServicesList obj) {
    writer
      ..writeByte(1)
      ..writeByte(0)
      ..write(obj.services);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ServicesListAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
