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
  final RequestServiceAdd requestServiceAdd;

  const UpdateRequestService({required this.requestServiceAdd});

  @override
  String toString() =>
      'UpdateRequestService {requestServiceAdd: $requestServiceAdd}';
}
