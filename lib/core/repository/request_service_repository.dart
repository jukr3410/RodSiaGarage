import 'package:rodsiagarage/core/models/request_service_add_model.dart';
import 'package:rodsiagarage/core/models/request_service_model.dart';
import 'package:rodsiagarage/core/repository/request_service_api.dart';

class RequestServiceRepository {
  RequestServiceApi requestServiceApi = RequestServiceApi();
  static final RequestServiceRepository _requestServiceRepository =
      RequestServiceRepository._();

  RequestServiceRepository._();

  factory RequestServiceRepository() {
    return _requestServiceRepository;
  }

  Future<RequestService> getRequestService({required String id}) async {
    return await requestServiceApi.getRequestService(id: id);
  }

  Future<bool> updateRequestStatus(
      {required RequestService requestService}) async {
    return await requestServiceApi.updateRequestStatus(
        requestService: requestService);
  }

  Future<List<RequestService>> getRequestServiceByGarageId() async {
    return await requestServiceApi.getRequestServiceByGarageId();
  }

  Future<List<RequestService>> getRequestServiceListWithStatus(
      {required String status}) async {
    return await requestServiceApi.getRequestServiceListWithStatus(
        status: status);
  }

  // Future<bool> updateGeoLocation(
  //     {required String requestId, required GeoLocation geoLocation}) async {
  //   return await requestServiceApi.updateGeoLocation(
  //       requestId: requestId, geoLocation: geoLocation);
  // }
}
