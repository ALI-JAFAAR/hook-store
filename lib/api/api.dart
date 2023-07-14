import 'dart:convert';
import 'package:http/http.dart' as http;

class Api {

  var api = 'https://offer.aj-sharp.com/public/api/';
  postData(data, apiUrl) async {
    var fullUrl = api + apiUrl;
    return await http.post(Uri.parse(fullUrl),
        body: jsonEncode(data), headers: _setHeaders());
  }

  getData(apiUrl) async {
    var fullUrl = api + apiUrl;
    return await newMethod(fullUrl);
  }
  Future<http.Response> newMethod(String fullUrl) =>
      http.get(Uri.parse(fullUrl), headers: _setHeaders());

  _setHeaders() => {
        'Content-type': 'application/json; charset=utf-8',
        'Accept': 'application/json ',
      };
}