import 'package:flutter/material.dart';
import 'package:sps_mobile/data/infos.dart';
import 'package:sps_mobile/widgets/info_item.dart';

class InfoScreen extends StatelessWidget {
  const InfoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 0),
      child: Column(
        children: [
          Expanded(
            child: ListView.builder(
                itemCount: infos.length,
                itemBuilder: (context, index) {
                  return InfoItem(
                    id: infos[index]["id"] as int,
                    title: infos[index]["title"] as String,
                    image: infos[index]["image"] as String,
                  );
                }),
          )
        ],
      ),
    );
  }
}
