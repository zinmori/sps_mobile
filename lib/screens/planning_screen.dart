import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sps_mobile/services/firestore_service.dart';
import 'package:sps_mobile/widgets/show_appointment.dart';
import 'package:sps_mobile/widgets/schedule.dart';

class PlanningScreen extends StatefulWidget {
  const PlanningScreen({super.key});

  @override
  State<PlanningScreen> createState() {
    return _PlanningScreenState();
  }
}

class _PlanningScreenState extends State<PlanningScreen> {
  bool hasAppointment = false;

  Future<void> _showVerificationDialog(DateTime date) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Confirmation'),
          backgroundColor: Colors.white,
          surfaceTintColor: Colors.white,
          content: Text(
            'La date programmée précédemment est déjà passée avez vous honoré votre engagement ?',
            style: GoogleFonts.openSans(
              textStyle: const TextStyle(fontSize: 18),
            ),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () async {
                Navigator.of(context).pop();
                showDialog<void>(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      content: Text(
                        'Ce n\'est pas grave, vous pouvez toujours programmer un nouveau don.',
                        style: GoogleFonts.openSans(
                          textStyle: const TextStyle(fontSize: 18),
                        ),
                      ),
                    );
                  },
                );
                await PlanningService().updatePlanning(
                  FirebaseAuth.instance.currentUser!.uid +
                      date.toLocal().toString().split(' ')[0],
                  {'honore': false},
                );
              },
              child: const Text(
                'NON, je n\'ai pas pu',
                style: TextStyle(color: Colors.red),
              ),
            ),
            ElevatedButton(
              onPressed: () async {
                Navigator.of(context).pop();
                showDialog<void>(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      content: Row(
                        children: [
                          Image.asset(
                            'assets/images/superblood.png',
                            width: 60,
                          ),
                          Text(
                            'Continuez comme ça !',
                            style: GoogleFonts.openSans(
                              textStyle: const TextStyle(
                                color: Colors.red,
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                );
                await PlanningService().updatePlanning(
                  FirebaseAuth.instance.currentUser!.uid +
                      date.toLocal().toString().split(' ')[0],
                  {'honore': true},
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

  Future checkAppointment() async {
    final planning = await PlanningService().getLastPlanning().first;
    if (planning.docs.isEmpty) {
      return;
    } else {
      Map<String, dynamic> planningData =
          planning.docs[0].data() as Map<String, dynamic>;
      DateTime date = planningData['date'].toDate();
      if (DateTime.now().isAfter(date.add(const Duration(days: 1))) &&
          planningData['honore'] == null) {
        _showVerificationDialog(date);
      }
    }
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      checkAppointment();
    });
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: PlanningService().getLastPlanning(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Erreur : ${snapshot.error}'));
        } else if (snapshot.hasData &&
            snapshot.data != null &&
            snapshot.data!.docs.isNotEmpty) {
          Map<String, dynamic> planning =
              snapshot.data!.docs[0].data() as Map<String, dynamic>;
          DateTime planningDate = planning['date'].toDate();
          if (DateTime.now().isBefore(
            planningDate.add(const Duration(days: 1)),
          )) {
            return ShowAppointment(
              date: planningDate,
              centre: planning['centre'],
            );
          } else {
            return const Schedule();
          }
        } else {
          return const Schedule();
        }
      },
    );
  }
}
