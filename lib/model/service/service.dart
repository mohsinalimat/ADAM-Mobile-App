import 'package:adam/model/service/service_comment.dart';
import 'package:adam/model/service/service_type.dart';
import 'package:hive/hive.dart';

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
    this.serviceName,
    this.serviceId,
    this.serviceIcon,
    this.serviceType,
    this.serviceColor,
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
}
