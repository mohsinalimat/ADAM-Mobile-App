import 'package:adam/controller/theme_controller/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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
            Hero(tag: icon.toString(), child: Icon(icon, size: 20)),
            SizedBox(width: 8.0),
            Text(infoTitle)
          ],
        ),
        SizedBox(height: 5.0),
        info == ""
            ? Container()
            : Text(
                info,
                style: TextStyle(
                  fontSize: Theme.of(context).textTheme.subtitle2.fontSize,
                  color: Provider.of<ThemeProvider>(context).darkTheme
                      ? Colors.white
                      : Colors.black,
                ),
              )
      ],
    );
  }
}
