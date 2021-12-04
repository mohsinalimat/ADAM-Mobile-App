import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:hive/hive.dart';

import 'package:adam/model/service/service.dart';

part 'services_list.g.dart';

@HiveType(typeId: 3)
class ServicesList {
  @HiveField(0)
  final List<Service> services;

  ServicesList({
    this.services,
  });

  factory ServicesList.fromJSON(Map<String, dynamic> json) {
    Iterable allServices = json['services'];
    List<Service> services =
        allServices.map((service) => Service.fromJSON(service)).toList();
    return ServicesList(
      services: services,
    );
  }

  ServicesList copyWith({
    List<Service> services,
  }) {
    return ServicesList(
      services: services ?? this.services,
    );
  }

  ServicesList merge(ServicesList model) {
    return ServicesList(
      services: model.services ?? this.services,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'services': services?.map((x) => x?.toMap())?.toList(),
    };
  }

  factory ServicesList.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return ServicesList(
      services:
          List<Service>.from(map['services']?.map((x) => Service.fromMap(x))),
    );
  }

  String toJson() => json.encode(toMap());

  factory ServicesList.fromJson(String source) =>
      ServicesList.fromMap(json.decode(source));

  @override
  String toString() => 'ServicesList(services: $services)';

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is ServicesList && listEquals(o.services, services);
  }

  @override
  int get hashCode => services.hashCode;
}
