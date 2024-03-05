import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sps_mobile/screens/histo_screen.dart';
import 'package:sps_mobile/screens/info_screen.dart';
import 'package:sps_mobile/screens/planning_screen.dart';
import 'package:sps_mobile/screens/profil_screen.dart';
import 'package:sps_mobile/screens/urgence_screen.dart';
import 'package:sps_mobile/services/firestore_service.dart';

class Tabs extends StatefulWidget {
  const Tabs({super.key});

  @override
  State<Tabs> createState() {
    return _TabsState();
  }
}

class _TabsState extends State<Tabs> {
  int currenTPageIndex = 0;
  List<String> titles = [
    'Planning',
    'Informations',
    'Historique de don',
    'Besoins Urgents',
    'Profil'
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        shadowColor: Colors.red,
        backgroundColor: Colors.red[20],
        surfaceTintColor: Colors.red[20],
        elevation: 0,
        title: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset('assets/images/logo.png', height: 40, width: 40),
              Text(
                titles[currenTPageIndex],
                style: GoogleFonts.openSans(
                  color: Colors.redAccent[700],
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
      body: Center(
        child: [
          const PlanningScreen(),
          const InfoScreen(),
          const HistoScreen(),
          const UrgenceScreen(),
          const ProfilScreen(),
        ][currenTPageIndex],
      ),
      bottomNavigationBar: NavigationBar(
        shadowColor: Colors.red,
        indicatorColor: const Color.fromARGB(255, 158, 23, 13),
        backgroundColor: Colors.red[20],
        destinations: [
          NavigationDestination(
            icon: Icon(
              Icons.calendar_month_rounded,
              color: currenTPageIndex == 0
                  ? Colors.white
                  : const Color.fromARGB(255, 158, 23, 13),
            ),
            label: 'Planning',
          ),
          NavigationDestination(
            icon: Icon(
              Icons.info_rounded,
              color: currenTPageIndex == 1
                  ? Colors.white
                  : const Color.fromARGB(255, 158, 23, 13),
            ),
            label: 'Info',
          ),
          NavigationDestination(
            icon: Icon(
              Icons.history_rounded,
              color: currenTPageIndex == 2
                  ? Colors.white
                  : const Color.fromARGB(255, 158, 23, 13),
            ),
            label: 'Historique',
          ),
          NavigationDestination(
            icon: StreamBuilder(
                stream: UrgenceService().getUrgences(),
                builder: (context, snapshot) {
                  return Badge(
                    label: Text(snapshot.data!.docs.length.toString()),
                    isLabelVisible: snapshot.data!.docs.isNotEmpty,
                    backgroundColor: Colors.red[900],
                    textColor: Colors.white,
                    child: Icon(
                      Icons.warning_rounded,
                      color: currenTPageIndex == 3
                          ? Colors.white
                          : const Color.fromARGB(255, 158, 23, 13),
                    ),
                  );
                }),
            label: 'Urgences',
          ),
          NavigationDestination(
            icon: Icon(
              Icons.person_rounded,
              color: currenTPageIndex == 4
                  ? Colors.white
                  : const Color.fromARGB(255, 158, 23, 13),
            ),
            label: 'Profil',
          ),
        ],
        selectedIndex: currenTPageIndex,
        onDestinationSelected: (index) {
          setState(() {
            currenTPageIndex = index;
          });
        },
      ),
    );
  }
}
