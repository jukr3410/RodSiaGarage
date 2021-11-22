import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:rodsiagarage/constants.dart';
import 'package:rodsiagarage/core/dao/garage_dao.dart';
import 'package:rodsiagarage/core/models/garage_model_db.dart';
import 'package:rodsiagarage/core/models/service_model.dart';
import 'package:rodsiagarage/main.dart';

class ServiceApi {
  final baseUrl = baseUrlConstant;
  Map<String, String> headers = {
    'Content-type': 'application/json',
    'Accept': 'application/json'
  };

  final garageDao = GarageDao();

  Future<List<Service>> getServiceByGarage() async {
    GarageDB garageToken = await garageDao.getGarageToken();

    List<Service> services = [];
    final url = '$baseUrl/garage/${garageToken.garage_id}/services';
    final response = await http.get(Uri.parse(url));
    if (response.statusCode != 200) {
      logger.e(response);
      //throw new Exception('There was a problem ${response.statusCode}');
    }
    final decodedJson = jsonDecode(response.body) as List;
    services = decodedJson
        .map((decodedJson) => Service.fromJson(decodedJson))
        .toList();

    return services;
  }

  Future<bool> addService({required Service service}) async {
    logger.d('${service.toJson()}');
    final msg = jsonEncode(service.toJson());
    final url = '$baseUrl/services';
    final response =
        await http.post(Uri.parse(url), body: msg, headers: headers);
    if (response.statusCode != 200) {
      logger.e(response);
      return false;
      //throw new Exception('There was a problem ${response.statusCode}');
    }
    return true;
  }

  Future<bool> updateService(Service service) async {
    final url = '$baseUrl/services/${service.id}';
    final msg = jsonEncode(service.toJson());
    final response =
        await http.patch(Uri.parse(url), body: msg, headers: headers);
    if (response.statusCode != 200) {
      logger.e(response);
      return false;
      //throw new Exception('There was a problem ${response.statusCode}');
    }
    return true;
  }

  Future<bool> deleteService(String serviceId) async {
    final url = '$baseUrl/services/$serviceId';
    final response = await http.delete(Uri.parse(url));
    if (response.statusCode != 200) {
      logger.e(response);
      return false;
      //throw new Exception('There was a problem ${response.statusCode}');
    }
    return true;
  }
}
