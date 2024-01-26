import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
//import 'package:flutter/services.dart';
//import 'package:firebase_auth/firebase_auth.dart';

final FirebaseFirestore _firestore = FirebaseFirestore.instance;

class UserService {
  final CollectionReference _usersCollection = _firestore.collection('users');

  Future<void> addUser(
    String? email,
    String? nom,
    String? prenom,
    DateTime? dateNaissance,
    String? sexe,
    String? groupeSanguin,
  ) async {
    await _usersCollection.doc(FirebaseAuth.instance.currentUser!.uid).set({
      'email': email,
      'nom': nom,
      'prenom': prenom,
      'date_naissance': dateNaissance,
      'sexe': sexe,
      'groupe_sanguin': groupeSanguin,
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

  Future<void> addPlanning(DateTime date, String centre) async {
    await _planningsCollection
        .doc(FirebaseAuth.instance.currentUser!.uid +
            date.toLocal().toString().split(' ')[0])
        .set({
      'user': FirebaseAuth.instance.currentUser!.uid,
      'date': date,
      'centre': centre,
      'honore': null,
    });
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
  final CollectionReference _urgencesCollection =
      _firestore.collection('urgences');

  Future<void> addUrgence(String centre, String sang) async {
    await _urgencesCollection.add({
      'centre': centre,
      'sang': sang,
    });
  }

  Stream<QuerySnapshot> getUrgences() {
    return _urgencesCollection.snapshots();
  }

  Future<void> updateUrgence(
      String urgenceId, Map<String, dynamic> data) async {
    await _urgencesCollection.doc(urgenceId).update(data);
  }

  Future<void> deleteUrgence(String urgenceId) async {
    await _urgencesCollection.doc(urgenceId).delete();
  }
}

/* class InfoService {
  final CollectionReference _infosCollection = _firestore.collection('infos');

  Future<void> addInfo(String image, String titre, String contenu) async {
    await _infosCollection.add({
      'image': image,
      'titre': titre,
      'contenu': contenu,
    });
  }

  Stream<QuerySnapshot> getInfos() {
    return _infosCollection.snapshots();
  }

  Future<void> updateInfo(String infoId, Map<String, dynamic> data) async {
    await _infosCollection.doc(infoId).update(data);
  }

  Future<void> deleteInfo(String infoId) async {
    await _infosCollection.doc(infoId).delete();
  }
}
 */