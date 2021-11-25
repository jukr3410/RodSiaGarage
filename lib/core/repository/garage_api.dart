import 'dart:convert';
import 'dart:io';

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
    GarageDB garageToken = await garageDao.getGarageToken();
    final url = '$baseUrl/garages-phone/${garageToken.phone}';
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

  Future<bool> updateGarageNoPassword({required Garage garage}) async {
    final url = '$baseUrl/garages-no-password';
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

  Future<bool> updateGaragePassword({required Garage garage}) async {
    final url = '$baseUrl/garages-password';
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

  Future<bool> checkPassword({required GarageLogin garageLogin}) async {
    final url = '$baseUrl/auth/loginGarage';
    final msg = jsonEncode(garageLogin.toJson());
    final response =
        await http.post(Uri.parse(url), body: msg, headers: headers);
    if (response.statusCode != 200) {
      // final decodedJson = jsonDecode(response.body);
      // logger.d("$decodedJson");

      return false;
    }
    return true;
  }

  Future<bool> updateGarageProfile({required File image}) async {
    GarageDB userToken = await garageDao.getGarageToken();
    final url = '$baseUrl/image-uploads/garage/${userToken.phone}';

    var request = http.MultipartRequest(
      'POST',
      Uri.parse(url),
    );
    Map<String, String> headersUpload = {"Content-type": "multipart/form-data"};
    request.files.add(
      http.MultipartFile(
        'file',
        image.readAsBytes().asStream(),
        image.lengthSync(),
        filename: image.path.split('/').last,
      ),
    );
    request.headers.addAll(headersUpload);
    logger.d("request: " + request.toString());
    try {
      var res = await request.send();
      var data = await res.stream
          .transform(utf8.decoder)
          .transform(json.decoder)
          .first;

      logger.d('Response:\n$data');

      if (res.statusCode != 200) {
        logger.e(res);
      }
      return true;
    } catch (e, stacktrace) {
      logger.d('Http exception:\nInstance of: ${e.runtimeType}\nMessage: ${e}');
      logger.d('Http stacktrace:\n$stacktrace');
      return false;
    }
  }

  Future<bool> updateGarageImage({required File image}) async {
    GarageDB userToken = await garageDao.getGarageToken();

    final url = '$baseUrl/image-uploads-multi/garage/${userToken.phone}/1';

    var request = http.MultipartRequest(
      'POST',
      Uri.parse(url),
    );
    Map<String, String> headersUpload = {"Content-type": "multipart/form-data"};
    request.files.add(
      http.MultipartFile(
        'file',
        image.readAsBytes().asStream(),
        image.lengthSync(),
        filename: image.path.split('/').last,
      ),
    );
    request.headers.addAll(headersUpload);
    logger.d("request: " + request.toString());
    try {
      var res = await request.send();
      var data = await res.stream
          .transform(utf8.decoder)
          .transform(json.decoder)
          .first;

      logger.d('Response:\n$data');

      if (res.statusCode != 200) {
        logger.e(res);
        return false;
      }
      return true;
    } catch (e, stacktrace) {
      logger.d('Http exception:\nInstance of: ${e.runtimeType}\nMessage: ${e}');
      logger.d('Http stacktrace:\n$stacktrace');
      return false;
    }
  }

  Future<bool> updateGarageMultiImage({required List<File> images}) async {
    GarageDB userToken = await garageDao.getGarageToken();
    for (var i = 0; i < images.length; i++) {
      final url = '$baseUrl/image-uploads-multi/garage/${userToken.phone}/$i';

      var request = http.MultipartRequest(
        'POST',
        Uri.parse(url),
      );
      Map<String, String> headersUpload = {
        "Content-type": "multipart/form-data"
      };
      request.files.add(
        http.MultipartFile(
          'file',
          images[i].readAsBytes().asStream(),
          images[i].lengthSync(),
          filename: images[i].path.split('/').last,
        ),
      );
      request.headers.addAll(headersUpload);
      logger.d("request: " + request.toString());
      try {
        var res = await request.send();
        var data = await res.stream
            .transform(utf8.decoder)
            .transform(json.decoder)
            .first;

        logger.d('Response:\n$data');

        if (res.statusCode != 200) {
          logger.e(res);
          return false;
        }
        return true;
      } catch (e, stacktrace) {
        logger
            .d('Http exception:\nInstance of: ${e.runtimeType}\nMessage: ${e}');
        logger.d('Http stacktrace:\n$stacktrace');
        return false;
      }
    }
    return true;
  }
}
