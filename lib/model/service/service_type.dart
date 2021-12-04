import 'package:hive/hive.dart';

part 'service_type.g.dart';

@HiveType(typeId: 4)
class ServiceType {
  @HiveField(0)
  final String typeName;

  @HiveField(1)
  final int typePrice;

  @HiveField(2)
  final String typeDesc;

  ServiceType({this.typeName, this.typePrice, this.typeDesc});

  factory ServiceType.fromJSON(var json) {
    return ServiceType(
        typeName: json['name'],
        typePrice: json['price'],
        typeDesc: json['description']);
  }
}
