import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class HistoItem extends StatelessWidget {
  const HistoItem({
    super.key,
    required this.centre,
    required this.date,
  });
  final String date;
  final String centre;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Card(
        elevation: 10,
        surfaceTintColor: Colors.white,
        child: Row(
          children: [
            Image.asset(
              'assets/images/gouttesang.png',
              height: 100,
            ),
            const SizedBox(width: 50),
            Column(
              children: [
                Text(
                  date,
                  style: GoogleFonts.openSans(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  centre,
                  style: GoogleFonts.openSans(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
