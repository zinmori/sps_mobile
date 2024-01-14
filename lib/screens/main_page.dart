import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:sps_mobile/screens/auth.dart';
import 'package:sps_mobile/screens/tabs.dart';
import 'package:sps_mobile/screens/verify_email.dart';

class MainPage extends StatelessWidget {
  const MainPage({super.key, this.signIn = true});
  final bool signIn;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (ctx, userSnapshot) {
          if (userSnapshot.hasData && userSnapshot.data!.emailVerified ||
              userSnapshot.hasData &&
                  userSnapshot.data!.providerData[0].providerId ==
                      'google.com') {
            return const Tabs();
          } else if (userSnapshot.hasData &&
              !userSnapshot.data!.emailVerified) {
            return const VerifyEmail();
          } else {
            return Auth(signIn: signIn);
          }
        },
      ),
    );
  }
}
