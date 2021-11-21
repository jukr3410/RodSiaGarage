import 'dart:convert';

import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'package:rodsiagarage/core/models/distance_matrix.dart';
import 'package:rodsiagarage/main.dart';
import 'package:rodsiagarage/secrets.dart';

class GeoLocatorService {
  Future<Position> getLocation() async {
    return await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
  }

  Future<double> getDistance(double startLatitude, double startLongitude,
      double endLatitude, double endLongitude) async {
    return Geolocator.distanceBetween(
        startLatitude, startLongitude, endLatitude, endLongitude);
  }

  Future<String> getAddress(
    double latitude,
    double longitude,
  ) async {
    List<Placemark> p = await placemarkFromCoordinates(latitude, longitude);

    Placemark place = p[0];
    var address =
        "${place.name}, ${place.locality}, ${place.postalCode}, ${place.country}";
    return address;
  }

  Future<DistanceMatrix> getDistanceMatrix(
      {required double startLatitude,
      required double startLongitude,
      required double endLatitude,
      required double endLongitude}) async {
    String API_KEY = Secrets.API_KEY;
    final url =
        'https://maps.googleapis.com/maps/api/distancematrix/json?units=metric&origins=$startLatitude,$startLongitude&destinations=$endLatitude,$endLongitude&key=$API_KEY';
    final response = await http.get(Uri.parse(url));
    if (response.statusCode != 200) {
      throw new Exception('There was a problem ${response.statusCode}');
    }
    final decodedJson = jsonDecode(response.body);
    logger.d("Distance Matrix: $decodedJson");
    DistanceMatrix distanceMatrix = DistanceMatrix.fromJson(decodedJson);

    return distanceMatrix;
  }
}
