import 'package:adam/model/service/service.dart';
import 'package:hive/hive.dart';

part 'services_list.g.dart';

@HiveType(typeId: 3)
class ServicesList {
  
  @HiveField(0)
  final List<Service> services;

  ServicesList({this.services});

  factory ServicesList.fromJSON(Map<String, dynamic> json) {
    Iterable allServices = json['services'];
    List<Service> services =
        allServices.map((service) => Service.fromJSON(service)).toList();
    return ServicesList(
      services: services,
    );
  }
}
