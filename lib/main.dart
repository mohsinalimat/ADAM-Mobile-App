import 'package:adam/constants.dart';
import 'package:adam/providers/bottomNavBarProvider.dart';
import 'package:adam/views/forgotPasswordView.dart';
import 'package:adam/views/loginView.dart';
import 'package:adam/views/signUpView.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
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
        fontFamily: "Roboto",
      ),
      initialRoute: "/",
      routes: {
        "/": (context) => ChangeNotifierProvider<BottomNavBarProvider>(
              child: LoginView(),
              create: (context) => BottomNavBarProvider(),
            ),
        "/signUp": (context) => SignUpView(),
        "/forgotPassword": (context) => ForgotPasswordView()
      },
    );
  }
}
