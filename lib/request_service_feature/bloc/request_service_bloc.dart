import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:geolocator/geolocator.dart';
import 'package:rodsiagarage/constants.dart';
import 'package:rodsiagarage/core/models/distance_matrix.dart';
import 'package:rodsiagarage/core/models/geo_location_model.dart';
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

  bool _isNotCompleted = true;

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
    } else if (event is GetCurrentLocationAndDistance) {
      yield* _mapGetCurrentLocationAndDistanceToState(event);
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

  Stream<RequestServiceState> _mapGetCurrentLocationAndDistanceToState(
      GetCurrentLocationAndDistance event) async* {
    try {
      //yield CurrentLocationLoading();
      final position = await geoService.getLocation();
      final distanceMatrix = await this.geoService.getDistanceMatrix(
          startLatitude: position.latitude,
          startLongitude: position.longitude,
          endLatitude: double.parse(event.geoLocationUser.lat),
          endLongitude: double.parse(event.geoLocationUser.long));

      logger.d("distanceMatrix: ${distanceMatrix.toJson()}");

      yield CurrentLocationAndDistanceSuccess(
          position: position, distanceMatrix: distanceMatrix);
    } catch (e) {
      logger.e(e);
      yield RequestServiceError();
    }
  }

  Stream<RequestServiceState> _mapUpdateTrackingServiceToState(
      UpdateTrackingRequestService event) async* {
    try {
      yield RequestServiceLoading();
      while (_isNotCompleted) {
        await Future.delayed(Duration(milliseconds: 1000));

        // get new location grage
        final position = await geoService.getLocation();

        final distanceMatrix = await this.geoService.getDistanceMatrix(
            startLatitude:
                double.parse(event.requestService.geoLocationUser.lat),
            startLongitude:
                double.parse(event.requestService.geoLocationUser.long),
            endLatitude: position.latitude,
            endLongitude: position.longitude);

        // set new location garage
        event.requestService.geoLocationGarage.lat =
            position.latitude.toString();
        event.requestService.geoLocationGarage.long =
            position.longitude.toString();

        final isUpdated = await this
            .requestServiceRepository
            .updateRequestStatus(requestService: event.requestService);

        logger.d("GarageConfirm: ${event.requestService.confirmRequest}");
        yield RequestServiceLoadSuccess(
            requestService: event.requestService,
            distanceMatrix: distanceMatrix);
        if (event.requestService.status != completeRequestService) {
          yield RequestServiceInService();
        } else {
          _isNotCompleted = false;
          yield RequestServiceComleted();
        }
      }
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
