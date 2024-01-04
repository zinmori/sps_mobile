import 'package:flutter/material.dart';
import 'package:sps_mobile/data/urgences.dart';
import 'package:sps_mobile/widgets/urgence_item.dart';

class UrgenceScreen extends StatelessWidget {
  const UrgenceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          Expanded(
            child: ListView.builder(
                itemCount: urgences.length,
                itemBuilder: (context, index) {
                  return UrgenceItem(
                    centre: urgences[index]["centre"] as String,
                    sang: urgences[index]["sang"] as String,
                  );
                }),
          )
        ],
      ),
    );
  }
}
