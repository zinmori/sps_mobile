import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sps_mobile/screens/histo_screen.dart';
import 'package:sps_mobile/screens/info_screen.dart';
import 'package:sps_mobile/screens/planning.dart';
import 'package:sps_mobile/screens/profil_screen.dart';
import 'package:sps_mobile/screens/urgence_screen.dart';

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
        surfaceTintColor: Colors.white,
        elevation: 10,
        title: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset('assets/images/logo.png', height: 40, width: 40),
              Text(
                titles[currenTPageIndex],
                style: GoogleFonts.openSans(
                  color: Colors.red,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
      //backgroundColor: Colors.white,
      body: Center(
        child: [
          const Planning(),
          const InfoScreen(),
          const HistoScreen(),
          const UrgenceScreen(),
          const ProfilScreen(),
        ][currenTPageIndex],
      ),
      bottomNavigationBar: NavigationBar(
        shadowColor: Colors.red,
        indicatorColor: Colors.red,
        surfaceTintColor: Colors.white,
        elevation: 10,
        destinations: [
          NavigationDestination(
            icon: Icon(
              Icons.calendar_month_rounded,
              color: currenTPageIndex == 0 ? Colors.white : Colors.red,
            ),
            label: 'Planning',
          ),
          NavigationDestination(
            icon: Icon(
              Icons.info_rounded,
              color: currenTPageIndex == 1 ? Colors.white : Colors.red,
            ),
            label: 'Info',
          ),
          NavigationDestination(
            icon: Icon(
              Icons.history_rounded,
              color: currenTPageIndex == 2 ? Colors.white : Colors.red,
            ),
            label: 'Historique',
          ),
          NavigationDestination(
            icon: Icon(
              Icons.warning_rounded,
              color: currenTPageIndex == 3 ? Colors.white : Colors.red,
            ),
            label: 'Urgences',
          ),
          NavigationDestination(
            icon: Icon(
              Icons.person_rounded,
              color: currenTPageIndex == 4 ? Colors.white : Colors.red,
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
