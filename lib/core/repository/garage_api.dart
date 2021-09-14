import 'dart:convert';

import 'package:rodsiagarage/constants.dart';
import 'package:rodsiagarage/core/models/garage_model.dart';
import 'package:http/http.dart' as http;

import '../../main.dart';

class GarageApi {
  final baseUrl = baseUrlConstant;
  Map<String, String> headers = {
    'Content-type': 'application/json',
    'Accept': 'application/json'
  };

  //late final http.Client httpClient;

  //GarageApi({required this.httpClient});

  Future<Garage> getGarageInfo({required String id}) async {
    final url = '$baseUrl/garage-id/$id';
    final response = await http.get(Uri.parse(url));
    if (response.statusCode != 200) {
      logger.e(response);
      throw new Exception('There was a problem ${response.statusCode}');
    }
    final decodedJson = jsonDecode(response.body);
    Garage garage = decodedJson;

    return garage;
  }

  Future<bool> addGarage({required Garage garage}) async {
    logger.d('${garage.toJson()}');
    final msg = jsonEncode(garage.toJson());
    final url = '$baseUrl/garages';
    final response =
        await http.post(Uri.parse(url), body: msg, headers: headers);
    if (response.statusCode != 200) {
      logger.e(response);
      return false;
      //throw new Exception('There was a problem ${response.statusCode}');
    }
    return true;
  }

  Future<bool> updateGarage(Garage garage) async {
    final url = '$baseUrl/garages/${garage.id}';
    final msg = jsonEncode(garage.toJson());
    final response =
        await http.patch(Uri.parse(url), body: msg, headers: headers);
    if (response.statusCode != 200) {
      logger.e(response);
      return false;
      //throw new Exception('There was a problem ${response.statusCode}');
    }
    return true;
  }

  Future<bool> updateOpenStatusGarage(
      {required Garage garage, required bool openStatus}) async {
    final url = '$baseUrl/garages/${garage.id}/open-status';
    final msg = jsonEncode({'openStatus': openStatus});
    final response =
        await http.patch(Uri.parse(url), body: msg, headers: headers);
    if (response.statusCode != 200) {
      logger.e(response);
      return false;
      //throw new Exception('There was a problem ${response.statusCode}');
    }
    return true;
  }
}
