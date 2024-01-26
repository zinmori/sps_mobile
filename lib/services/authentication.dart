import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:sps_mobile/services/firestore_service.dart';

//import 'package:sps_mobile/services/firestore_service.dart';
//import 'package:sps_mobile/screens/verify_email.dart';
class Authentication {
  Future<UserCredential?> signInWithEmailAndPassword(
    String email,
    String password,
    BuildContext context,
  ) async {
    try {
      if (email.isEmpty || password.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Veuillez remplir tous les champs'),
          ),
        );
        return null;
      }
      showDialog(
        context: context,
        builder: (ctx) => const Center(
          child: CircularProgressIndicator(),
        ),
      );
      final userCredential =
          await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      Navigator.of(context).pop();

      if (userCredential.user != null && !userCredential.user!.emailVerified) {
        return null;
      }

      return userCredential;
    } on FirebaseAuthException catch (e) {
      Navigator.of(context).pop();
      String message = '';
      if (e.code == 'user-not-found' || e.code == 'wrong-password') {
        message = 'Email ou mot de passe incorrect';
      } else {
        message = e.message!;
      }
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(message),
        ),
      );
      return null;
    }
  }

  Future signInWithGoogle(BuildContext context) async {
    try {
      showDialog(
        context: context,
        builder: (context) => const Center(
          child: CircularProgressIndicator(),
        ),
      );
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

      final GoogleSignInAuthentication googleAuth =
          await googleUser!.authentication;

      final OAuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      await FirebaseAuth.instance.signInWithCredential(credential);
      Navigator.of(context).pop();
    } on FirebaseAuthException catch (e) {
      Navigator.of(context).pop();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(e.message!),
        ),
      );
    }
  }

  Future<UserCredential?> signUp(
    String email,
    String password,
    String passwordConfirm,
    BuildContext context,
  ) async {
    try {
      if (email.trim().isEmpty || password.trim().isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Veuillez remplir tous les champs'),
          ),
        );
        return null;
      }
      if (password.length < 6) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content:
                Text('Le mot de passe doit contenir au moins 6 caractères'),
          ),
        );
        return null;
      }
      if (password != passwordConfirm) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Les mots de passe ne correspondent pas'),
          ),
        );
        return null;
      }
      showDialog(
        context: context,
        builder: (context) => const Center(
          child: CircularProgressIndicator(),
        ),
      );
      final userCredential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email.trim(),
        password: password,
      );
      Navigator.of(context).pop();
      await UserService().addUser(
        FirebaseAuth.instance.currentUser!.email,
        null,
        null,
        null,
        null,
        null,
      );
      return userCredential;
    } on FirebaseAuthException catch (e) {
      Navigator.of(context).pop();
      String message = '';
      if (e.code == 'email-already-in-use') {
        message = 'Cet email est déjà utilisé';
      } else if (e.code == 'weak-password') {
        message = 'Le mot de passe doit contenir au moins 6 caractères';
      } else if (e.code == 'invalid-email') {
        message = 'Entrez une adresse email valide';
      } else {
        message = e.message!;
      }
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(message),
        ),
      );
      return null;
    }
  }

  Future signOut() async {
    await FirebaseAuth.instance.signOut();
  }
}
