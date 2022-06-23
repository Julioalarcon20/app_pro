import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../model/apirespuesta.dart';
import '../util/modelCategory.dart';

const serverError = 'Server error';
const unauthorized = 'Unauthorized';
const somethingWentWrong = "Error del servidor";

class CallApi {
  final String _url = 'http://192.168.1.5:8000/api/';

  postData(data, apiUrl) async {
    var fullUrl = _url + apiUrl + await getToken();
    return await http.post(Uri.parse(fullUrl),
        body: jsonEncode(data), headers: _setHeaders());
  }

  putData(data, apiUrl, id) async {
    var fullUrl = _url + apiUrl + id;
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    var token = localStorage.getString('access_token');
    return await http.put(Uri.parse(fullUrl), body: jsonEncode(data), headers: {
      'Content-type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    });
  }

  getData(apiUrl) async {
    var fullUrl = _url + apiUrl;
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    var token = localStorage.getString('access_token');
    return await http.get(Uri.parse(fullUrl), headers: {
      'Content-type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    });
  }

  Future<ApiRespuesta> getCategoria(apiUrl) async {
    ApiRespuesta apiRespuesta = ApiRespuesta();
    try {
      var fullUrl = _url + apiUrl;
      SharedPreferences localStorage = await SharedPreferences.getInstance();
      var token = localStorage.getString('access_token');
      final respuesta = await http.get(Uri.parse(fullUrl), headers: {
        'Content-type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      });
      switch (respuesta.statusCode) {
        case 200:
          apiRespuesta.data = jsonDecode(respuesta.body)['data']
              .map((p) => Category.fromJson(p))
              .toList();
          apiRespuesta.data as List<dynamic>;
          break;
      }
    } catch (e) {}
    return apiRespuesta;
  }

  _setHeaders() => {
        'Content-type': 'application/json',
        'Accept': 'application/json',
      };

  getToken() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    var token = localStorage.getString('access_token');
    return '?access_token=$token';
  }

  getUser() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    var user = localStorage.getString('user');
    return '?user=$user';
  }

  String? getStringImage(File? file) {
    if (file == null) return null;
    return base64Encode(file.readAsBytesSync());
  }
}
