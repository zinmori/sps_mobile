import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sps_mobile/models/giver.dart';
import 'package:sps_mobile/services/firestore_service.dart';

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
  TextEditingController nomController = TextEditingController();
  TextEditingController prenomController = TextEditingController();

  bool validator() {
    if (nomController.text.isEmpty ||
        prenomController.text.isEmpty ||
        date == null) {
      return false;
    }
    return true;
  }

  void setData() async {
    DocumentSnapshot doc = await UserService().getUser();
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    setState(() {
      nomController.text = data['nom'] ?? '';
      prenomController.text = data['prenom'] ?? '';
      date = DateTime.fromMillisecondsSinceEpoch(
          data['date_naissance'].seconds * 1000);
      selectedGenre = data['sexe'] == 'Masculin' ? 1 : 2;
      selectedValue = data['groupe_sanguin'] ?? 'O+';
    });
  }

  @override
  void initState() {
    super.initState();
    setData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
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
                  ),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8),
                  child: TextField(
                    cursorColor: Colors.red,
                    onTapOutside: (event) => FocusScope.of(context).unfocus(),
                    controller: nomController,
                    decoration: const InputDecoration(
                      hintText: 'Nom',
                      border: InputBorder.none,
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
                child: Padding(
                  padding: const EdgeInsets.all(8),
                  child: TextField(
                    controller: prenomController,
                    onTapOutside: (event) => FocusScope.of(context).unfocus(),
                    cursorColor: Colors.red,
                    decoration: const InputDecoration(
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
                      onPressed: () async {
                        date = await showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime(1900),
                          lastDate: DateTime.now(),
                        );
                        setState(() {
                          date = date;
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
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        backgroundColor: Colors.red,
                        elevation: 10,
                      ),
                      onPressed: () async {
                        if (!validator()) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Veuillez remplir tous les champs'),
                            ),
                          );
                          return;
                        }
                        await UserService().addUser(
                          Giver(
                            email: FirebaseAuth.instance.currentUser!.email!,
                            nom: nomController.text,
                            prenom: prenomController.text,
                            dateNaissance: date!,
                            sexe: selectedGenre == 1 ? 'Masculin' : 'Féminin',
                            groupeSanguin: selectedValue,
                          ),
                        );
                        if (mounted) {
                          Navigator.of(context).pop({
                            'nom': nomController.text,
                            'prenom': prenomController.text,
                            'date_naissance':
                                date!.toLocal().toString().split(' ')[0],
                            'sexe': selectedGenre == 1 ? 'Masculin' : 'Féminin',
                            'groupe_sanguin': selectedValue,
                          });
                        }
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
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: const Text('Annuler'),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
