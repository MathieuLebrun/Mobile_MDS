import 'dart:convert';

ProjectModel getdataMarketJson(String str) =>
    ProjectModel.fromJson(json.decode(str));

class ProjectModel {
  ProjectModel({
    required this.status,
    required this.tokenStatus,
    required this.data,
  });

  late final String status;
  late final String tokenStatus;
  late final List<DataModel> data;

  ProjectModel.fromJson(Map<String, dynamic> json) {
    status = json['STATUS'];
    tokenStatus = json['TOKENSTATUS'];
    data = List<DataModel>.from(json['data'].map((x) => DataModel.fromJson(x)));
  }

}

class DataModel {
  DataModel({
    required this.projet,
    required this.creationDate,
    required this.semaine,
    required this.demande,
    required this.duree,
    required this.annee,
    required this.id,
    required this.type,
    required this.tache,
    required this.client,
  });

  late final String projet;
  late final String creationDate;
  late final int semaine;
  late final String demande;
  late final dynamic duree;
  late final int annee;
  late final int id;
  late final String type;
  late final dynamic  tache;
  late final String client;

  DataModel.fromJson(Map<String, dynamic> json) {
    projet = json['PROJET'];
    creationDate = json['CREATIONDATE'];
    semaine = json['SEMAINE'];
    demande = json['DEMANDE'];
    duree = json['DUREE'];
    annee = json['ANNEE'];
    id = json['ID'];
    type = json['TYPE'];
    tache = json['TACHE'];
    client = json['CLIENT'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['PROJET'] = projet;
    data['CREATIONDATE'] = creationDate;
    data['SEMAINE'] = semaine;
    data['DEMANDE'] = demande;
    data['DUREE'] = duree;
    data['ANNEE'] = annee;
    data['ID'] = id;
    data['TYPE'] = type;
    data['TACHE'] = tache.toString();
    data['CLIENT'] = client;
    return data;
  }
}
