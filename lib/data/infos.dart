import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Condition extends StatelessWidget {
  const Condition({
    super.key,
    required this.condition,
  });
  final String condition;
  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Image.asset(
        'assets/images/gouttesang.png',
        height: 40,
        width: 40,
      ),
      title: Text(
        condition,
        style: GoogleFonts.openSans(fontSize: 16, fontWeight: FontWeight.bold),
      ),
    );
  }
}

final infos = [
  {
    "id": 0,
    "title": "Qui peut donner son sang ?",
    "description": Column(children: [
      Text(
        'Donner son sang pour sauver des vies est un geste noble et élégant. Mais il existe certaines conditions qu\'un donneur doit respecter pour se protéger et protéger les futurs receveurs de ce sang que nous allons donner. Voici ces conditions essentielles pour être donneur au Togo :',
        style: GoogleFonts.openSans(fontSize: 18),
        textAlign: TextAlign.justify,
      ),
      const SizedBox(height: 20),
      const Condition(condition: 'Avoir au moins 18 ans et au plus 60 ans'),
      const Condition(
          condition: 'Avoir un poids supérieur à 50 kilogrammes (Kgs)'),
      const Condition(
          condition:
              'Pour les femmes, ne pas être en période de menstruations, enceinte ou allaitante'),
      const Condition(condition: 'Ne pas avoir une blessure sur le corps'),
      const Condition(
          condition:
              'Ne pas être à risque d’avoir une maladie transmissible par le sang comme l’hépatite B ou l’hépatite C ou le VIH ou autres'),
      const Condition(
          condition:
              'Ne pas avoir eu de soins dentaires dans les 3 jours précédant le jour du don'),
      const Condition(
          condition:
              'Ne pas être sous médication (ne pas être en période de traitement par médicaments pour une maladie)'),
      const Condition(
          condition:
              'Ne pas avoir fait de piercings, ni tatouage les jours précédant le don'),
      const Condition(condition: 'Ne pas se droguer par piqûre'),
      const Condition(
          condition:
              'Ne pas avoir des rapports sexuels avec des personnes de même sexe'),
      const Condition(condition: 'Ne pas avoir plusieurs partenaires sexuels'),
    ]),
    "image": "assets/images/doc_parle.jpg"
  },
  {
    "id": 1,
    "title": "Fréquence de don de sang",
    "description": RichText(
      text: TextSpan(
        style: GoogleFonts.openSans(color: Colors.black, fontSize: 18),
        children: const <TextSpan>[
          TextSpan(
            text:
                'Le don de sang peut être soit un prélèvement du sang total ou soit un de ses constituants. Pour le don de sang total, une fréquence a été définie',
          ),
          TextSpan(
            text:
                ' pour éviter aux donneurs des effets négatifs sur leur santé.',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          TextSpan(
            text: '\n\nLes hommes peuvent donner leur sang ',
          ),
          TextSpan(
            text: '4 fois par an',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          TextSpan(
            text: ' soit chaque ',
          ),
          TextSpan(
            text: ' 3 mois. ',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          TextSpan(
            text: '\n\nLes femmes peuvent donner leur sang ',
          ),
          TextSpan(
            text: '3 fois par an',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          TextSpan(
            text: ' soit chaque ',
          ),
          TextSpan(
            text: ' 4 mois. ',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ],
      ),
    ),
    "image": "assets/images/bras.jpg"
  },
  {
    "id": 2,
    "title": "Nos Centres de collecte",
    "description": const Text('A venir...'),
    "image": "assets/images/doc_parle.jpg"
  },
  {
    "id": 3,
    "title": "Avant d'aller donner son sang",
    "description": const Text('A venir...'),
    "image": "assets/images/doc_parle.jpg"
  },
  {
    "id": 4,
    "title": "Le processus de don de sang",
    "description": const Text('A venir...'),
    "image": "assets/images/doc_parle.jpg"
  }
];
