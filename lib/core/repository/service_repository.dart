import 'package:rodsiagarage/core/models/service_model.dart';
import 'package:rodsiagarage/core/repository/service_api.dart';

class ServiceRepository {
  ServiceApi serviceApi = ServiceApi();
  static final ServiceRepository _serviceRepository = ServiceRepository._();

  ServiceRepository._();

  factory ServiceRepository() {
    return _serviceRepository;
  }

  Future<List<Service>> getServiceByGarage({required String garageId}) async {
    return await serviceApi.getServiceByGarage(garageId: garageId);
  }

  Future<bool> addService({required Service service}) async {
    return await serviceApi.addService(service);
  }
}
