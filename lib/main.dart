import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sps_mobile/screens/start_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:sps_mobile/services/notification_service.dart';
import 'package:timezone/data/latest_all.dart' as tz;
import 'firebase_options.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Future.delayed(const Duration(seconds: 2));
  FlutterNativeSplash.remove();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  NotificationService().initNotification();
  NotificationService().initUrgenceNotification();
  tz.initializeTimeZones();
  runApp(
    ProviderScope(
      child: MaterialApp(
        theme: ThemeData().copyWith(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.red),
          useMaterial3: true,
          navigationBarTheme: const NavigationBarThemeData().copyWith(
            labelTextStyle: MaterialStateProperty.resolveWith<TextStyle?>(
              (states) => const TextStyle(
                color: Color.fromARGB(255, 158, 23, 13),
              ),
            ),
          ),
        ),
        home: const StartScreen(),
      ),
    ),
  );
}
