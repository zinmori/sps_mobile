import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sps_mobile/screens/auth.dart';
import 'package:sps_mobile/screens/profil_creation.dart';

class ProfilScreen extends StatelessWidget {
  const ProfilScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          const SizedBox(height: 50),
          OutlinedButton(
            style: OutlinedButton.styleFrom(
              side: const BorderSide(width: 2, color: Colors.red),
            ),
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (ctx) => const ProfilCreation(),
                ),
              );
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
          SingleChildScrollView(
            child: Container(
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
                    subtitle:
                        const Text('Lawliet', style: TextStyle(fontSize: 18)),
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
                    subtitle:
                        const Text('BigZ', style: TextStyle(fontSize: 18)),
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
                    subtitle: const Text('2004-05-28',
                        style: TextStyle(fontSize: 18)),
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
                    subtitle:
                        const Text('Masculin', style: TextStyle(fontSize: 18)),
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
                    subtitle: const Text('O+', style: TextStyle(fontSize: 18)),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 20),
          Center(
            child: ElevatedButton.icon(
              onPressed: () {
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(
                    builder: (ctx) => const Auth(),
                  ),
                );
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
    );
  }
}
