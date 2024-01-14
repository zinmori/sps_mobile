import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sps_mobile/services/firestore_service.dart';

class Schedule extends StatefulWidget {
  const Schedule({super.key});

  @override
  State<Schedule> createState() => _ScheduleState();
}

class _ScheduleState extends State<Schedule> {
  String selectedCentre = 'CNTS';
  TextEditingController dateController = TextEditingController();
  List<String> centres = [
    'CNTS',
    'PCD Kpalime',
    'PCD Afagnan',
    'PCD Kara',
    'PCD Dapaong',
  ];

  Future<void> _showConfirmationDialog() async {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
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
              child: const Text('Annuler', style: TextStyle(color: Colors.red)),
            ),
            ElevatedButton(
              onPressed: () async {
                Navigator.of(context).pop();
                await PlanningService().addPlanning(
                  DateTime.parse(dateController.text),
                  selectedCentre,
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                surfaceTintColor: Colors.white,
              ),
              child:
                  const Text('Confirmer', style: TextStyle(color: Colors.red)),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text(
            'Planifiez votre prochain don',
            style: GoogleFonts.openSans(
              textStyle: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.red,
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
              border: Border.all(
                width: 2,
                //color: Colors.red,
              ),
              borderRadius: BorderRadius.circular(20),
            ),
            child: TextField(
              controller: dateController,
              decoration: const InputDecoration(
                icon: Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Icon(
                    Icons.calendar_today,
                    color: Colors.red,
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
                DateTime? selectedDate = await showDatePicker(
                  context: context,
                  initialDate: DateTime.now(),
                  firstDate: DateTime.now(),
                  lastDate: DateTime(2101),
                );

                if (selectedDate != null && selectedDate != DateTime.now()) {
                  dateController.text =
                      selectedDate.toLocal().toString().split(' ')[0];
                }
              },
            ),
          ),
          const SizedBox(height: 20),
          Container(
            width: double.infinity,
            height: 60,
            decoration: BoxDecoration(
              border: Border.all(
                width: 2,
                //color: Colors.red,
              ),
              borderRadius: BorderRadius.circular(20),
            ),
            child: DropdownButtonFormField(
              dropdownColor: Colors.white,
              iconEnabledColor: Colors.red,
              decoration: const InputDecoration(
                icon: Icon(
                  Icons.location_on,
                  color: Colors.red,
                  size: 50,
                ),
                border: InputBorder.none,
              ),
              iconSize: 50,
              value: selectedCentre,
              items: centres.map((location) {
                return DropdownMenuItem<String>(
                  value: location,
                  child: Text(
                    location,
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
              backgroundColor: Colors.red,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
            ),
            onPressed: _showConfirmationDialog,
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
