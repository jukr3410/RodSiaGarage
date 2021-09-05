part of 'service_bloc.dart';

abstract class ServiceState extends Equatable {
  const ServiceState();

  @override
  List<Object> get props => [];
}

class ServiceInitial extends ServiceState {}

class ServicesLoading extends ServiceState {}

class ServicesLoadSuccess extends ServiceState {
  final List<Service> services;

  const ServicesLoadSuccess({required this.services});

  @override
  List<Object> get props => [services];

  @override
  String toString() => 'ServicesLoadSuccess { services: $services }';
}

class ServicesError extends ServiceState {}
