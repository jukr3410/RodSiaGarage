import 'package:rodsiagarage/core/models/service_model.dart';
import 'package:rodsiagarage/core/repository/service_api.dart';

class ServiceRepository {
  ServiceApi serviceApi = ServiceApi();
  static final ServiceRepository _serviceRepository = ServiceRepository._();

  ServiceRepository._();

  factory ServiceRepository() {
    return _serviceRepository;
  }

  Future<List<Service>> getServiceByGarage(String garageId) async {
    return await serviceApi.getServiceByGarage();
  }

  Future<bool> addService({required Service service}) async {
    return await serviceApi.addService(service: service);
  }

  Future<bool> updateService({required Service service}) async {
    return await serviceApi.updateService(service);
  }

  Future<bool> deleteService({required String serviceId}) async {
    return await serviceApi.deleteService(serviceId);
  }
}
