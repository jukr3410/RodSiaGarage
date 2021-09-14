part of 'service_type_bloc.dart';

abstract class ServiceTypeEvent extends Equatable {
  const ServiceTypeEvent();

  @override
  List<Object> get props => [];
}

class ServiceTypeLoad extends ServiceTypeEvent {}
