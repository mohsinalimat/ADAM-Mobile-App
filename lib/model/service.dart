class ServicesList {
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

class Service {
  final String serviceId;
  final String serviceName;
  final String serviceIcon;
  final List<dynamic> serviceColor;
  final List<ServiceType> serviceType;
  final int serviceRatings;
  final List<ServiceComment> serviceComments;

  Service({
    this.serviceName,
    this.serviceId,
    this.serviceIcon,
    this.serviceType,
    this.serviceColor,
    this.serviceRatings,
    this.serviceComments,
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
    );
  }
}

class ServiceType {
  final String typeName;
  final int typePrice;
  final String typeDesc;

  ServiceType({this.typeName, this.typePrice, this.typeDesc});

  factory ServiceType.fromJSON(var json) {
    return ServiceType(
        typeName: json['name'],
        typePrice: json['price'],
        typeDesc: json['description']);
  }
}

class ServiceComment {
  final String userId;
  final String userFullName;
  final String userRatings;
  final String comment;
  final int vote;

  ServiceComment({
    this.userId,
    this.comment,
    this.vote,
    this.userFullName,
    this.userRatings,
  });

  factory ServiceComment.fromJSON(Map<String, dynamic> json) {
    return ServiceComment(
      userId: json['userId'],
      comment: json['comment'],
      vote: json['votes'],
      userFullName: json['cust_fullName'],
      userRatings: json['user_rating'].toString(),
    );
  }
}

// USER MODELS
class SubscribedServices {
  final List subscribedServices;

  SubscribedServices({this.subscribedServices});

  factory SubscribedServices.fromJson(Map<String, dynamic> json) {
    return SubscribedServices(
      subscribedServices: json['subscribedServices'],
    );
  }
}

class SubscribedService {
  final bool isRunning;
  final bool isPremium;
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
