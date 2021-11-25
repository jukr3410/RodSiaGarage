part of 'request_service_bloc.dart';

abstract class RequestServiceState extends Equatable {
  const RequestServiceState();

  @override
  List<Object> get props => [];
}

class RequestServiceInitial extends RequestServiceState {}

class RequestServiceLoading extends RequestServiceState {}

class RequestServiceLoadSuccess extends RequestServiceState {
  final RequestService requestService;
  final DistanceMatrix? distanceMatrix;

  const RequestServiceLoadSuccess(
      {required this.requestService, this.distanceMatrix});

  @override
  List<Object> get props => [requestService];

  @override
  String toString() =>
      'RequestServiceLoadSuccess { requestService: ${requestService} }';
}

class RequestServiceError extends RequestServiceState {}

class UpdatingRequestService extends RequestServiceState {}

class UpdatedRequestService extends RequestServiceState {}

class UpdatedRequestServiceAccept extends RequestServiceState {}

class UpdatedRequestServiceCancle extends RequestServiceState {}

class RequestServiceInService extends RequestServiceState {}

class RequestServiceComleted extends RequestServiceState {}
