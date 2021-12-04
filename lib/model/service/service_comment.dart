import 'dart:convert';

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
    this.userFullName,
    this.userRatings,
    this.comment,
    this.vote,
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

  ServiceComment copyWith({
    String userId,
    String userFullName,
    String userRatings,
    String comment,
    int vote,
  }) {
    return ServiceComment(
      userId: userId ?? this.userId,
      userFullName: userFullName ?? this.userFullName,
      userRatings: userRatings ?? this.userRatings,
      comment: comment ?? this.comment,
      vote: vote ?? this.vote,
    );
  }

  ServiceComment merge(ServiceComment model) {
    return ServiceComment(
      userId: model.userId ?? this.userId,
      userFullName: model.userFullName ?? this.userFullName,
      userRatings: model.userRatings ?? this.userRatings,
      comment: model.comment ?? this.comment,
      vote: model.vote ?? this.vote,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'userId': userId,
      'userFullName': userFullName,
      'userRatings': userRatings,
      'comment': comment,
      'vote': vote,
    };
  }

  factory ServiceComment.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return ServiceComment(
      userId: map['userId'],
      userFullName: map['userFullName'],
      userRatings: map['userRatings'],
      comment: map['comment'],
      vote: map['vote'],
    );
  }

  String toJson() => json.encode(toMap());

  factory ServiceComment.fromJson(String source) =>
      ServiceComment.fromMap(json.decode(source));

  @override
  String toString() {
    return 'ServiceComment(userId: $userId, userFullName: $userFullName, userRatings: $userRatings, comment: $comment, vote: $vote)';
  }

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is ServiceComment &&
        o.userId == userId &&
        o.userFullName == userFullName &&
        o.userRatings == userRatings &&
        o.comment == comment &&
        o.vote == vote;
  }

  @override
  int get hashCode {
    return userId.hashCode ^
        userFullName.hashCode ^
        userRatings.hashCode ^
        comment.hashCode ^
        vote.hashCode;
  }
}
