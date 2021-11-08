part of 'request_service_bloc.dart';

abstract class RequestServiceState extends Equatable {
  const RequestServiceState();

  @override
  List<Object> get props => [];
}

class RequestServiceInitial extends RequestServiceState {}

class RequestServicesLoading extends RequestServiceState {}

class RequestServicesLoadSuccess extends RequestServiceState {
  final List<RequestService> requestServices;

  const RequestServicesLoadSuccess({required this.requestServices});

  @override
  List<Object> get props => [requestServices];

  @override
  String toString() =>
      'ServicesLoadSuccess { requestServices: ${requestServices.toList()} }';
}

class RequestServicesError extends RequestServiceState {}
