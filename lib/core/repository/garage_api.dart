import 'dart:convert';

import 'package:rodsiagarage/constants.dart';
import 'package:rodsiagarage/core/dao/garage_dao.dart';
import 'package:rodsiagarage/core/models/garage_login.dart';
import 'package:rodsiagarage/core/models/garage_model.dart';
import 'package:http/http.dart' as http;
import 'package:rodsiagarage/core/models/garage_model_db.dart';

import '../../main.dart';

class GarageApi {
  final baseUrl = baseUrlConstant;
  Map<String, String> headers = {
    'Content-type': 'application/json',
    'Accept': 'application/json'
  };

  final garageDao = GarageDao();

  Future<Garage> getGarageInfo({required String id}) async {
    final url = '$baseUrl/garage-id/$id';
    final response = await http.get(Uri.parse(url));
    if (response.statusCode != 200) {
      logger.e(response);
      throw new Exception('There was a problem ${response.statusCode}');
    }
    final decodedJson = jsonDecode(response.body);
    Garage garage = Garage.fromJson(decodedJson);

    return garage;
  }

  Future<Garage> getGaragePhone() async {
    GarageDB userToken = await garageDao.getGarageToken();
    final url = '$baseUrl/garages-phone/${userToken.phone}';
    final response = await http.get(Uri.parse(url));
    logger.d('${response.body}');

    if (response.statusCode != 200) {
      logger.e(response);
      throw new Exception('There was a problem ${response.statusCode}');
    }
    final decodedJson = jsonDecode(response.body);
    Garage garage = Garage.fromJson(decodedJson);

    return garage;
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

  Future<bool> checkUsedNumberPhone({required Garage garage}) async {
    final url = '$baseUrl/auth/phoneCheck-Garage';
    final msg = jsonEncode(garage.toJson());
    final response =
        await http.post(Uri.parse(url), body: msg, headers: headers);
    if (response.statusCode != 200) {
      logger.e(response);
      return false;
      //throw new Exception('There was a problem ${response.statusCode}');
    }
    final decodedJson = jsonDecode(response.body);
    logger.d("isExists: ${decodedJson['success']}");

    if (decodedJson["success"] == false) {
      logger.d("phone number not exists");
      return false;
    }

    return true;
  }

  Future<bool> addGarage({required Garage garage}) async {
    final url = '$baseUrl/auth/registerGarage';
    final msg = jsonEncode(garage.toJson());
    final response =
        await http.post(Uri.parse(url), body: msg, headers: headers);
    if (response.statusCode != 200) {
      final decodedJson = jsonDecode(response.body);
      logger.d("$decodedJson");
      return false;
      //throw new Exception('There was a problem ${response.statusCode}');
    }

    final decodedJson = jsonDecode(response.body);
    logger.d("$decodedJson");

    return true;
  }

  Future<bool> requestSendOtpGarage({required Garage garage}) async {
    final url = '$baseUrl/auth/sendOtpGarage';
    final msg = jsonEncode(garage.toJson());
    final response =
        await http.post(Uri.parse(url), body: msg, headers: headers);
    if (response.statusCode != 200) {
      logger.e(response);
      return false;
      //throw new Exception('There was a problem ${response.statusCode}');
    }
    return true;
  }

  Future<bool> verifyOtpGarage({required Garage garage}) async {
    logger.d("Garage Verify: ${garage.otp}");
    final url = '$baseUrl/auth/verifyOtpGarage';
    final msg = jsonEncode(garage.toJson());
    final response =
        await http.post(Uri.parse(url), body: msg, headers: headers);
    if (response.statusCode != 200) {
      logger.e(response);
      return false;
      //throw new Exception('There was a problem ${response.statusCode}');
    }
    final decodedJson = jsonDecode(response.body);
    logger.d("isSuccess: ${decodedJson['success']}");

    if (decodedJson["success"] == false) {
      logger.d("verify failed");
      return false;
    }

    return true;
  }

  Future<Token> getTokenLogin({required GarageLogin garageLogin}) async {
    final url = '$baseUrl/auth/loginGarage';
    final msg = jsonEncode(garageLogin.toJson());
    final response =
        await http.post(Uri.parse(url), body: msg, headers: headers);
    if (response.statusCode != 200) {
      final decodedJson = jsonDecode(response.body);
      logger.d("$decodedJson");
      //return '';
      throw new Exception('There was a problem ${response.statusCode}');
    }

    final decodedJson = jsonDecode(response.body);
    logger.d("$decodedJson");
    Token token = Token.fromJson(decodedJson);
    logger.d("$token");
    return token;
  }
}
