class SubscriptionList {
  final List subscriptions;

  SubscriptionList({this.subscriptions});

  factory SubscriptionList.fromJson(Map<String, dynamic> json) {
    Iterable history = json['services'];
    List _subscriptions =
        history.map((sub) => Subscription.fromJson(sub)).toList();
    return SubscriptionList(
      subscriptions: _subscriptions,
    );
  }
}

class Subscription {
  final String subscriptionId;
  final String serviceName;
  final bool isPremium;

  Subscription({this.subscriptionId, this.serviceName, this.isPremium});

  factory Subscription.fromJson(Map<String, dynamic> json) {
    return Subscription(
      isPremium: json['isPremium'],
      serviceName: json['serviceData']['service_name'],
      subscriptionId: json['subscriptionId'],
    );
  }
}
