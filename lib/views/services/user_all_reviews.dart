import 'package:adam/animations/bottom_animation.dart';
import 'package:adam/model/service.dart';
import 'package:adam/views/services/widgets/feedback_card.dart';
import 'package:flutter/material.dart';

class UserReviews extends StatelessWidget {
  final List<ServiceComment> userReviews;

  UserReviews({Key key, this.userReviews}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("User Reviews"),
      ),
      body: ListView.separated(
        padding: const EdgeInsets.all(10.0),
        itemCount: userReviews.length,
        separatorBuilder: (context, index) => Divider(
          color: Colors.grey,
        ),
        itemBuilder: (context, index) => WidgetAnimator(
          child: FeedbackCard(
            serviceCommentData: userReviews[index],
          ),
        ),
      ),
    );
  }
}
