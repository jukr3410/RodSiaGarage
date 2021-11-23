import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:rodsiagarage/core/models/request_service_add_model.dart';
import 'package:rodsiagarage/core/repository/request_service_api.dart';
import 'package:rodsiagarage/core/repository/request_service_repository.dart';
import 'package:rodsiagarage/core/services/geo_location_service.dart';

import '../../main.dart';

part 'request_service_event.dart';
part 'request_service_state.dart';

class RequestServiceBloc
    extends Bloc<RequestServiceEvent, RequestServiceState> {
  final RequestServiceRepository requestServiceRepository;
  StreamSubscription? _servicesSubscription;

  RequestServiceApi requestServiceApi = RequestServiceApi();
  final geoService = GeoLocatorService();

  RequestServiceBloc({required this.requestServiceRepository})
      : super(RequestServiceInitial());

  @override
  Stream<RequestServiceState> mapEventToState(
    RequestServiceEvent event,
  ) async* {
    if (event is RequestServiceInitial) {
      yield RequestServiceInitial();
    } else if (event is LoadRequestService) {
      yield* _mapLoadRequestServiceToState(event);
    } else if (event is UpdateRequestService) {
      yield* _mapUpdateRequestServiceToState(event);
    }
  }

  Stream<RequestServiceState> _mapLoadRequestServiceToState(
      LoadRequestService event) async* {
    try {
      yield RequestServiceLoading();

      final requestService = await this
          .requestServiceRepository
          .getRequestService(id: event.requestServiceId);
      logger.d("GarageConfirm: ${requestService.confirmRequest}");
      yield RequestServiceLoadSuccess(requestServiceAdd: requestService);
    } catch (e) {
      yield RequestServiceError();
    }
  }

  Stream<RequestServiceState> _mapUpdateRequestServiceToState(
      UpdateRequestService event) async* {
    try {
      yield UpdatingRequestService();
      final requestService = await this
          .requestServiceRepository
          .updateRequestStatus(requestServiceAdd: event.requestServiceAdd);
      yield UpdatedRequestService();
    } catch (e) {
      yield RequestServiceError();
    }
  }

  @override
  Future<void> close() {
    _servicesSubscription?.cancel();
    return super.close();
  }
}
