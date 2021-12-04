import 'package:adam/model/service/service.dart';
import 'package:hive/hive.dart';

part 'subscribed_services.g.dart';

@HiveType(typeId: 1)
class SubscribedService {
  @HiveField(0)
  final bool isRunning;

  @HiveField(1)
  final bool isPremium;

  @HiveField(2)
  final Service service;

  SubscribedService({this.isRunning, this.service, this.isPremium});

  factory SubscribedService.fromJson(Map<String, dynamic> json) {
    return SubscribedService(
      isRunning: json['isRunning'],
      service: json['serviceData'],
      isPremium: json['isPremium'],
    );
  }
}
