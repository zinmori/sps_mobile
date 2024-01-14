import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:sps_mobile/screens/main_page.dart';
//import 'package:sps_mobile/screens/profil_creation.dart';
//import 'package:sps_mobile/screens/tabs.dart';

class VerifyEmail extends StatefulWidget {
  const VerifyEmail({super.key});

  @override
  State<VerifyEmail> createState() => _VerifyEmailState();
}

class _VerifyEmailState extends State<VerifyEmail> {
  bool isEmailVerified = false;
  bool canResendEmail = false;
  Timer? timer;

  @override
  void initState() {
    super.initState();
    isEmailVerified = FirebaseAuth.instance.currentUser!.emailVerified;
    if (!isEmailVerified) {
      sendVerificationEmail();

      timer = Timer.periodic(const Duration(seconds: 3), (timer) {
        checkEmailVerified();
      });
    }
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  Future checkEmailVerified() async {
    await FirebaseAuth.instance.currentUser!.reload();
    setState(() {
      isEmailVerified = FirebaseAuth.instance.currentUser!.emailVerified;
    });
    if (isEmailVerified) {
      timer?.cancel();
    }
  }

  Future sendVerificationEmail() async {
    try {
      final user = FirebaseAuth.instance.currentUser!;
      await user.sendEmailVerification();
      setState(() {
        canResendEmail = false;
      });
      await Future.delayed(const Duration(seconds: 5));
      setState(() {
        canResendEmail = true;
      });
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            e.toString(),
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return isEmailVerified
        ? const MainPage()
        : Scaffold(
            appBar: AppBar(
              title: const Text(
                'Verify your email',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            body: Center(
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'A verification email has been sent to your email : ${FirebaseAuth.instance.currentUser!.email}',
                      style: const TextStyle(fontSize: 20),
                    ),
                    ElevatedButton.icon(
                      onPressed: canResendEmail ? sendVerificationEmail : null,
                      icon: const Icon(Icons.mail_outline_rounded),
                      label: const Text('Resend email'),
                    ),
                    Column(children: [
                      const Text('Vous vous etes trompé d\'email ?'),
                      const SizedBox(height: 10),
                      TextButton(
                        onPressed: () {},
                        child: const Text(
                          'Revenir á la page de conneion.',
                          style: TextStyle(color: Colors.red),
                        ),
                      )
                    ])
                  ],
                ),
              ),
            ),
          );
  }
}
