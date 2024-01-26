import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sps_mobile/services/notification_service.dart';

class Alarm extends StatefulWidget {
  const Alarm({super.key, required this.date});

  final String date;

  @override
  State<Alarm> createState() => _AlarmState();
}

class _AlarmState extends State<Alarm> {
  bool unjouravant = false;
  bool deuxjoursavant = false;
  bool troisjoursavant = false;
  SharedPreferences? prefs;
  List<PendingNotificationRequest>? pendingNotifications;

  void init() async {
    pendingNotifications = await NotificationService()
        .notificationPlugin
        .pendingNotificationRequests();
    prefs = await SharedPreferences.getInstance();
    setState(() {
      unjouravant = prefs!.getBool('unjouravant') ?? false;
      deuxjoursavant = prefs!.getBool('deuxjoursavant') ?? false;
      troisjoursavant = prefs!.getBool('troisjoursavant') ?? false;
    });
  }

  @override
  void initState() {
    super.initState();
    init();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Faites-moi un rappel',
            style: TextStyle(
              fontSize: 18.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 20),
          SwitchListTile(
            title: const Text('1 jour avant', style: TextStyle(fontSize: 16)),
            value: unjouravant,
            onChanged: (value) async {
              setState(() {
                unjouravant = value;
              });
              await prefs!.setBool('unjouravant', value);
            },
          ),
          SwitchListTile(
            title: const Text('2 jours avant', style: TextStyle(fontSize: 16)),
            value: deuxjoursavant,
            onChanged: (value) async {
              setState(() {
                deuxjoursavant = value;
              });
              await prefs!.setBool('deuxjoursavant', value);
            },
          ),
          SwitchListTile(
            title: const Text('3 jours avant', style: TextStyle(fontSize: 16)),
            value: troisjoursavant,
            onChanged: (value) async {
              setState(() {
                troisjoursavant = value;
              });
              await prefs!.setBool('troisjoursavant', value);
            },
          ),
          const SizedBox(height: 20),
          Center(
            child: OutlinedButton(
              onPressed: () {
                if (prefs!.getBool('unjouravant')!) {
                  NotificationService().scheduleNotification(
                    id: 0,
                    title: 'Rappel',
                    description: 'Votre prochain don sera demain',
                    scheduledDate: DateTime.parse(widget.date)
                        .subtract(const Duration(days: 1)),
                  );
                } else {
                  for (final pendingNotification in pendingNotifications!) {
                    if (pendingNotification.id == 0) {
                      NotificationService().notificationPlugin.cancel(0);
                    }
                  }
                }
                if (prefs!.getBool('deuxjoursavant')!) {
                  NotificationService().scheduleNotification(
                    id: 1,
                    title: 'Rappel',
                    description: 'Votre prochain don sera dans deux jours',
                    scheduledDate: DateTime.parse(widget.date)
                        .subtract(const Duration(days: 2)),
                  );
                } else {
                  for (final pendingNotification in pendingNotifications!) {
                    if (pendingNotification.id == 1) {
                      NotificationService().notificationPlugin.cancel(1);
                    }
                  }
                }
                if (prefs!.getBool('troisjoursavant')!) {
                  NotificationService().scheduleNotification(
                    id: 2,
                    title: 'Rappel',
                    description: 'Votre prochain don sera dans trois jours',
                    scheduledDate: DateTime.parse(widget.date)
                        .subtract(const Duration(days: 3)),
                  );
                } else {
                  for (final pendingNotification in pendingNotifications!) {
                    if (pendingNotification.id == 2) {
                      NotificationService().notificationPlugin.cancel(2);
                    }
                  }
                }
                Navigator.of(context).pop();
              },
              style: OutlinedButton.styleFrom(
                side: const BorderSide(
                    color: Color.fromARGB(255, 158, 23, 13), width: 2),
              ),
              child: const Text(
                'OK',
                style: TextStyle(color: Color.fromARGB(255, 158, 23, 13)),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
