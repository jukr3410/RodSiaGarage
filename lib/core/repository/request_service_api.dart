import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:rodsiagarage/constants.dart';
import 'package:rodsiagarage/core/models/geo_location_model.dart';
import 'package:rodsiagarage/core/models/request_service_model.dart';
import 'package:rodsiagarage/main.dart';

class RequestServiceApi {
  final baseUrl = baseUrlConstant;
  Map<String, String> headers = {
    'Content-type': 'application/json',
    'Accept': 'application/json'
  };

  Future<RequestService> getRequestService({required String id}) async {
    final url = '$baseUrl/request-services/$id';
    final response = await http.get(Uri.parse(url));
    if (response.statusCode != 200) {
      logger.e(response);
      throw new Exception('There was a problem ${response.statusCode}');
    }
    final decodedJson = jsonDecode(response.body);
    RequestService requestService = decodedJson;

    return requestService;
  }

  // ไปทำเส้น api ก่อน
  Future<bool> updateRequestStatus(
      {required String requestId, required String status}) async {
    final url = '$baseUrl';
    final msg = jsonEncode({'status': status});
    final response =
        await http.patch(Uri.parse(url), body: msg, headers: headers);
    if (response.statusCode != 200) {
      logger.e(response);
      return false;
      //throw new Exception('There was a problem ${response.statusCode}');
    }
    return true;
  }

  // ไปทำเส้น api ก่อน
  Future<bool> updateGeoLocation(
      {required String requestId, required GeoLocation geoLocation}) async {
    final url = '$baseUrl';
    final msg = jsonEncode({'geoLocationGarage': geoLocation});
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
