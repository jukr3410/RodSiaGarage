import 'dart:async';
import 'dart:developer';
import 'dart:math';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:rodsiagarage/core/models/garage_model.dart';
import 'package:rodsiagarage/core/models/geo_location_model.dart';
import 'package:rodsiagarage/core/models/service_model.dart';
import 'package:rodsiagarage/core/models/service_type_model.dart';
import 'package:rodsiagarage/core/repository/service_api.dart';
import 'package:rodsiagarage/core/repository/service_repository.dart';
import 'package:rodsiagarage/core/models/geo_location_model.dart';
import 'package:rodsiagarage/main.dart';

part 'service_event.dart';
part 'service_state.dart';

class ServiceBloc extends Bloc<ServiceEvent, ServiceState> {
  final ServiceRepository serviceRepository;
  StreamSubscription? _servicesSubscription;

  ServiceApi serviceApi = ServiceApi();

  ServiceBloc({required this.serviceRepository}) : super(ServiceInitial());

  String mockGarageId = "6129f2b0748ba19d14a2c1e3";

  @override
  Stream<ServiceState> mapEventToState(
    ServiceEvent event,
  ) async* {
    if (event is ServiceLoad) {
      yield* _mapServiceLoadToState(event.garageId);
    } else if (event is ServiceAdd) {
      yield* _mapServiceAddToState(event);
    } else if (event is ServiceUpdate) {
      yield* _mapServiceUpdateToState(event);
    } else if (event is ServiceDelete) {
      yield* _mapServiceDeleteToState(event);
    } else if (event is ServiceInitializeEvent) {
      yield ServiceInitial();
    }
  }

  Stream<ServiceState> _mapServiceLoadToState(String garageId) async* {
    try {
      final services =
          await this.serviceRepository.getServiceByGarage();
      yield ServicesLoadSuccess(services: services);
    } catch (e) {
      logger.e(e);
      yield ServicesError();
    }
  }

  Stream<ServiceState> _mapServiceAddToState(ServiceAdd event) async* {
    try {
      await this.serviceRepository.addService(service: event.service);
      yield ServiceAdded();
    } catch (e) {
      logger.e(e);
      yield ServicesError();
    }
  }

  Stream<ServiceState> _mapServiceUpdateToState(ServiceUpdate event) async* {
    try {
      await this.serviceRepository.updateService(service: event.service);
      yield ServiceEdited();
    } catch (e) {
      logger.e(e);
      yield ServicesError();
    }
  }

  Stream<ServiceState> _mapServiceDeleteToState(ServiceDelete event) async* {
    serviceRepository.deleteService(serviceId: event.service.id);
  }

  @override
  Future<void> close() {
    _servicesSubscription?.cancel();
    return super.close();
  }
}
