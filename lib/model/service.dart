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
  final String serviceName;
  final String serviceIcon;
  final List<dynamic> serviceColor;
  final List<ServiceType> serviceType;
  final double serviceRatings;
  final List<ServiceComment> serviceComments;

  Service(
      {this.serviceName,
      this.serviceIcon,
      this.serviceType,
      this.serviceColor,
      this.serviceRatings,
      this.serviceComments});

  factory Service.fromJSON(Map<String, dynamic> json) {
    Iterable allFeedbacks = json['service_feedback']['feedback'];
    List<ServiceComment> feedbacks = allFeedbacks
        .map((feedback) => ServiceComment.fromJSON(feedback))
        .toList();

    Iterable types = json['service_type'];
    List<ServiceType> servicesTypes =
        types.map((type) => ServiceType.fromJSON(type)).toList();
    return Service(
      serviceName: json['service_name'],
      serviceIcon: json['service_icon'],
      serviceColor: json['service_color'],
      serviceType: servicesTypes,
      serviceRatings: json['service_feedback']['ratings'],
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
  final String userFirstName;
  final String userLastName;
  final double userRatings;
  final String comment;
  final int vote;

  ServiceComment({
    this.userId,
    this.comment,
    this.vote,
    this.userFirstName,
    this.userLastName,
    this.userRatings,
  });

  factory ServiceComment.fromJSON(Map<String, dynamic> json) {
    return ServiceComment(
      userId: json['userId'],
      comment: json['comment'],
      vote: json['votes'],
      userFirstName: json['cust_firstName'],
      userLastName: json['cust_lastName'],
      userRatings: json['user_rating'],
    );
  }
}
