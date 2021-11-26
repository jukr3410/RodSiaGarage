part of 'request_service_bloc.dart';

abstract class RequestServiceEvent extends Equatable {
  const RequestServiceEvent();

  @override
  List<Object> get props => [];
}

class RequestServiceLoad extends RequestServiceEvent {}

class LoadRequestService extends RequestServiceEvent {
  final String requestServiceId;

  const LoadRequestService({required this.requestServiceId});

  @override
  String toString() => 'LoadRequestService {requestService: $requestServiceId}';
}

class UpdateRequestService extends RequestServiceEvent {
  final RequestService requestService;

  const UpdateRequestService({required this.requestService});

  @override
  String toString() =>
      'UpdateRequestService {requestService: ${requestService.toJson()}}';
}

class UpdateRequestServiceAccept extends RequestServiceEvent {
  final RequestService requestService;

  const UpdateRequestServiceAccept({required this.requestService});

  @override
  String toString() =>
      'UpdateRequestService {requestService: ${requestService.toJson()}}';
}

class UpdateRequestServiceCancel extends RequestServiceEvent {
  final RequestService requestService;

  const UpdateRequestServiceCancel({required this.requestService});

  @override
  String toString() =>
      'UpdateRequestService {requestService: ${requestService.toJson()}}';
}

class UpdateTrackingRequestService extends RequestServiceEvent {
  final RequestService requestService;

  const UpdateTrackingRequestService({required this.requestService});

  @override
  String toString() =>
      'UpdateTrackingRequestService requestService: ${requestService.toJson()}';
}

class GetCurrentLocationAndDistance extends RequestServiceEvent {
  final GeoLocation geoLocationUser;

  const GetCurrentLocationAndDistance({required this.geoLocationUser});

  @override
  String toString() =>
      'GetCurrentAndDistanceLocation geoLocationUser: ${geoLocationUser.toJson()}';
}

class UpdateRequestServiceComplete extends RequestServiceEvent {
  final RequestService requestService;

  const UpdateRequestServiceComplete({required this.requestService});

  @override
  String toString() =>
      'UpdateRequestService {requestService: ${requestService.toJson()}}';
}
