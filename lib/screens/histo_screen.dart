import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sps_mobile/services/firestore_service.dart';
import 'package:sps_mobile/widgets/histo_item.dart';

class HistoScreen extends StatelessWidget {
  const HistoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: PlanningService().getPlannings(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text('Erreur : ${snapshot.error}'),
            );
          } else if (snapshot.hasData && snapshot.data!.size == 0) {
            return const Center(
              child: Text('Aucun don effectué', style: TextStyle(fontSize: 20)),
            );
          } else {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 0),
              child: Column(
                children: [
                  Expanded(
                    child: ListView.builder(
                      itemCount: snapshot.data!.size,
                      itemBuilder: (context, index) {
                        return HistoItem(
                          date: DateTime.fromMillisecondsSinceEpoch(
                                  snapshot.data!.docs[index]["date"].seconds *
                                      1000)
                              .toString()
                              .split(' ')[0],
                          centre:
                              snapshot.data!.docs[index]["centre"] as String,
                        );
                      },
                    ),
                  ),
                  Text(
                    'Vous avez fait au total : ${snapshot.data!.size} dons',
                    style: GoogleFonts.openSans(
                        fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            );
          }
        });
  }
}
