import 'package:flutter/material.dart';
import 'package:sps_mobile/screens/login.dart';
import 'package:sps_mobile/screens/sign_up.dart';

class Auth extends StatefulWidget {
  const Auth({super.key, required this.signIn});

  final bool signIn;

  @override
  State<Auth> createState() {
    return _AuthState();
  }
}

class _AuthState extends State<Auth> {
  bool signIn = true;
  @override
  void initState() {
    super.initState();
    signIn = widget.signIn;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            signIn ? const Login() : const SignUp(),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                signIn
                    ? const Text('Vous n\'avez pas de compte ?')
                    : const Text('Vous avez deja un compte ?'),
                signIn
                    ? TextButton(
                        onPressed: () {
                          setState(() {
                            signIn = false;
                          });
                        },
                        child: const Text(
                          'S\'inscrire',
                          style: TextStyle(color: Colors.red),
                        ),
                      )
                    : TextButton(
                        onPressed: () {
                          setState(() {
                            signIn = true;
                          });
                        },
                        child: const Text(
                          'Connectez vous',
                          style: TextStyle(color: Colors.red),
                        ),
                      )
              ],
            )
          ],
        ),
      ),
    );
  }
}
