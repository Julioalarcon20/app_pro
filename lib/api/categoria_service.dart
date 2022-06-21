import 'package:maxqui_shop/model/apirespuesta.dart';
import 'dart:convert';
import 'package:maxqui_shop/api/const.dart';
import 'package:http/http.dart' as http;
import 'package:maxqui_shop/api/api.dart';

import '../util/modelCategory.dart';

Future<ApiRespuesta> getCategoria() async {
  ApiRespuesta apiRespuesta =  ApiRespuesta();
  try {
    String token = await CallApi().getToken();
    final response = await http.get(Uri.parse(categoryUrl), headers: {
      'Content-type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    });
    switch (response.statusCode) {
      case 200:
        apiRespuesta.data = jsonDecode(response.body)['category']
            .map((p) => Category.fromJson(p))
            .toList();
        apiRespuesta.data as List<dynamic>;
        break;
      case 401:
        apiRespuesta.error = unauthorized;
        break;
      default:
        apiRespuesta.error = somethingWentWrong;
        break;
    }
  } catch (e) {
    apiRespuesta.error = serverError;
  }
  return apiRespuesta;
}
