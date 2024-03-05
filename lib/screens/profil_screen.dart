import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:sps_mobile/screens/profil_creation.dart';
import 'package:sps_mobile/services/authentication.dart';
import 'package:sps_mobile/services/firestore_service.dart';
import 'package:sps_mobile/widgets/detail_person.dart';

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
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 0),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            OutlinedButton(
              style: OutlinedButton.styleFrom(
                side: const BorderSide(
                  width: 2,
                  color: Color.fromARGB(255, 158, 23, 13),
                ),
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
                  Icon(
                    Icons.edit,
                    color: Color.fromARGB(255, 158, 23, 13),
                  ),
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
                  DetailPerson(
                      icon: Icons.person,
                      title: 'Nom',
                      value: nom ?? 'Inconnu'),
                  DetailPerson(
                      icon: Icons.person,
                      title: 'Prénom',
                      value: prenom ?? 'Inconnu'),
                  DetailPerson(
                      icon: Icons.calendar_month,
                      title: 'Date de naissance',
                      value: date ?? 'Inconnu'),
                  DetailPerson(
                      icon: Icons.female_rounded,
                      title: 'Sexe',
                      value: sexe ?? 'Inconnu'),
                  DetailPerson(
                      icon: Icons.bloodtype_rounded,
                      title: 'Groupe sanguin',
                      value: sang ?? 'Inconnu'),
                  DetailPerson(
                      icon: Icons.email_outlined,
                      title: 'Email',
                      value: FirebaseAuth.instance.currentUser!.email!),
                ],
              ),
            ),
            const SizedBox(height: 20),
            Center(
              child: ElevatedButton.icon(
                onPressed: () async {
                  await Authentication().signOut();
                },
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size(200, 50),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  backgroundColor: const Color.fromARGB(255, 158, 23, 13),
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
