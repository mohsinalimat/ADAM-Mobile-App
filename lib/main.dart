import 'package:adam/constants.dart';
import 'package:adam/controller/darkModeController/themeProvider.dart';
import 'package:adam/controller/darkModeController/themeStyles.dart';
import 'package:adam/providers/bottomNavBarProvider.dart';
import 'package:adam/views/chat/chatView.dart';
import 'package:adam/views/profile/changeEmailView.dart';
import 'package:adam/views/profile/changePasswordView.dart';
import 'package:adam/views/profile/deleteAccountView.dart';
import 'package:adam/views/profile/editProfileView.dart';
import 'package:adam/views/login/forgotPasswordView.dart';
import 'package:adam/views/login/loginView.dart';
import 'package:adam/views/mainView.dart';
import 'package:adam/views/profile/phoneVerificationView.dart';
import 'package:adam/views/services/servicesView.dart';
import 'package:adam/views/signup/signUpView.dart';
import 'package:adam/views/subscriptionHistory/subscriptionHistoryView.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
// import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: '.env');
  // Stripe.publishableKey = apiKey;
  await Firebase.initializeApp();
  SharedPreferences pref = await SharedPreferences.getInstance();
  String user = pref.getString("userId");
  if (user == null) {
    print("No user logged in!");
    runApp(MyApp(
      userLoggedIn: false,
    ));
  } else {
    print("User already logged in!");
    runApp(MyApp(
      userLoggedIn: true,
    ));
  }
}

class MyApp extends StatefulWidget {
  final bool userLoggedIn;

  MyApp({Key key, this.userLoggedIn}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  ThemeProvider _themeProvider = ThemeProvider();

  void getCurrentAppTheme() async {
    _themeProvider.darkTheme = await _themeProvider.darkThemePref.getTheme();
  }

  @override
  void initState() {
    getCurrentAppTheme();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => _themeProvider,
      child: Consumer<ThemeProvider>(
        builder: (context, value, child) => MaterialApp(
          title: 'ADAM',
          debugShowCheckedModeBanner: false,
          theme: ThemeStyles.themeData(_themeProvider.darkTheme, context),
          initialRoute: widget.userLoggedIn ? "/mainView" : "/",
          routes: {
            "/": (context) => LoginView(),
            "/signUp": (context) => SignUpView(),
            "/forgotPassword": (context) => ForgotPasswordView(),
            "/mainView": (context) => ChangeNotifierProvider(
                  builder: (context, child) => MainView(),
                  create: (context) => BottomNavBarProvider(),
                ),
            "/editProfile": (context) => EditProfileView(),
            "/deleteAccount": (context) => DeleteAccountView(),
            "/changePassword": (context) => ChangePasswordView(),
            "/changeEmail": (context) => ChangeEmailView(),
            "/services": (context) => ServicesView(),
            "/phoneVerify": (context) => PhoneVerificationView(),
            "/chat": (context) => ChatView(),
            "/subscriptionHistory": (context) => SubscriptionHistoryView(),
          },
        ),
      ),
    );
  }
}
