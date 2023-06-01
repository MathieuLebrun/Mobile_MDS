import 'dart:convert';

TacheResponseModel tacheResponseJson(String str) =>
    TacheResponseModel.fromJson(json.decode(str));

class TacheResponseModel {
  TacheResponseModel(body, {
    required this.status,
    required this.message,
  });

  late final String status;
  late final String message;

  TacheResponseModel.fromJson(Map<String, dynamic> json) {
    status = json['STATUS'];
    message = json['MESSAGE'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {
      'STATUS': status,
      'MESSAGE': message,
    };
    return data;
  }
}