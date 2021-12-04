import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:hive/hive.dart';

import 'package:adam/model/service/service_comment.dart';
import 'package:adam/model/service/service_type.dart';

part 'service.g.dart';

@HiveType(typeId: 2)
class Service {
  @HiveField(0)
  final String serviceId;

  @HiveField(1)
  final String serviceName;

  @HiveField(2)
  final String serviceIcon;

  @HiveField(3)
  final List<dynamic> serviceColor;

  @HiveField(4)
  final List<ServiceType> serviceType;

  @HiveField(5)
  final int serviceRatings;

  @HiveField(6)
  final List<ServiceComment> serviceComments;

  @HiveField(7)
  final bool isFavorite;

  Service({
    this.serviceId,
    this.serviceName,
    this.serviceIcon,
    this.serviceColor,
    this.serviceType,
    this.serviceRatings,
    this.serviceComments,
    this.isFavorite,
  });

  factory Service.fromJSON(Map<String, dynamic> json) {
    Iterable allFeedbacks = json['service_feedback']['feedback'];

    List<ServiceComment> feedbacks = allFeedbacks.map((feedback) {
      return ServiceComment.fromJSON(feedback);
    }).toList();

    Iterable types = json['service_type'];
    List<ServiceType> servicesTypes =
        types.map((type) => ServiceType.fromJSON(type)).toList();
    return Service(
      serviceId: json['_id'],
      serviceName: json['service_name'],
      serviceIcon: json['service_icon'],
      serviceColor: json['service_color'],
      serviceType: servicesTypes,
      serviceRatings:
          double.parse(json['service_feedback']['ratings'].toString()).toInt(),
      serviceComments: feedbacks,
      isFavorite: json['isFavorite'],
    );
  }

  Service copyWith({
    String serviceId,
    String serviceName,
    String serviceIcon,
    List<dynamic> serviceColor,
    List<ServiceType> serviceType,
    int serviceRatings,
    List<ServiceComment> serviceComments,
    bool isFavorite,
  }) {
    return Service(
      serviceId: serviceId ?? this.serviceId,
      serviceName: serviceName ?? this.serviceName,
      serviceIcon: serviceIcon ?? this.serviceIcon,
      serviceColor: serviceColor ?? this.serviceColor,
      serviceType: serviceType ?? this.serviceType,
      serviceRatings: serviceRatings ?? this.serviceRatings,
      serviceComments: serviceComments ?? this.serviceComments,
      isFavorite: isFavorite ?? this.isFavorite,
    );
  }

  Service merge(Service model) {
    return Service(
      serviceId: model.serviceId ?? this.serviceId,
      serviceName: model.serviceName ?? this.serviceName,
      serviceIcon: model.serviceIcon ?? this.serviceIcon,
      serviceColor: model.serviceColor ?? this.serviceColor,
      serviceType: model.serviceType ?? this.serviceType,
      serviceRatings: model.serviceRatings ?? this.serviceRatings,
      serviceComments: model.serviceComments ?? this.serviceComments,
      isFavorite: model.isFavorite ?? this.isFavorite,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'serviceId': serviceId,
      'serviceName': serviceName,
      'serviceIcon': serviceIcon,
      'serviceColor': serviceColor,
      'serviceType': serviceType?.map((x) => x?.toMap())?.toList(),
      'serviceRatings': serviceRatings,
      'serviceComments': serviceComments?.map((x) => x?.toMap())?.toList(),
      'isFavorite': isFavorite,
    };
  }

  factory Service.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;
  
    return Service(
      serviceId: map['serviceId'],
      serviceName: map['serviceName'],
      serviceIcon: map['serviceIcon'],
      serviceColor: List<dynamic>.from(map['serviceColor']),
      serviceType: List<ServiceType>.from(map['serviceType']?.map((x) => ServiceType.fromMap(x))),
      serviceRatings: map['serviceRatings'],
      serviceComments: List<ServiceComment>.from(map['serviceComments']?.map((x) => ServiceComment.fromMap(x))),
      isFavorite: map['isFavorite'],
    );
  }

  String toJson() => json.encode(toMap());

  factory Service.fromJson(String source) => Service.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Service(serviceId: $serviceId, serviceName: $serviceName, serviceIcon: $serviceIcon, serviceColor: $serviceColor, serviceType: $serviceType, serviceRatings: $serviceRatings, serviceComments: $serviceComments, isFavorite: $isFavorite)';
  }

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;
  
    return o is Service &&
      o.serviceId == serviceId &&
      o.serviceName == serviceName &&
      o.serviceIcon == serviceIcon &&
      listEquals(o.serviceColor, serviceColor) &&
      listEquals(o.serviceType, serviceType) &&
      o.serviceRatings == serviceRatings &&
      listEquals(o.serviceComments, serviceComments) &&
      o.isFavorite == isFavorite;
  }

  @override
  int get hashCode {
    return serviceId.hashCode ^
      serviceName.hashCode ^
      serviceIcon.hashCode ^
      serviceColor.hashCode ^
      serviceType.hashCode ^
      serviceRatings.hashCode ^
      serviceComments.hashCode ^
      isFavorite.hashCode;
  }
}
