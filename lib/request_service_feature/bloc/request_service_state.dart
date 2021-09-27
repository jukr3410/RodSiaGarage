part of 'request_service_bloc.dart';

abstract class RequestServiceState extends Equatable {
  const RequestServiceState();

  @override
  List<Object> get props => [];
}

class RequestServiceInitial extends RequestServiceState {}

class RequestServiceLoading extends RequestServiceState {}

class RequestServiceLoadSuccess extends RequestServiceState {
  final RequestServiceAdd requestServiceAdd;

  const RequestServiceLoadSuccess({required this.requestServiceAdd});

  @override
  List<Object> get props => [requestServiceAdd];

  @override
  String toString() =>
      'RequestServiceLoadSuccess { requestService: ${requestServiceAdd} }';
}

class RequestServiceError extends RequestServiceState {}

class UpdatingRequestService extends RequestServiceState {}

class UpdatedRequestService extends RequestServiceState {}

class RequestServiceInService extends RequestServiceState {}

class RequestServiceComleted extends RequestServiceState {}
