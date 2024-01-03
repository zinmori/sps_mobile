import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Planning extends StatefulWidget {
  const Planning({super.key});

  @override
  State<Planning> createState() {
    return _PlanningState();
  }
}

class _PlanningState extends State<Planning> {
  bool hasAppointment = false;
  String selectedCentre = 'CNTS';
  TextEditingController dateController = TextEditingController();
  List<String> centres = [
    'CNTS',
    'PCD Kpalime',
    'PCD Afagnan',
    'PCD Kara',
    'PCD Dapaong'
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
              onPressed: () {
                Navigator.of(context).pop();
                setState(() {
                  hasAppointment = true;
                });
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
              onPressed: () {
                Navigator.of(context).pop();
                setState(() {
                  hasAppointment = false;
                });
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
    return hasAppointment
        ? ShowAppointment(
            centre: selectedCentre,
            date: dateController.text,
            delete: _showDeleteDialog,
          )
        : Padding(
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

                      if (selectedDate != null &&
                          selectedDate != DateTime.now()) {
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
                    elevation: 0,
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

class ShowAppointment extends StatelessWidget {
  const ShowAppointment(
      {super.key,
      required this.centre,
      required this.date,
      required this.delete});
  final String centre;
  final String date;
  final void Function()? delete;

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
                date,
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
                centre,
                style: const TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(height: 30),
          IconButton.filled(
            onPressed: delete,
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
