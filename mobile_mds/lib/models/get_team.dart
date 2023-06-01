import 'dart:convert';

TeamResponseModel teamResponseJson(String str) =>
    TeamResponseModel.fromJson(json.decode(str));


class TeamResponseModel {
  TeamResponseModel({
    required this.status,
    required this.tokenStatus,
    required this.data,
  });

  late final String status;
  late final String tokenStatus;
  late final List<DonneeUser> data;

  TeamResponseModel.fromJson(Map<String, dynamic> json) {
    status = json['STATUS'];
    tokenStatus = json['TOKENSTATUS'];
    data = List<DonneeUser>.from(
        json['data'].map((x) => DonneeUser.fromJson(x)));
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {
      'STATUS': status,
      'TOKENSTATUS': tokenStatus,
      'data': List<dynamic>.from(this.data.map((x) => x.toJson())),
    };
    return data;
  }
}

class DonneeUser {
  DonneeUser({
    required this.login,
    required this.team,
    required this.id,
    required this.admin,
    required this.nom,
    required this.prenom,
  });

  late final String login;
  late final String team;
  late final int id;
  late final int admin;
  late final String nom;
  late final String prenom;

  DonneeUser.fromJson(Map<String, dynamic> json) {
    login = json['LOGIN'];
    team = json['TEAM'];
    id = json['ID'];
    admin = json['ADMIN'];
    nom = json['NOM'];
    prenom = json['PRENOM'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {
      'LOGIN': login,
      'TEAM': team,
      'ID': id,
      'ADMIN': admin,
      'NOM': nom,
      'PRENOM': prenom,
    };
    return data;
  }
}