import 'package:adam/constants.dart';
import 'package:flutter/material.dart';

class ProfileInfoWidget extends StatelessWidget {
  const ProfileInfoWidget({
    Key key,
    @required this.icon,
    this.info = "",
    @required this.infoTitle,
  }) : super(key: key);

  final IconData icon;
  final String infoTitle;
  final String info;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Hero(
                tag: icon.toString(),
                child: Icon(icon, color: kPrimaryBlueColor, size: 20)),
            SizedBox(width: 8.0),
            Text(
              infoTitle,
              style: TextStyle(fontSize: 14.0, color: kPrimaryBlueColor),
            )
          ],
        ),
        SizedBox(height: 5.0),
        info == ""
            ? Container()
            : Text(
                info,
                style: TextStyle(fontSize: 18.0),
              )
      ],
    );
  }
}
