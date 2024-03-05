import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sps_mobile/services/firestore_service.dart';
import 'package:sps_mobile/widgets/urgence_item.dart';

class UrgenceScreen extends StatelessWidget {
  const UrgenceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: UrgenceService().getUrgences(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (snapshot.hasError) {
            return Center(
              child: Text(
                'Erreur de connexion',
                style: GoogleFonts.openSans(
                    fontWeight: FontWeight.w600, fontSize: 20),
              ),
            );
          }
          if (snapshot.data!.docs.isEmpty) {
            return Center(
              child: Text(
                'Aucune urgence trouvée !',
                style: GoogleFonts.openSans(
                    fontWeight: FontWeight.w600, fontSize: 20),
              ),
            );
          }
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 0),
            child: Column(
              children: [
                Expanded(
                  child: ListView.builder(
                      itemCount: snapshot.data!.docs.length,
                      itemBuilder: (context, index) {
                        return UrgenceItem(
                          centre:
                              snapshot.data!.docs[index]["centre"] as String,
                          sang: snapshot.data!.docs[index]["groupe"] as String,
                        );
                      }),
                )
              ],
            ),
          );
        });
  }
}
