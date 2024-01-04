import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sps_mobile/data/histos.dart';
import 'package:sps_mobile/widgets/histo_item.dart';

class HistoScreen extends StatelessWidget {
  const HistoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: histos.length,
              itemBuilder: (context, index) {
                return HistoItem(
                  date: histos[index]["date"] as String,
                  centre: histos[index]["centre"] as String,
                );
              },
            ),
          ),
          Text(
            'Vous avez fait au total : ${histos.length} dons',
            style:
                GoogleFonts.openSans(fontSize: 20, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}
