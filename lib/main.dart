import 'package:audioroom/screen/sign_module/splash_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:audioroom/helper/constants.dart';

final navigatorKey = GlobalKey<NavigatorState>();

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(new MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
        statusBarColor: AppConstants.clrWhite,
        statusBarIconBrightness: Brightness.dark,
        systemNavigationBarIconBrightness: Brightness.dark,
        statusBarBrightness: Brightness.dark));
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      color: AppConstants.clrWhite,
      title: AppConstants.str_app_name,
      navigatorKey: navigatorKey,
      theme: ThemeData(
          primaryColor: AppConstants.clrWhite,
          primaryColorDark: AppConstants.clrWhite,
          accentColor: AppConstants.clrBlack,
          brightness: Brightness.light,
          scaffoldBackgroundColor: AppConstants.clrWhite,
          fontFamily: AppConstants.fontGothic),
      home: SplashScreen(),
    );
  }
}
