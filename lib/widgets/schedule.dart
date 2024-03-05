import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sps_mobile/models/planning.dart';
import 'package:sps_mobile/services/firestore_service.dart';

class Schedule extends StatefulWidget {
  const Schedule({super.key});

  @override
  State<Schedule> createState() => _ScheduleState();
}

class _ScheduleState extends State<Schedule> {
  late List<String> centres = ['En cours de chargement...'];
  late String selectedCentre = 'En cours de chargement...';
  TextEditingController dateController = TextEditingController();

  setData() async {
    final data = await CentreService().getCentres();
    setState(() {
      centres = data.docs.map((e) => e['nom'] as String).toList();
      selectedCentre = centres[0];
    });
  }

  @override
  void initState() {
    super.initState();
    setData();
  }

  Future<void> _showConfirmationDialog() async {
    final userDoc = await UserService().getUser();
    Map<String, dynamic> data = userDoc.data()! as Map<String, dynamic>;
    if (mounted) {
      return showDialog<void>(
        context: context,
        builder: (BuildContext context) {
          return data['sexe'] != null
              ? AlertDialog(
                  title: const Text('Confirmation'),
                  backgroundColor: Colors.white,
                  surfaceTintColor: Colors.white,
                  content: SingleChildScrollView(
                    child: ListBody(
                      children: <Widget>[
                        Text(
                          'Votre prochain don est planifié sur le :${dateController.text}',
                        ),
                        const SizedBox(height: 10.0),
                        Text('Centre choisi : $selectedCentre'),
                      ],
                    ),
                  ),
                  actions: <Widget>[
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: const Text(
                        'Annuler',
                        style: TextStyle(color: Colors.red),
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () async {
                        Navigator.of(context).pop();
                        await PlanningService().addPlanning(
                          Planning(
                            user: FirebaseAuth.instance.currentUser!.uid,
                            date: DateTime.parse(dateController.text),
                            centre: selectedCentre,
                            honore: null,
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        surfaceTintColor: Colors.white,
                      ),
                      child: const Text(
                        'Confirmer',
                        style: TextStyle(color: Colors.red),
                      ),
                    ),
                  ],
                )
              : const AlertDialog(
                  backgroundColor: Colors.white,
                  surfaceTintColor: Colors.white,
                  content: SingleChildScrollView(
                    child: Text(
                      'Veuillez completer votre profil avant de planifier votre prochain don',
                    ),
                  ),
                );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text(
            'Planifiez votre prochain don',
            style: GoogleFonts.openSans(
              textStyle: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Color.fromARGB(255, 158, 23, 13),
              ),
            ),
          ),
          const SizedBox(height: 20),
          Image.asset(
            'assets/images/blood-donation.png',
            height: 200,
          ),
          const SizedBox(height: 20),
          Container(
            width: double.infinity,
            height: 60,
            decoration: BoxDecoration(
              border: Border.all(width: 2),
              borderRadius: BorderRadius.circular(20),
            ),
            child: TextField(
              controller: dateController,
              decoration: const InputDecoration(
                icon: Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Icon(
                    Icons.calendar_today,
                    color: Color.fromARGB(255, 158, 23, 13),
                    size: 40,
                  ),
                ),
                labelText: 'Date',
                labelStyle: TextStyle(
                  color: Colors.red,
                ),
                border: InputBorder.none,
              ),
              readOnly: true,
              onTap: () async {
                DateTime nextDate = DateTime.now();
                if (mounted) {
                  DateTime? selectedDate = await showDatePicker(
                    context: context,
                    initialDate: nextDate,
                    firstDate: nextDate,
                    lastDate: DateTime(2101),
                  );
                  if (selectedDate != null && selectedDate != DateTime.now()) {
                    dateController.text =
                        selectedDate.toLocal().toString().split(' ')[0];
                  }
                }
              },
            ),
          ),
          const SizedBox(height: 20),
          Container(
            width: double.infinity,
            height: 65,
            decoration: BoxDecoration(
              border: Border.all(
                width: 2,
              ),
              borderRadius: BorderRadius.circular(20),
            ),
            child: DropdownButtonFormField(
              isExpanded: true,
              dropdownColor: Colors.white,
              iconEnabledColor: const Color.fromARGB(255, 158, 23, 13),
              decoration: const InputDecoration(
                icon: Icon(
                  Icons.location_on,
                  color: Color.fromARGB(255, 158, 23, 13),
                  size: 50,
                ),
                border: InputBorder.none,
              ),
              iconSize: 50,
              value: selectedCentre,
              items: centres.map((centre) {
                return DropdownMenuItem<String>(
                  value: centre,
                  child: Text(
                    centre,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                );
              }).toList(),
              onChanged: (v) {
                selectedCentre = v as String;
              },
            ),
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              elevation: 5,
              fixedSize: const Size(150, 50),
              backgroundColor: const Color.fromARGB(255, 158, 23, 13),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
            ),
            onPressed: () {
              dateController.text.isNotEmpty
                  ? _showConfirmationDialog()
                  : ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Veuillez choisr une date'),
                      ),
                    );
            },
            child: Text(
              'OK',
              style: GoogleFonts.openSans(
                textStyle: const TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
