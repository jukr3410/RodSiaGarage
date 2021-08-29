import 'package:rodsiagarage/core/models/garage_model.dart';
import 'package:rodsiagarage/core/repository/garage_api.dart';

class GarageRepository {
  GarageApi garageApi = GarageApi();
  static final GarageRepository _garageRepository = GarageRepository._();

  GarageRepository._();

  factory GarageRepository() {
    return _garageRepository;
  }

  Future<Garage> getGarageInfo({required String id}) async {
    return await garageApi.getGarageInfo(id: id);
  }
}