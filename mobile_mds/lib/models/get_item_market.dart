import 'dart:convert';

MyModel getItemJson(String str) => 
    MyModel.fromJson(json.decode(str));

class MyModel {
  MyModel({
    required this.projet,
    required this.status,
    required this.tokenStatus,
    required this.demande,
    required this.client,
  });

  List<String> projet;
  String status;
  String tokenStatus;
  List<String> demande;
  List<Client> client;

  factory MyModel.fromJson(Map<String, dynamic> json) => MyModel(
        projet: List<String>.from(json["PROJET"].map((x) => x.toString())),
        status: json["STATUS"].toString(),
        tokenStatus: json["TOKENSTATUS"].toString(),
        demande: List<String>.from(json["DEMANDE"].map((x) => x.toString())),
        client: List<Client>.from(json["CLIENT"].map((x) => Client.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "PROJET": List<dynamic>.from(projet.map((x) => x)),
        "STATUS": status,
        "TOKENSTATUS": tokenStatus,
        "DEMANDE": List<dynamic>.from(demande.map((x) => x)),
        "CLIENT": List<dynamic>.from(client.map((x) => x.toJson())),
      };
}

class Client {
  Client({
    required this.id,
    required this.client,
  });

  int id;
  String client;

  factory Client.fromJson(Map<String, dynamic> json) => Client(
        id: json["ID"],
        client: json["CLIENT"],
      );

  Map<String, dynamic> toJson() => {
        "ID": id,
        "CLIENT": client,
      };
}
