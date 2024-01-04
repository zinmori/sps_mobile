import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sps_mobile/screens/tabs.dart';

class ProfilCreation extends StatefulWidget {
  const ProfilCreation({super.key});

  @override
  State<ProfilCreation> createState() => _ProfilCreationState();
}

class _ProfilCreationState extends State<ProfilCreation> {
  int selectedGenre = 1;
  List<String> listSanguin = ['O+', 'A+', 'B+', 'AB+', 'O-', 'A-', 'B-', 'AB-'];
  String selectedValue = 'O+';
  DateTime? date;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(30),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Text(
                'Complétez votre profil',
                style: GoogleFonts.openSans(
                  textStyle: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 30),
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
              child: const Padding(
                padding: EdgeInsets.all(8),
                child: TextField(
                  cursorColor: Colors.red,
                  decoration: InputDecoration(
                    hintText: 'Nom',
                    border: InputBorder.none,
                    //hintStyle: TextStyle(color: Colors.red),
                  ),
                ),
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
              child: const Padding(
                padding: EdgeInsets.all(8),
                child: TextField(
                  cursorColor: Colors.red,
                  decoration: InputDecoration(
                    hintText: 'Prénom',
                    border: InputBorder.none,
                    //hintStyle: TextStyle(color: Colors.red),
                  ),
                ),
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
              child: Row(
                children: [
                  IconButton(
                    icon: const Icon(
                      Icons.calendar_today_rounded,
                      color: Colors.red,
                    ),
                    onPressed: () {
                      setState(() async {
                        date = await showDatePicker(
                          context: context,
                          initialDate: DateTime(1900),
                          firstDate: DateTime(1900),
                          lastDate: DateTime.now(),
                        );
                      });
                    },
                  ),
                  Text(
                    date == null
                        ? 'Date de naissance'
                        : date.toString().split(' ')[0],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            Text(
              'Genre',
              style: GoogleFonts.openSans(
                textStyle: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Row(
              children: [
                Radio(
                    value: 1,
                    groupValue: selectedGenre,
                    activeColor: Colors.red,
                    onChanged: (v) {
                      setState(() {
                        selectedGenre = v as int;
                      });
                    }),
                Text(
                  'Masculin',
                  style: GoogleFonts.openSans(),
                ),
                const SizedBox(width: 20),
                Radio(
                    value: 2,
                    groupValue: selectedGenre,
                    activeColor: Colors.red,
                    onChanged: (v) {
                      setState(() {
                        selectedGenre = v as int;
                      });
                    }),
                Text(
                  'Féminin',
                  style: GoogleFonts.openSans(),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Text(
              'Groupe sanguin',
              style: GoogleFonts.openSans(
                textStyle: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
            ),
            Container(
              height: 150,
              width: double.infinity,
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 4,
                  childAspectRatio: 1.5,
                  mainAxisSpacing: 0,
                  crossAxisSpacing: 0,
                ),
                padding: const EdgeInsets.all(0),
                itemCount: listSanguin.length,
                itemBuilder: (context, index) {
                  return Row(
                    children: [
                      Radio(
                        value: listSanguin[index],
                        groupValue: selectedValue,
                        activeColor: Colors.red,
                        onChanged: (value) {
                          setState(() {
                            selectedValue = value!;
                          });
                        },
                      ),
                      //Text('${listSanguin[index]}'),
                      Image.asset(
                        alignment: Alignment.topLeft,
                        'assets/images/${listSanguin[index].toLowerCase()}.png',
                        width: 35,
                      ),
                    ],
                  );
                },
              ),
            ),
            const SizedBox(height: 20),
            Center(
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  minimumSize: const Size(200, 50),
                  backgroundColor: Colors.red,
                  elevation: 10,
                ),
                onPressed: () {
                  Navigator.of(context).pushReplacement(
                    MaterialPageRoute(
                      builder: (ctx) => const Tabs(),
                    ),
                  );
                },
                child: Text(
                  'Confirmer',
                  style: GoogleFonts.openSans(
                    textStyle: const TextStyle(
                      fontSize: 16,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
