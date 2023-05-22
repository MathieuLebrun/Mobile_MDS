import 'package:http/http.dart' as http;

class APIService {
  static var client = http.Client();

  static Future<http.Response> login(
    LoginRequestModel model,
  ) async {
    Map<String, String> requestHeaders = {
      'Content-Type': 'application/json; charset=UTF-8',
    };

    var url = "http://162.19.230.6:5000/api/auth/login";

    http.Response response = await client.post(
      Uri.parse(url),
      headers: requestHeaders,
      body: jsonEncode(model.toJson()),
    );
    return response;
  }
}