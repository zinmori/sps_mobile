import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ResetPassword extends StatefulWidget {
  const ResetPassword({super.key});

  @override
  State<ResetPassword> createState() => _ResetPasswordState();
}

class _ResetPasswordState extends State<ResetPassword> {
  TextEditingController emailController = TextEditingController();

  Future<void> resetPassword() async {
    try {
      await FirebaseAuth.instance
          .sendPasswordResetEmail(email: emailController.text.trim());
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              'Un email de réinitialisation a été envoyé à ${emailController.text}.',
            ),
          ),
        );
        Navigator.of(context).popUntil((route) => route.isFirst);
      }
    } on FirebaseAuthException catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content:
                Text(e.message ?? 'Something went wrong. Please try again.'),
          ),
        );
        Navigator.of(context).pop();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Réinitialiser le mot de passe'),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
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
                      hintStyle: TextStyle(
                        color: Colors.grey,
                        fontSize: 20,
                      ),
                      border: InputBorder.none,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () async {
                  if (emailController.text.isNotEmpty) {
                    showDialog(
                      context: context,
                      barrierDismissible: false,
                      builder: (ctx) => const Center(
                        child: CircularProgressIndicator(),
                      ),
                    );
                    await resetPassword();
                  }
                },
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  minimumSize: const Size(300, 60),
                ),
                child: const Text('Envoyer'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
