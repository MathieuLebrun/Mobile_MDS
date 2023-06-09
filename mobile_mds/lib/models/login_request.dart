class LoginRequestModel {
  LoginRequestModel({
    required this.action,
    required this.login,
    required this.password,
    required this.token,
  });

  late final String action;
  late final String login;
  late final String password;
  late final String token;

  LoginRequestModel.fromJson(Map<String, dynamic> json) {
    action =  json['action'];
    login = json['login'];
    password = json['password'];
    token = json['token'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['action'] = action;
    data['login'] = login;
    data['password'] = password;
    data['token'] = token;
    return data;
  }
}