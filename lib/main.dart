import 'package:adam/app_routes.dart';
import 'package:adam/custom_scroll_effect.dart';
import 'package:adam/views/settings/help/in_app_guide_view.dart';

import 'utils/main_imports.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: '.env');
  // await Firebase.initializeApp();
  runApp(MyApp());
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
          initialRoute: AppRoutes.splash,
          routes: <String, WidgetBuilder>{
            AppRoutes.splash: (context) => SplashScreen(),
            AppRoutes.login: (context) => LoginView(),
            AppRoutes.dashboard: (context) => Dashboard(),
            AppRoutes.signUp: (context) => SignUpView(),
            AppRoutes.emailNotVerified: (context) => EmailNotVerfied(),
            AppRoutes.forgotPassword: (context) => ForgotPasswordView(),
            AppRoutes.deleteAccount: (context) => DeleteAccountView(),
            AppRoutes.changePassword: (context) => ChangePasswordView(),
            AppRoutes.changeEmail: (context) => ChangeEmailView(),
            AppRoutes.chat: (context) => ChatView(),
            AppRoutes.subscriptionHistory: (context) =>
                SubscriptionHistoryView(),
            AppRoutes.account: (context) => AccountView(),
            AppRoutes.notifications: (context) => NotificationView(),
            AppRoutes.help: (context) => HelpView(),
            AppRoutes.theme: (context) => ThemeView(),
            AppRoutes.faq: (context) => FAQView(),
            AppRoutes.appInfo: (context) => AppInfo(),
            AppRoutes.inApp: (context) => InAppGuideView(),
            AppRoutes.reportProblem: (context) => ReportProblemView(),
            AppRoutes.disableAccount: (context) => DisableAccountRequestView(),
            AppRoutes.privacyPolicy: (context) => PrivacyPolicy(),
            AppRoutes.favorite: (context) => FavoriteView(),
          },
        ),
      ),
    );
  }
}
