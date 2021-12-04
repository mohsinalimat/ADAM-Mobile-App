import 'package:hive/hive.dart';

part 'subscribed_services_list.g.dart';

@HiveType(typeId: 0)
class SubscribedServices {
  @HiveField(0)
  final List subscribedServices;

  SubscribedServices({this.subscribedServices});

  factory SubscribedServices.fromJson(Map<String, dynamic> json) {
    return SubscribedServices(
      subscribedServices: json['subscribedServices'],
    );
  }
}
