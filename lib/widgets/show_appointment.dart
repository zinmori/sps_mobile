import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sps_mobile/services/firestore_service.dart';
import 'package:sps_mobile/widgets/alarm.dart';
import 'package:url_launcher/url_launcher.dart';

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
  late List<Map<String, dynamic>> centres = [];
  setData() async {
    final data = await CentreService().getCentres();
    setState(() {
      centres = data.docs.map((e) => e.data() as Map<String, dynamic>).toList();
    });
  }

  @override
  void initState() {
    super.initState();
    setData();
  }

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
              child: const Text('NON',
                  style: TextStyle(color: Color.fromARGB(255, 158, 23, 13))),
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
              child: const Text('OUI',
                  style: TextStyle(color: Color.fromARGB(255, 158, 23, 13))),
            ),
          ],
        );
      },
    );
  }

  void planifierRappel(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isDismissible: false,
      builder: (BuildContext context) {
        return Alarm(date: widget.date.toLocal().toString().split(' ')[0]);
      },
    );
  }

  _launchGoogleMaps(String centre) async {
    final url = centres.firstWhere(
        (centre) => centre['nom'] as String == widget.centre)['location'];

    await launchUrl(
      Uri.parse(url),
      mode: LaunchMode.inAppBrowserView,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Image.asset(
          'assets/images/back.png',
          width: double.infinity,
          height: double.infinity,
          fit: BoxFit.cover,
        ),
        Positioned(
          top: 100,
          left: MediaQuery.of(context).size.width / 2 - 50,
          child: IconButton(
            onPressed: () {
              _launchGoogleMaps(widget.centre);
            },
            icon: const Icon(
              Icons.location_on_outlined,
              size: 100,
              color: Color.fromARGB(255, 158, 23, 13),
            ),
          ),
        ),
        Positioned(
          left: 10,
          right: 10,
          bottom: 20,
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: Colors.red[50],
              boxShadow: const [
                BoxShadow(
                  color: Colors.black54,
                  blurRadius: 10,
                  offset: Offset(0, 0),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                IconButton(
                  onPressed: () {
                    planifierRappel(context);
                  },
                  icon: const Icon(
                    Icons.alarm_rounded,
                    size: 50,
                    color: Color.fromARGB(255, 158, 23, 13),
                  ),
                ),
                Row(
                  children: [
                    const SizedBox(width: 20),
                    const Icon(
                      Icons.location_on_rounded,
                      size: 50,
                      color: Color.fromARGB(255, 158, 23, 13),
                    ),
                    const SizedBox(width: 20),
                    Expanded(
                      child: Text(
                        widget.centre,
                        style: GoogleFonts.openSans(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                Row(
                  children: [
                    const SizedBox(width: 20),
                    const Icon(
                      Icons.calendar_month_rounded,
                      size: 50,
                      color: Color.fromARGB(255, 158, 23, 13),
                    ),
                    const SizedBox(width: 20),
                    Text(
                      widget.date.toLocal().toString().split(' ')[0],
                      style: GoogleFonts.openSans(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 15),
                Center(
                  child: IconButton(
                    onPressed: _showDeleteDialog,
                    icon: const Icon(
                      Icons.delete_outline_rounded,
                      size: 50,
                      color: Color.fromARGB(255, 158, 23, 13),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
