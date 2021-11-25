import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:rodsiagarage/core/models/distance_matrix.dart';
import 'package:rodsiagarage/core/models/request_service_add_model.dart';
import 'package:rodsiagarage/core/models/request_service_model.dart';
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
      yield* _mapLoadRequestServiceToState(event.requestServiceId);
    } else if (event is UpdateRequestService) {
      yield* _mapUpdateRequestServiceToState(event.requestService);
    } else if (event is UpdateRequestServiceAccept) {
      yield* _mapUpdateRequestServiceAcceptToState(event.requestService);
    } else if (event is UpdateRequestServiceCancle) {
      yield* _mapUpdateRequestServiceCancleToState(event.requestService);
    }
  }

  Stream<RequestServiceState> _mapLoadRequestServiceToState(
      String requestServiceId) async* {
    try {
      yield RequestServiceLoading();

      final requestService = await this
          .requestServiceRepository
          .getRequestService(id: requestServiceId);
      logger.d("GarageConfirm: ${requestService}");
      yield RequestServiceLoadSuccess(requestService: requestService);
      yield RequestServiceInService();
    } catch (e) {
      yield RequestServiceError();
    }
  }

  Stream<RequestServiceState> _mapUpdateRequestServiceToState(
      RequestService requestService) async* {
    try {
      yield UpdatingRequestService();
      await this
          .requestServiceRepository
          .updateRequestStatus(requestService: requestService);

      yield UpdatedRequestService();
    } catch (e) {
      logger.e(e);
      yield RequestServiceError();
    }
  }

  Stream<RequestServiceState> _mapUpdateRequestServiceAcceptToState(
      RequestService requestService) async* {
    try {
      yield UpdatingRequestService();
      await this
          .requestServiceRepository
          .updateRequestStatus(requestService: requestService);

      yield UpdatedRequestServiceAccept();
    } catch (e) {
      logger.e(e);
      yield RequestServiceError();
    }
  }

  Stream<RequestServiceState> _mapUpdateRequestServiceCancleToState(
      RequestService requestService) async* {
    try {
      yield UpdatingRequestService();
      await this
          .requestServiceRepository
          .updateRequestStatus(requestService: requestService);

      yield UpdatedRequestServiceCancle();
    } catch (e) {
      logger.e(e);
      yield RequestServiceError();
    }
  }

  @override
  Future<void> close() {
    _servicesSubscription?.cancel();
    return super.close();
  }
}
