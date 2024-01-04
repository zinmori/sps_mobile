import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sps_mobile/screens/login.dart';
import 'package:sps_mobile/screens/sign_up.dart';

class Auth extends StatelessWidget {
  const Auth({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        //crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image.asset(
            'assets/images/blood1.png',
            height: 300,
            width: double.infinity,
          ),
          const SizedBox(height: 30),
          Padding(
            padding: const EdgeInsets.all(10),
            child: Text(
              'Prêt à rejoindre la communauté des donneurs ?',
              textAlign: TextAlign.left,
              style: GoogleFonts.roboto(
                textStyle: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          const SizedBox(height: 50),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
              elevation: 5,
              minimumSize: const Size(200, 50),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
              ),
            ),
            onPressed: () {
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(
                  builder: (ctx) => const SignUp(),
                ),
              );
            },
            child: Text(
              'S\'inscrire',
              style: GoogleFonts.roboto(
                textStyle: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          ),
          const SizedBox(height: 20),
          OutlinedButton(
            onPressed: () {
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(
                  builder: (ctx) => const Login(),
                ),
              );
            },
            style: OutlinedButton.styleFrom(
              side: const BorderSide(width: 2, color: Colors.red),
              minimumSize: const Size(200, 50),
            ),
            child: Text(
              'Se connecter',
              style: GoogleFonts.roboto(
                textStyle: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.red,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
