import 'dart:io';

import 'package:rodsiagarage/core/dao/garage_dao.dart';
import 'package:rodsiagarage/core/models/garage_login.dart';
import 'package:rodsiagarage/core/models/garage_model.dart';
import 'package:rodsiagarage/core/models/garage_model_db.dart';
import 'package:rodsiagarage/core/repository/garage_api.dart';

class GarageRepository {
  GarageApi garageApi = GarageApi();
  final garageDao = GarageDao();
  static final GarageRepository _garageRepository = GarageRepository._();

  GarageRepository._();

  factory GarageRepository() {
    return _garageRepository;
  }

  Future<Garage> getGarageInfo({required String id}) async {
    return await garageApi.getGarageInfo(id: id);
  }

  Future<Garage> getGarageInfoPhone() async {
    return await garageApi.getGaragePhone();
  }

  Future<bool> addGarage({required Garage garage}) async {
    return await garageApi.addGarage(garage: garage);
  }

  Future<bool> checkUsedNumberPhone({required Garage garage}) async {
    return await garageApi.checkUsedNumberPhone(garage: garage);
  }

  Future<bool> requestSendOtpGarage({required Garage garage}) async {
    return await garageApi.requestSendOtpGarage(garage: garage);
  }

  Future<bool> verifyOtpGarage({required Garage garage}) async {
    return await garageApi.verifyOtpGarage(garage: garage);
  }

  Future<bool> updateGarage({required Garage garage}) async {
    return await garageApi.updateGarage(garage);
  }

  Future<bool> updateGarageNoPassword({required Garage garage}) async {
    return await garageApi.updateGarageNoPassword(garage: garage);
  }

  Future<bool> updateGaragePassword({required Garage garage}) async {
    return await garageApi.updateGaragePassword(garage: garage);
  }

  Future<bool> updateOpenStatusGarage(
      {required Garage garage, required bool openStatus}) async {
    return await garageApi.updateOpenStatusGarage(
        garage: garage, openStatus: openStatus);
  }

  Future<bool> checkPassword({required GarageLogin garageLogin}) async {
    bool result = await garageApi.checkPassword(garageLogin: garageLogin);
    return result;
  }

  Future<GarageDB> authenticate({
    required String phone,
    required String password,
  }) async {
    GarageLogin garageLogin = GarageLogin(phone: phone, password: password);
    Token token = await garageApi.getTokenLogin(garageLogin: garageLogin);
    GarageDB garageDB = GarageDB(
      id: 0,
      garage_id: token.garage_id,
      phone: phone,
      token: token.token,
    );
    return garageDB;
  }

  Future<void> persistToken({required GarageDB garageDB}) async {
    // write token with the garage to the database
    await garageDao.createGarage(garageDB);
  }

  Future<void> deleteToken({required int id}) async {
    await garageDao.deleteGarage(id);
  }

  Future<bool> hasToken() async {
    bool result = await garageDao.checkGarage(0);
    return result;
  }

  Future<GarageDB> getGarageToken() async {
    GarageDB result = await garageDao.getGarageToken();
    return result;
  }

  Future<bool> updateGarageProfile({required File image}) async {
    return await garageApi.updateGarageProfile(image: image);
  }

  Future<bool> updateGarageImage({required File image}) async {
    return await garageApi.updateGarageImage(image: image);
  }

  Future<bool> updateGarageMultiImage({required List<File> images}) async {
    return await garageApi.updateGarageMultiImage(images: images);
  }
}
