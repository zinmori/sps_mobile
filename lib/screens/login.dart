//import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
//import 'package:sps_mobile/screens/main_page.dart';
//import 'package:sps_mobile/screens/tabs.dart';
//import 'package:sps_mobile/screens/tabs.dart';
import 'package:sps_mobile/services/authentication.dart';
//import 'package:sps_mobile/screens/sign_up.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Connectez - vous',
              style: GoogleFonts.openSans(
                fontSize: 30,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 100),
            Container(
              width: 300,
              height: 60,
              decoration: BoxDecoration(
                border: Border.all(
                  width: 2,
                ),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  controller: emailController,
                  onTapOutside: (event) => FocusScope.of(context).unfocus(),
                  cursorColor: Colors.red,
                  decoration: const InputDecoration(
                    icon: Icon(
                      Icons.mail_outline,
                      size: 40,
                      color: Colors.red,
                    ),
                    hintText: 'Email',
                    border: InputBorder.none,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
            Container(
              width: 300,
              height: 60,
              decoration: BoxDecoration(
                border: Border.all(
                  width: 2,
                ),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  controller: passwordController,
                  onTapOutside: (event) => FocusScope.of(context).unfocus(),
                  obscureText: true,
                  cursorColor: Colors.red,
                  decoration: const InputDecoration(
                    icon: Icon(
                      Icons.lock_outline_rounded,
                      size: 40,
                      color: Colors.red,
                    ),
                    hintText: 'Mot de passe',
                    border: InputBorder.none,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 30),
            Container(
              width: 180,
              height: 50,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Colors.red,
              ),
              child: TextButton(
                onPressed: () async {
                  await Authentication().signInWithEmailAndPassword(
                    emailController.text,
                    passwordController.text,
                    context,
                  );
                },
                child: Text(
                  'Se connecter',
                  style: GoogleFonts.openSans(
                    textStyle:
                        const TextStyle(color: Colors.white, fontSize: 20),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
            const Text('ou'),
            const SizedBox(height: 20),
            Container(
              width: 300,
              height: 50,
              decoration: BoxDecoration(
                border: Border.all(
                  width: 2,
                ),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Image.asset(
                      'assets/images/google.png',
                      height: 40,
                      width: 40,
                    ),
                  ),
                  const SizedBox(width: 20),
                  TextButton(
                    onPressed: () async {
                      await Authentication().signInWithGoogle(context);
                    },
                    child: Text(
                      'Continuez avec Google',
                      style: GoogleFonts.openSans(
                        textStyle:
                            const TextStyle(color: Colors.black, fontSize: 16),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
