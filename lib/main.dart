import 'package:adam/controller/darkModeController/themeProvider.dart';
import 'package:adam/controller/darkModeController/themeStyles.dart';
import 'package:adam/providers/bottomNavBarProvider.dart';
import 'package:adam/splashScreen.dart';
import 'package:adam/views/chat/chatView.dart';
import 'package:adam/views/profile/changeEmailView.dart';
import 'package:adam/views/profile/changePasswordView.dart';
import 'package:adam/views/profile/deleteAccountView.dart';
import 'package:adam/views/profile/editProfileView.dart';
import 'package:adam/views/login/forgotPasswordView.dart';
import 'package:adam/views/login/loginView.dart';
import 'package:adam/views/mainView.dart';
import 'package:adam/views/profile/phoneVerificationView.dart';
import 'package:adam/views/profile/profileView.dart';
import 'package:adam/views/services/servicesView.dart';
import 'package:adam/views/settings/accountView.dart';
import 'package:adam/views/settings/help/appInfo.dart';
import 'package:adam/views/settings/help/faqView.dart';
import 'package:adam/views/settings/help/helpView.dart';
import 'package:adam/views/settings/notificationView.dart';
import 'package:adam/views/settings/themeView.dart';
import 'package:adam/views/signup/signUpView.dart';
import 'package:adam/views/subscriptionHistory/subscriptionHistoryView.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: '.env');
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  ThemeProvider _themeProvider = ThemeProvider();
  BottomNavBarProvider _bottomNavBarProvider = BottomNavBarProvider();

  void getCurrentAppTheme() async {
    _themeProvider.darkTheme = await _themeProvider.darkThemePref.getTheme();
  }

  void getFontSize() async {
    _themeProvider.size = await _themeProvider.darkThemePref.getFontSize();
  }

  @override
  void initState() {
    getCurrentAppTheme();
    getFontSize();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return _themeProvider == null
        ? CircularProgressIndicator()
        : ChangeNotifierProvider(
            create: (context) => _themeProvider,
            builder: (context, child) => Consumer<ThemeProvider>(
              builder: (context, themeProvider, child) => MaterialApp(
                title: 'ADAM',
                debugShowCheckedModeBanner: false,
                theme: ThemeStyles.themeData(
                  _themeProvider.darkTheme,
                  context,
                  _themeProvider.size == "Medium"
                      ? 28.0
                      : _themeProvider.size == "Large"
                          ? 35.0
                          : 20.0,
                ),
                initialRoute: "/splashScreen",
                routes: {
                  "/": (context) => LoginView(),
                  "/splashScreen": (context) => SplashScreen(),
                  "/signUp": (context) => SignUpView(),
                  "/forgotPassword": (context) => ForgotPasswordView(),
                  "/mainView": (context) => ChangeNotifierProvider(
                        builder: (context, child) => MainView(),
                        create: (context) => _bottomNavBarProvider,
                      ),
                  "/profile": (context) => ProfileView(),
                  "/editProfile": (context) => EditProfileView(),
                  "/deleteAccount": (context) => DeleteAccountView(),
                  "/changePassword": (context) => ChangePasswordView(),
                  "/changeEmail": (context) => ChangeEmailView(),
                  "/services": (context) => ServicesView(),
                  "/phoneVerify": (context) => PhoneVerificationView(),
                  "/chat": (context) => ChatView(),
                  "/subscriptionHistory": (context) =>
                      SubscriptionHistoryView(),
                  "/account": (context) => AccountView(),
                  "/notifications": (context) => NotificationView(),
                  "/help": (context) => HelpView(),
                  "/theme": (context) => ThemeView(),
                  "/faq": (context) => FAQView(),
                  "/appInfo": (context) => AppInfo(),
                },
              ),
            ),
          );
  }
}
