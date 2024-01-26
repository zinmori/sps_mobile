import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sps_mobile/data/infos.dart';

class InfoDetail extends StatelessWidget {
  const InfoDetail({
    super.key,
    required this.id,
  });
  final int id;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Hero(
              tag: id,
              child: Image.asset(
                infos[id]["image"] as String,
                height: 300,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10),
              child: Text(
                infos[id]["title"] as String,
                style: GoogleFonts.openSans(
                  textStyle: const TextStyle(
                    color: Color.fromARGB(255, 158, 23, 13),
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            const Divider(
              color: Color.fromARGB(255, 158, 23, 13),
              indent: 40,
              endIndent: 40,
              thickness: 2,
            ),
            Padding(
              padding: const EdgeInsets.all(20),
              child: infos[id]["description"] as Widget,
            ),
          ],
        ),
      ),
    );
  }
}
