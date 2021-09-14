part of 'service_type_bloc.dart';

abstract class ServiceTypeState extends Equatable {
  const ServiceTypeState();

  @override
  List<Object> get props => [];
}

class ServiceTypeInitial extends ServiceTypeState {}

class ServiceTypesLoading extends ServiceTypeState {}

class ServiceTypesLoadSuccess extends ServiceTypeState {
  final List<ServiceType> serviceTypes;

  const ServiceTypesLoadSuccess({required this.serviceTypes});

  @override
  List<Object> get props => [serviceTypes];

  @override
  String toString() =>
      'ServicesLoadSuccess { services: ${serviceTypes.toList()} }';
}

class ServiceTypesError extends ServiceTypeState {}
