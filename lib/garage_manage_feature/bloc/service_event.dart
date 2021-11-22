part of 'service_bloc.dart';

abstract class ServiceEvent extends Equatable {
  const ServiceEvent();

  @override
  List<Object> get props => [];
}

class ServiceInitializeEvent extends ServiceEvent {}

class ServiceLoad extends ServiceEvent {
  final String garageId;
  const ServiceLoad({required this.garageId});
}

class ServiceAdd extends ServiceEvent {
  final Service service;

  const ServiceAdd(this.service);

  @override
  List<Object> get props => [service];

  @override
  String toString() => 'ServiceAdd {service: ${service.toJson()}}';
}

class ServiceUpdate extends ServiceEvent {
  final Service service;

  const ServiceUpdate(this.service);

  @override
  List<Object> get props => [service];

  @override
  String toString() => 'ServiceUpdate {service: $service}';
}

class ServiceDelete extends ServiceEvent {
  final Service service;

  const ServiceDelete(this.service);

  @override
  List<Object> get props => [service];

  @override
  String toString() => 'ServiceUpdate {service: $service}';
}
