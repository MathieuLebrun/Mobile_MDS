import 'dart:convert';

LoginResponseModel loginResponseJson(String str) =>
    LoginResponseModel.fromJson(json.decode(str));

class LoginResponseModel {
  LoginResponseModel({
    required this.status,
    required this.tokenStatus,
    required this.session,
  });

  late final String status;
  late final String tokenStatus;
  late final SessionDataModel session;

  LoginResponseModel.fromJson(Map<String, dynamic> json) {
    status = json['STATUS'];
    tokenStatus = json['TOKENSTATUS'];
    session = SessionDataModel.fromJson(json['SESSION']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {
      'STATUS': status,
      'TOKENSTATUS': tokenStatus,
      'SESSION': session.toJson(),
    };
    return data;
  }
}

class SessionDataModel {
  SessionDataModel({
    required this.token,
  });

  late final String token;

  SessionDataModel.fromJson(Map<String, dynamic> json) {
    token = json['TOKEN'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {
      'TOKEN': token,
    };
    return data;
  }
}