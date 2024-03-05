import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:sps_mobile/models/giver.dart';
import 'package:sps_mobile/models/planning.dart';
import 'package:sps_mobile/services/notification_service.dart';

final FirebaseFirestore _firestore = FirebaseFirestore.instance;

class UserService {
  final CollectionReference _usersCollection = _firestore.collection('users');

  Future<void> addUser(Giver giver) async {
    await _usersCollection.doc(FirebaseAuth.instance.currentUser!.uid).set({
      'email': giver.email,
      'nom': giver.nom,
      'prenom': giver.prenom,
      'date_naissance': giver.dateNaissance,
      'sexe': giver.sexe,
      'groupe_sanguin': giver.groupeSanguin,
    });
  }

  Future<DocumentSnapshot> getUser() async {
    return await _usersCollection
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get();
  }

  Future<void> updateUser(Map<String, dynamic> data) async {
    await _usersCollection
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .update(data);
  }

  Future<void> deleteUser() async {
    await _usersCollection.doc(FirebaseAuth.instance.currentUser!.uid).delete();
  }
}

class PlanningService {
  final CollectionReference _planningsCollection =
      _firestore.collection('plannings');

  Future<void> addPlanning(Planning planning) async {
    await _planningsCollection
        .doc(planning.user + planning.date.toLocal().toString().split(' ')[0])
        .set({
      'user': planning.user,
      'date': planning.date,
      'centre': planning.centre,
      'honore': planning.honore,
    });
    NotificationService().scheduleNotification(
      id: 4,
      title: 'Rappel',
      description: 'Votre prochain don est prévu aujourd\'hui',
      scheduledDate: planning.date,
    );
  }

  Future<QuerySnapshot> getPlannings() async {
    final plannings = await _planningsCollection
        .where('user', isEqualTo: FirebaseAuth.instance.currentUser!.uid)
        .where('honore', isEqualTo: true)
        .orderBy('date', descending: true)
        .get();
    return plannings;
  }

  Stream<QuerySnapshot> getLastPlanning() {
    return _planningsCollection
        .where('user', isEqualTo: FirebaseAuth.instance.currentUser!.uid)
        .orderBy('date', descending: true)
        .limit(1)
        .snapshots();
  }

  Future<void> updatePlanning(
      String planningId, Map<String, dynamic> data) async {
    await _planningsCollection.doc(planningId).update(data);
  }

  Future<void> deletePlanning(String planningId) async {
    await _planningsCollection.doc(planningId).delete();
  }
}

class UrgenceService {
  Stream<QuerySnapshot> getUrgences() {
    final urgences = _firestore
        .collection('urgences')
        .where('satisfait', isEqualTo: false)
        .snapshots();
    return urgences;
  }
}

class CentreService {
  Future<QuerySnapshot> getCentres() async {
    final centres = await _firestore.collection('centres').get();
    return centres;
  }
}
