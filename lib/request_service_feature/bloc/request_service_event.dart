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
      'UpdateRequestService requestService: ${requestService.toJson()}';
}

class UpdateTrackingRequestService extends RequestServiceEvent {
  final RequestService requestService;

  const UpdateTrackingRequestService({required this.requestService});

  @override
  String toString() =>
      'UpdateTrackingRequestService requestService: ${requestService.toJson()}';
}

class GetCurrentLocation extends RequestServiceEvent {}
