import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class DetailPerson extends StatelessWidget {
  const DetailPerson({
    super.key,
    required this.icon,
    required this.title,
    required this.value,
  });

  final IconData icon;
  final String title;
  final String value;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(
        icon,
        color: const Color.fromARGB(255, 158, 23, 13),
        size: 40,
      ),
      title: Text(
        title,
        style: GoogleFonts.openSans(
          color: const Color.fromARGB(255, 158, 23, 13),
        ),
      ),
      subtitle: Text(
        value,
        style: GoogleFonts.openSans(
          fontSize: 18,
        ),
      ),
    );
  }
}
