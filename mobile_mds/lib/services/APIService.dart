
import 'dart:convert';

import 'package:http/http.dart' as http;

import '../models/login_request.dart';
class APIService {
  static var client = http.Client();

  static Future<http.Response> login(
    LoginRequestModel model,params
  ) async {
    Map<String, String> requestHeaders = {
      'Content-Type': 'application/json', // Ajoutez les en-têtes spécifiques requis par votre API
      'Authorization': 'Bearer your_token_here',
    };

    var url = "http://217.13.54.98/operationnel/Internal/API/index.cfm";

    String queryString = Uri(queryParameters: params).query;
  String requestUrl = '$url?$queryString';

  // Effectuer la requête HTTP
  http.Response response = await http.get(Uri.parse(requestUrl));
  return response; 
/*
    http.Response response = await client.post(
      Uri.parse(url),
      headers: requestHeaders,
      body:// jsonEncode(model.toJson()),
      jsonEncode(params),
    );
    return response; */
  } 
}