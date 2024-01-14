//import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
//import 'package:sps_mobile/screens/main_page.dart';
import 'package:sps_mobile/screens/profil_creation.dart';
import 'package:sps_mobile/services/authentication.dart';
import 'package:sps_mobile/services/firestore_service.dart';

class ProfilScreen extends StatefulWidget {
  const ProfilScreen({super.key});

  @override
  State<ProfilScreen> createState() => _ProfilScreenState();
}

class _ProfilScreenState extends State<ProfilScreen> {
  String? nom;
  String? prenom;
  String? date;
  String? sexe;
  String? sang;

  setData() async {
    final userDoc = await UserService().getUser();
    Map<String, dynamic> data = userDoc.data()! as Map<String, dynamic>;
    setState(() {
      nom = data['nom'];
      prenom = data['prenom'];
      date = data['date_naissance'] == null
          ? 'Inconnu'
          : DateTime.fromMillisecondsSinceEpoch(
                  data['date_naissance'].seconds * 1000)
              .toString()
              .split(' ')[0];
      sexe = data['sexe'];
      sang = data['groupe_sanguin'];
    });
  }

  @override
  void initState() {
    super.initState();
    setData();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            //const SizedBox(height: 50),
            OutlinedButton(
              style: OutlinedButton.styleFrom(
                side: const BorderSide(width: 2, color: Colors.red),
              ),
              onPressed: () async {
                Map<String, dynamic> newData = await Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (ctx) => const ProfilCreation(),
                  ),
                );
                setState(() {
                  nom = newData['nom'];
                  prenom = newData['prenom'];
                  date = newData['date_naissance'];
                  sexe = newData['sexe'];
                  sang = newData['groupe_sanguin'];
                });
              },
              child: const Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.edit, color: Colors.red),
                  Text('Modifier'),
                ],
              ),
            ),
            const SizedBox(height: 20),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Colors.red[50],
              ),
              child: Column(
                children: [
                  ListTile(
                    leading: const Icon(
                      Icons.person,
                      color: Colors.red,
                      size: 40,
                    ),
                    title: Text(
                      'Nom',
                      style: GoogleFonts.openSans(
                        color: Colors.red,
                      ),
                    ),
                    subtitle: Text(nom ?? 'Inconnu',
                        style: const TextStyle(fontSize: 18)),
                  ),
                  ListTile(
                    leading: const Icon(
                      Icons.person,
                      color: Colors.red,
                      size: 40,
                    ),
                    title: Text(
                      'Prénom',
                      style: GoogleFonts.openSans(color: Colors.red),
                    ),
                    subtitle: Text(prenom ?? 'Inconnu',
                        style: const TextStyle(fontSize: 18)),
                  ),
                  ListTile(
                    leading: const Icon(
                      Icons.calendar_month,
                      color: Colors.red,
                      size: 40,
                    ),
                    title: Text(
                      'Date de naissance',
                      style: GoogleFonts.openSans(color: Colors.red),
                    ),
                    subtitle: Text(date ?? 'Inconnu',
                        style: const TextStyle(fontSize: 18)),
                  ),
                  ListTile(
                    leading: const Icon(
                      Icons.female_rounded,
                      color: Colors.red,
                      size: 40,
                    ),
                    title: Text(
                      'Sexe',
                      style: GoogleFonts.openSans(color: Colors.red),
                    ),
                    subtitle: Text(sexe ?? 'Inconnu',
                        style: const TextStyle(fontSize: 18)),
                  ),
                  ListTile(
                    leading: const Icon(
                      Icons.bloodtype_rounded,
                      color: Colors.red,
                      size: 40,
                    ),
                    title: Text(
                      'Groupe sanguin',
                      style: GoogleFonts.openSans(color: Colors.red),
                    ),
                    subtitle: Text(sang ?? 'Inconnu',
                        style: const TextStyle(fontSize: 18)),
                  ),
                  ListTile(
                    leading: const Icon(
                      Icons.email_outlined,
                      color: Colors.red,
                      size: 40,
                    ),
                    title: Text(
                      'Email',
                      style: GoogleFonts.openSans(color: Colors.red),
                    ),
                    subtitle: Text(FirebaseAuth.instance.currentUser!.email!,
                        style: const TextStyle(fontSize: 18)),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            Center(
              child: ElevatedButton.icon(
                onPressed: () async {
                  await Authentication().signOut();
                  /* Navigator.of(context).pushReplacement(
                        MaterialPageRoute(
                          builder: (ctx) => const MainPage(),
                        ),
                      ); */
                },
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size(200, 50),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  backgroundColor: Colors.red,
                  elevation: 10,
                ),
                icon: const Icon(
                  Icons.exit_to_app_rounded,
                  color: Colors.white,
                  size: 35,
                ),
                label: const Text(
                  'Déconnexion',
                  style: TextStyle(color: Colors.white, fontSize: 18),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
