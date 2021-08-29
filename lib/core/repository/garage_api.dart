import 'dart:convert';

import 'package:rodsiagarage/constants.dart';
import 'package:rodsiagarage/core/models/garage_model.dart';
import 'package:http/http.dart' as http;

class GarageApi {
  final baseUrl = baseUrlConstant;

  //late final http.Client httpClient;

  //GarageApi({required this.httpClient});

  Future<Garage> getGarageInfo({required String id}) async {
    final url = '$baseUrl/garage-id/$id';
    final response = await http.get(Uri.parse(url));
    if (response.statusCode != 200) {
      print(response);
      throw new Exception('There was a problem ${response.statusCode}');
    }
    final decodedJson = jsonDecode(response.body);
    Garage garage = decodedJson;

    return garage;
  }
}
