import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:rodsiagarage/core/models/service_model.dart';
import 'package:rodsiagarage/core/repository/service_repository.dart';

part 'service_event.dart';
part 'service_state.dart';

class ServiceBloc extends Bloc<ServiceEvent, ServiceState> {
  final ServiceRepository serviceRepository;

  ServiceBloc({required this.serviceRepository}) : super(ServiceInitial());

  String mockGarageId = "6129f203748ba19d14a2c1df";

  @override
  Stream<ServiceState> mapEventToState(
    ServiceEvent event,
  ) async* {
    if (event is ServiceLoad) {
      yield* _mapServiceLoadToState();
    } else if (event is ServiceAdd) {
      yield* _mapServiceAddToState(event);
    } else if (event is ServiceUpdate) {
      yield* _mapServiceUpdateToState(event);
    } else if (event is ServiceDelete) {
      yield* _mapServiceDeleteToState(event);
    }
  }

  Stream<ServiceState> _mapServiceLoadToState() async* {
    try {
      final services = await this
          .serviceRepository
          .getServiceByGarage(garageId: this.mockGarageId);
      yield ServicesLoadSuccess(services: services);
    } catch (e) {
      print(e);
      yield ServicesError();
    }
  }

  Stream<ServiceState> _mapServiceAddToState(ServiceAdd event) async* {
    serviceRepository.addService(service: event.service);
  }

  Stream<ServiceState> _mapServiceUpdateToState(ServiceUpdate event) async* {
    serviceRepository.updateService(service: event.service);
  }

  Stream<ServiceState> _mapServiceDeleteToState(ServiceDelete event) async* {
    serviceRepository.deleteService(serviceId: event.service.id);
  }
}
