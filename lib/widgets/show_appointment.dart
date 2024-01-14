import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sps_mobile/services/firestore_service.dart';

class ShowAppointment extends StatefulWidget {
  const ShowAppointment({
    super.key,
    required this.date,
    required this.centre,
  });

  final DateTime date;
  final String centre;

  @override
  State<ShowAppointment> createState() => _ShowAppointmentState();
}

class _ShowAppointmentState extends State<ShowAppointment> {
  Future<void> _showDeleteDialog() async {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Confirmation'),
          backgroundColor: Colors.white,
          surfaceTintColor: Colors.white,
          content: const Text('Voulez vous vraiment annuler votre programme ?'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('NON', style: TextStyle(color: Colors.red)),
            ),
            ElevatedButton(
              onPressed: () async {
                Navigator.of(context).pop();
                await PlanningService().deletePlanning(
                  FirebaseAuth.instance.currentUser!.uid +
                      widget.date.toLocal().toString().split(' ')[0],
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                surfaceTintColor: Colors.white,
              ),
              child: const Text('OUI', style: TextStyle(color: Colors.red)),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Column(
        children: [
          Text(
            'Votre prochain don est planifié sur le :',
            textAlign: TextAlign.center,
            style: GoogleFonts.openSans(
                textStyle: const TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.bold,
            )),
          ),
          const SizedBox(height: 100),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.date_range_rounded,
                color: Colors.red,
                size: 100,
              ),
              const SizedBox(width: 10),
              Text(
                widget.date.toLocal().toString().split(' ')[0],
                style: const TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(height: 30),
          const Text(
            'à',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
          ),
          const SizedBox(height: 30),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.location_on,
                color: Colors.red,
                size: 100,
              ),
              const SizedBox(width: 10),
              Text(
                widget.centre,
                style: const TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(height: 30),
          IconButton.filled(
            onPressed: _showDeleteDialog,
            highlightColor: Colors.red,
            icon: const Icon(
              Icons.delete_outline_rounded,
              color: Colors.white,
              size: 50,
            ),
          )
        ],
      ),
    );
  }
}
