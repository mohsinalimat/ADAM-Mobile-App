import 'dart:convert';

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

  ServiceType({
    this.typeName,
    this.typePrice,
    this.typeDesc,
  });

  factory ServiceType.fromJSON(var json) {
    return ServiceType(
        typeName: json['name'],
        typePrice: json['price'],
        typeDesc: json['description']);
  }

  ServiceType copyWith({
    String typeName,
    int typePrice,
    String typeDesc,
  }) {
    return ServiceType(
      typeName: typeName ?? this.typeName,
      typePrice: typePrice ?? this.typePrice,
      typeDesc: typeDesc ?? this.typeDesc,
    );
  }

  ServiceType merge(ServiceType model) {
    return ServiceType(
      typeName: model.typeName ?? this.typeName,
      typePrice: model.typePrice ?? this.typePrice,
      typeDesc: model.typeDesc ?? this.typeDesc,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'typeName': typeName,
      'typePrice': typePrice,
      'typeDesc': typeDesc,
    };
  }

  factory ServiceType.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;
  
    return ServiceType(
      typeName: map['typeName'],
      typePrice: map['typePrice'],
      typeDesc: map['typeDesc'],
    );
  }

  String toJson() => json.encode(toMap());

  factory ServiceType.fromJson(String source) => ServiceType.fromMap(json.decode(source));

  @override
  String toString() => 'ServiceType(typeName: $typeName, typePrice: $typePrice, typeDesc: $typeDesc)';

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;
  
    return o is ServiceType &&
      o.typeName == typeName &&
      o.typePrice == typePrice &&
      o.typeDesc == typeDesc;
  }

  @override
  int get hashCode => typeName.hashCode ^ typePrice.hashCode ^ typeDesc.hashCode;
}
