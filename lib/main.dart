import 'package:adam/constants.dart';
import 'package:adam/providers/bottomNavBarProvider.dart';
import 'package:adam/views/forgotPasswordView.dart';
import 'package:adam/views/loginView.dart';
import 'package:adam/views/mainView.dart';
import 'package:adam/views/signUpView.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  SharedPreferences pref = await SharedPreferences.getInstance();
  String user = pref.getString("userId");
  if (user == null) {
    runApp(MyApp(
      userLoggedIn: false,
    ));
  } else {
    runApp(MyApp(
      userLoggedIn: true,
    ));
  }
}

class MyApp extends StatelessWidget {
  final bool userLoggedIn;

  const MyApp({Key key, @required this.userLoggedIn}) : super(key: key);

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
      // home: _userLoginCheck(),
      // home: userLoggedIn ? MainView() : LoginView(),
      initialRoute: userLoggedIn ? "/mainView" : "/",
      routes: {
        "/": (context) => LoginView(),
        "/signUp": (context) => SignUpView(),
        "/forgotPassword": (context) => ForgotPasswordView(),
        "/mainView": (context) => ChangeNotifierProvider(
              create: (context) => BottomNavBarProvider(),
              child: MainView(),
            ),
      },
    );
  }
}
