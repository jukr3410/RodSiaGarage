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

  Future<bool> addGarage({required Garage garage}) async {
    return await garageApi.addGarage(garage: garage);
  }

  Future<bool> updateGarage({required Garage garage}) async {
    return await garageApi.updateGarage(garage);
  }

  Future<bool> updateOpenStatusGarage(
      {required Garage garage, required bool openStatus}) async {
    return await garageApi.updateOpenStatusGarage(
        garage: garage, openStatus: openStatus);
  }

  Future<GarageDB> authenticate({
    required String phone,
    required String password,
  }) async {
    GarageLogin garageLogin = GarageLogin(phone: phone, password: password);
    //Token token = await getToken(garageLogin);
    GarageDB garageDB = GarageDB(
      id: 0,
      phone: phone,
      //token: token.token,
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
}
