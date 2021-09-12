import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:rodsiagarage/constants.dart';
import 'package:rodsiagarage/core/models/service_type.dart';

import '../../main.dart';

class ServiceTypeApi {
  final baseUrl = baseUrlConstant;

  late final http.Client httpClient;

  Future<List<ServiceType>> getServiceTypes() async {
    List<ServiceType> serviceTypes = [];
    final url = '$baseUrl/service-types';
    final response = await httpClient.get(Uri.parse(url));
    if (response.statusCode != 200) {
      logger.e(response);
      throw new Exception('There was a problem ${response.statusCode}');
    }
    final decodedJson = jsonDecode(response.body) as List;
    serviceTypes = decodedJson
        .map((decodedJson) => ServiceType.fromJson(decodedJson))
        .toList();
    return serviceTypes;
  }
}
