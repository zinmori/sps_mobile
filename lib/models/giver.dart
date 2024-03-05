class Giver {
  String? email;
  String? nom;
  String? prenom;
  DateTime? dateNaissance;
  String? sexe;
  String? groupeSanguin;

  Giver({
    required this.email,
    this.nom,
    this.prenom,
    this.dateNaissance,
    this.sexe,
    this.groupeSanguin,
  });
}
