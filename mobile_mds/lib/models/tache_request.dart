class TacheRequestModel {
  TacheRequestModel({
    required this.action,
    required this.token,
    required this.semaine,
    required this.annee,
    required this.type,
    required this.projet,
    required this.sousProjet,
    required this.demande,
    required this.client,
    required this.tache,
    required this.commentaire,
    required this.duree,
  });

  late final String action;
  late final String token;
  late final int semaine;
  late final int annee;
  late final String type;
  late final String projet;
  late final String sousProjet;
  late final String demande;
  late final int client;
  late final String tache;
  late final String commentaire;
  late final double duree;

  TacheRequestModel.fromJson(Map<String, dynamic> json) {
    action =  json['action'];
    token = json['token'];
    semaine = json['semaine'];
    annee = json['annee'];
    type =  json['type'];
    projet = json['projet'];
    sousProjet = json['sousProjet'];
    demande = json['demande'];
    client = json['client'];
    tache =  json['tache'];
    commentaire = json['commentaire'];
    duree = json['duree'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['action'] =action;
    data['token'] = token;
    data['semaine'] = semaine;
    data['annee'] = annee;
    data['type'] = type;
    data['projet'] = projet;
    data['sousProjet'] = sousProjet;
    data['demande'] = demande;
    data['client'] = client;
    data['tache'] = tache;
    data['commentaire'] = commentaire;
    data['duree'] = duree;
    return data;
  }
}