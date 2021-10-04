import 'package:adam/views/settings/help/in_app_guide_view.dart';

import 'utils/main_imports.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await dotenv.load(fileName: '.env');
  runApp(MyApp());
}

class ScrollBehaviorModified extends ScrollBehavior {
  const ScrollBehaviorModified();
  @override
  ScrollPhysics getScrollPhysics(BuildContext context) {
    switch (getPlatform(context)) {
      case TargetPlatform.iOS:
      case TargetPlatform.macOS:
      case TargetPlatform.android:
        return const BouncingScrollPhysics();
      case TargetPlatform.fuchsia:
      case TargetPlatform.linux:
      case TargetPlatform.windows:
        return const ClampingScrollPhysics();
    }
    return null;
  }
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  ThemeProvider _themeProvider = ThemeProvider();

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
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => BottomNavBarProvider()),
        ChangeNotifierProvider(create: (context) => _themeProvider),
      ],
      child: Consumer<ThemeProvider>(
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
          builder: (context, widget) {
            return ScrollConfiguration(
                behavior: ScrollBehaviorModified(), child: widget);
          },
          initialRoute: "/splashScreen",
          routes: {
            "/": (context) => LoginView(),
            "/mainView": (context) => Dashboard(),
            "/splashScreen": (context) => SplashScreen(),
            "/signUp": (context) => SignUpView(),
            "/emailNotVerified": (context) => EmailNotVerfied(),
            "/forgotPassword": (context) => ForgotPasswordView(),
            "/profile": (context) => ProfileView(),
            "/editProfile": (context) => EditProfileView(),
            "/deleteAccount": (context) => DeleteAccountView(),
            "/changePassword": (context) => ChangePasswordView(),
            "/changeEmail": (context) => ChangeEmailView(),
            "/phoneVerify": (context) => PhoneVerificationView(),
            "/chat": (context) => ChatView(),
            "/subscriptionHistory": (context) => SubscriptionHistoryView(),
            "/account": (context) => AccountView(),
            "/notifications": (context) => NotificationView(),
            "/help": (context) => HelpView(),
            "/settings": (context) => SettingsView(),
            "/theme": (context) => ThemeView(),
            "/faq": (context) => FAQView(),
            "/appInfo": (context) => AppInfo(),
            '/inApp': (context) => InAppGuideView(),
            "/reportProblem": (context) => ReportProblemView(),
            "/disableAccount": (context) => DisableAccountRequestView(),
            "/privacyPolicy": (context) => PrivacyPolicy(),
            "/favorite": (context) => FavoriteView(),
            '/twitterView': (context) => TwitterMarketingView(),
            '/linkedInView': (context) => LinkedinMarketingView(),
          },
        ),
      ),
    );
  }
}
