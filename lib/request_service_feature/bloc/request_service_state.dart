part of 'request_service_bloc.dart';

abstract class RequestServiceState extends Equatable {
  const RequestServiceState();
  
  @override
  List<Object> get props => [];
}

class RequestServiceInitial extends RequestServiceState {}
