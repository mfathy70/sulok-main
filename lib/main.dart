import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get/get.dart';
import 'package:sulok/constant/global_functions.dart';
import 'package:sulok/screens/splash/splash_screen.dart';
import 'constant/app_colors.dart';
import 'helper/notification_config.dart';

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  securePrint('BACK GROUND MESSAGING HANDLER');
  showFlutterNotification(message);
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  await setupFlutterNotifications();
  await initialFireBaseMessages();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScopeNode currentFocus = FocusScope.of(context);
        if (!currentFocus.hasPrimaryFocus &&
            currentFocus.focusedChild != null) {
          FocusManager.instance.primaryFocus!.unfocus();
        }
      },
      child: GetMaterialApp(
          debugShowCheckedModeBanner: false,
          locale: const Locale("ar"),
          fallbackLocale: const Locale('ar'),
          localizationsDelegates: const [
            GlobalMaterialLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate
          ],
          theme: ThemeData(
              scaffoldBackgroundColor: AppColors.greenMain,
              fontFamily: 'IBMPlexSans'),
          supportedLocales: const [Locale('ar'), Locale('en')],
          home: const SplashScreen()),
    );
  }
}
