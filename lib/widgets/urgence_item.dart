import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class UrgenceItem extends StatelessWidget {
  const UrgenceItem({
    super.key,
    required this.centre,
    required this.sang,
  });
  final String centre;
  final String sang;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Card(
        elevation: 10,
        //surfaceTintColor: Colors.white,
        child: Row(
          children: [
            const Icon(
              Icons.warning_amber_rounded,
              size: 100,
              color: Colors.red,
            ),
            //const SizedBox(width: 20),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Container(
                  width: 200,
                  child: Text(
                    'Le $centre manque de $sang',
                    softWrap: true,
                    style: GoogleFonts.openSans(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                ),
                TextButton(
                  onPressed: () async {
                    DateTime? selectedDate = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime.now(),
                      lastDate: DateTime.now().add(const Duration(days: 7)),
                    );
                    if (selectedDate != null) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          backgroundColor: Colors.red[50],
                          content: Text(
                            'Votre don a été planifié avec succès !',
                            style: GoogleFonts.openSans(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      );
                    }
                  },
                  child: const Text(
                    'Planifier un don',
                    textAlign: TextAlign.end,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
          ],
        ),
      ),
    );
  }
}
