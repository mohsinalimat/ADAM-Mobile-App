import 'package:adam/constants.dart';
import 'package:adam/providers/bottomNavBarProvider.dart';
import 'package:adam/views/mainView.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ADAM',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        accentColor: kPrimaryBlueColor,
        primaryColor: kPrimaryBlueColor,
      ),
      home: ChangeNotifierProvider<BottomNavBarProvider>(
        child: MainView(),
        create: (context) => BottomNavBarProvider(),
      ),
    );
  }
}
