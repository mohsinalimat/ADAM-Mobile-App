// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'subscribed_services_list.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class SubscribedServicesAdapter extends TypeAdapter<SubscribedServices> {
  @override
  final int typeId = 0;

  @override
  SubscribedServices read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return SubscribedServices(
      subscribedServices: (fields[0] as List)?.cast<dynamic>(),
    );
  }

  @override
  void write(BinaryWriter writer, SubscribedServices obj) {
    writer
      ..writeByte(1)
      ..writeByte(0)
      ..write(obj.subscribedServices);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SubscribedServicesAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
