import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:geolocator/geolocator.dart';
import 'package:rodsiagarage/constants.dart';
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

  bool _isNotCompleted = true;

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
    } else if (event is GetCurrentLocation) {
      yield* _mapGetCurrentLocationToState(event);
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
      yield RequestServiceLoadSuccess(requestService: requestService);
      yield RequestServiceInService();
    } catch (e) {
      yield RequestServiceError();
    }
  }

  Stream<RequestServiceState> _mapUpdateRequestServiceToState(
      UpdateRequestService event) async* {
    try {
      yield UpdatingRequestService();
      final isUpdated = await this
          .requestServiceRepository
          .updateRequestStatus(requestService: event.requestService);

      yield UpdatedRequestService();
    } catch (e) {
      yield RequestServiceError();
    }
  }

  Stream<RequestServiceState> _mapGetCurrentLocationToState(
      GetCurrentLocation event) async* {
    try {
      //yield CurrentLocationLoading();
      final position = await geoService.getLocation();

      yield CurrentLocationSuccess(position: position);
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
