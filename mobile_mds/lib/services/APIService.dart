import 'package:http/http.dart' as http;
import 'package:mobile_mds/models/tache_request.dart';

import '../models/login_request.dart';
class APIService {
  static var client = http.Client();


  /* login */
  static Future<http.Response> postdata(
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
    http.Response response = await http.post(Uri.parse(requestUrl));
    return response; 

  } 

  /* Top 5 datatable | Récupérer les projets, les sous projets et les clients*/
  static Future<http.Response> getdata(
    params
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

  }

  /* tache */
  static Future<http.Response> posttache(
    TacheRequestModel model,params
  ) async {
    Map<String, String> requestHeaders = {
      'Content-Type': 'application/json', // Ajoutez les en-têtes spécifiques requis par votre API
      'Authorization': 'Bearer your_token_here',
    };

    var url = "http://217.13.54.98/operationnel/Internal/API/index.cfm";

    String queryString = Uri(queryParameters: params).query;
    String requestUrl = '$url?$queryString';

    // Effectuer la requête HTTP
    http.Response response = await http.post(Uri.parse(requestUrl));
    return response; 

  } 

  static tacheResponseJson(TacheRequestModel model, Map<String, String> queryParams) {} 
}

  