import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:sps_mobile/screens/start_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Future.delayed(const Duration(seconds: 2));
  FlutterNativeSplash.remove();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(
    MaterialApp(
      theme: ThemeData().copyWith(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.red),
        useMaterial3: true,
        navigationBarTheme: const NavigationBarThemeData().copyWith(
          labelTextStyle: MaterialStateProperty.resolveWith<TextStyle?>(
            (states) => const TextStyle(
              color: Colors.red,
            ),
          ),
        ),
      ),
      home: const StartScreen(),
    ),
  );
}
