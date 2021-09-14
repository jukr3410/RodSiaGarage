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
}
