import 'package:adam/constants.dart';
import 'package:adam/utils/custom_snackbar.dart';
import 'package:flutter/material.dart';

class AudienceUtils {
  static void targetAdded(String username, BuildContext context) {
    customSnackBar(
      context,
      kLightBlueColor,
      Row(
        children: [
          Icon(
            Icons.check,
            color: Colors.white,
          ),
          SizedBox(
            width: 8.0,
          ),
          Text("$username added!")
        ],
      ),
    );
  }

  static void targetRemoved(String username, BuildContext context) {
    customSnackBar(
      context,
      Colors.red,
      Row(
        children: [
          Icon(
            Icons.delete,
            color: Colors.white,
          ),
          SizedBox(
            width: 8.0,
          ),
          Text("$username removed!")
        ],
      ),
    );
  }
}
