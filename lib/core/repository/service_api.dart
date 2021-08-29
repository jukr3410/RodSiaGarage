import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:rodsiagarage/constants.dart';
import 'package:rodsiagarage/core/models/service_model.dart';

class ServiceApi {
  final baseUrl = baseUrlConstant;

  Future<List<Service>> getServiceByGarage({required String garageId}) async {
    List<Service> services = [];
    final url = '$baseUrl/garage/:$garageId/services';
    final response = await http.get(Uri.parse(url));
    if (response.statusCode != 200) {
      print(response);
      throw new Exception('There was a problem ${response.statusCode}');
    }
    final decodedJson = jsonDecode(response.body) as List;
    services = decodedJson
        .map((decodedJson) => Service.fromJson(decodedJson))
        .toList();

    return services;
  }

  Future<bool> addService(Service service) async {
    final url = '$baseUrl/services';
    final response = await http.post(Uri.parse(url), body: service);
    if (response.statusCode != 200) {
      print(response);
      return false;
      //throw new Exception('There was a problem ${response.statusCode}');
    }
    return true;
  }

  Future<bool> updateService(Service service) async {
    final url = '$baseUrl/services/${service.id}';
    final response = await http.delete(Uri.parse(url), body: service);
    if (response.statusCode != 200) {
      print(response);
      return false;
      //throw new Exception('There was a problem ${response.statusCode}');
    }
    return true;
  }

  Future<bool> deleteService(String serviceId) async {
    final url = '$baseUrl/services/$serviceId';
    final response = await http.delete(Uri.parse(url));
    if (response.statusCode != 200) {
      print(response);
      return false;
      //throw new Exception('There was a problem ${response.statusCode}');
    }
    return true;
  }
}
