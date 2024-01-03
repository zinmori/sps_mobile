import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sps_mobile/screens/login.dart';
import 'package:sps_mobile/screens/profil_creation.dart';

class SignUp extends StatelessWidget {
  const SignUp({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Bienvenue !',
              style: GoogleFonts.openSans(
                textStyle: const TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: 10),
            Text('Inscrivez-vous pour rejoindre les donneurs.',
                style: GoogleFonts.openSans()),
            const SizedBox(height: 80),
            Container(
              width: 300,
              height: 60,
              decoration: BoxDecoration(
                border: Border.all(
                  width: 2,
                ),
                borderRadius: BorderRadius.circular(20),
              ),
              child: const Padding(
                padding: EdgeInsets.all(8.0),
                child: TextField(
                  cursorColor: Colors.red,
                  decoration: InputDecoration(
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
              child: const Padding(
                padding: EdgeInsets.all(8.0),
                child: TextField(
                  cursorColor: Colors.red,
                  decoration: InputDecoration(
                      icon: Icon(
                        Icons.lock_outline_rounded,
                        size: 40,
                        color: Colors.red,
                      ),
                      hintText: 'Mot de passe',
                      border: InputBorder.none),
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
              child: const Padding(
                padding: EdgeInsets.all(8.0),
                child: TextField(
                  cursorColor: Colors.red,
                  decoration: InputDecoration(
                      icon: Icon(
                        Icons.lock_outline_rounded,
                        size: 40,
                        color: Colors.red,
                      ),
                      hintText: 'Confirmez votre mot de passe',
                      border: InputBorder.none),
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
                onPressed: () {
                  Navigator.of(context).pushReplacement(
                    MaterialPageRoute(
                      builder: (ctx) => const ProfilCreation(),
                    ),
                  );
                },
                child: Text(
                  'S\'inscrire',
                  style: GoogleFonts.openSans(
                    textStyle: const TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                    ),
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
                    onPressed: () {
                      Navigator.of(context).pushReplacement(
                        MaterialPageRoute(
                          builder: (ctx) => const ProfilCreation(),
                        ),
                      );
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
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text('Vous avez déja un compte ?'),
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pushReplacement(
                      MaterialPageRoute(
                        builder: (ctx) => const Login(),
                      ),
                    );
                  },
                  child: const Text(
                    'Se connecter',
                    style: TextStyle(color: Colors.red),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
