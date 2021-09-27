import 'package:rodsiagarage/core/models/request_service_add_model.dart';
import 'package:rodsiagarage/core/models/service_model.dart';
import 'package:rodsiagarage/core/services/geo_location_model.dart';
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

  Future<RequestServiceAdd> getRequestService({required String id}) async {
    return await requestServiceApi.getRequestService(id: id);
  }

  Future<bool> updateRequestStatus(
      {required RequestServiceAdd requestServiceAdd}) async {
    return await requestServiceApi.updateRequestStatus(
        requestServiceAdd: requestServiceAdd);
  }

  // Future<bool> updateGeoLocation(
  //     {required String requestId, required GeoLocation geoLocation}) async {
  //   return await requestServiceApi.updateGeoLocation(
  //       requestId: requestId, geoLocation: geoLocation);
  // }
}
