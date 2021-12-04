import 'package:hive/hive.dart';

part 'service_comment.g.dart';

@HiveType(typeId: 5)
class ServiceComment {
  @HiveField(0)
  final String userId;

  @HiveField(1)
  final String userFullName;

  @HiveField(2)
  final String userRatings;

  @HiveField(3)
  final String comment;

  @HiveField(4)
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
