import 'package:flutter/material.dart';

animateToIndex(i, controller) => controller.animateTo(100 * i,
    duration: Duration(seconds: 1), curve: Curves.fastOutSlowIn);
