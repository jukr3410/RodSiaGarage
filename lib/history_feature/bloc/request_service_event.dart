part of 'request_service_bloc.dart';

abstract class RequestServiceEvent extends Equatable {
  const RequestServiceEvent();

  @override
  List<Object> get props => [];
}

class RequestServiceInitializeEvent extends RequestServiceEvent {}

class RequestServiceLoad extends RequestServiceEvent {
  const RequestServiceLoad();
}

class RequestServiceLoadWithStatus extends RequestServiceEvent {
  final String status;
  const RequestServiceLoadWithStatus({required this.status});
}

class RequestServiceLoadWithStatusRealTime extends RequestServiceEvent {
  final String status;
  const RequestServiceLoadWithStatusRealTime({required this.status});
}
