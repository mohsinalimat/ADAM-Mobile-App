import 'package:adam/app_routes.dart';
import 'package:adam/model/service/service.dart';
import 'package:adam/model/service/service_comment.dart';
import 'package:adam/model/service/service_type.dart';
import 'package:adam/model/service/services_list.dart';
import 'package:adam/model/subscribed_services/subscribed_services.dart';
import 'package:adam/model/subscribed_services/subscribed_services_list.dart';
import 'package:adam/views/chat/webview_chat.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'utils/main_imports.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: '.env');
  await Firebase.initializeApp();

  // hive
  await Hive.initFlutter();

  // hive adapter
  Hive.registerAdapter<SubscribedServices>(SubscribedServicesAdapter());
  Hive.registerAdapter<SubscribedService>(SubscribedServiceAdapter());
  Hive.registerAdapter<Service>(ServiceAdapter());
  Hive.registerAdapter<ServiceType>(ServiceTypeAdapter());
  Hive.registerAdapter<ServiceComment>(ServiceCommentAdapter());
  Hive.registerAdapter<ServicesList>(ServicesListAdapter());
  // hive box
  await Hive.openBox('subscribedServices');

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
            AppRoutes.forgotPassword: (context) => ForgotPasswordView(),
            AppRoutes.deleteAccount: (context) => DeleteAccountView(),
            AppRoutes.changePassword: (context) => ChangePasswordView(),
            AppRoutes.changeEmail: (context) => ChangeEmailView(),
            AppRoutes.chat: (context) => ChatView(),
            AppRoutes.chatWeb: (context) => ChatWebView(),
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
