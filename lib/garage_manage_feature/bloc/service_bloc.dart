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
import 'package:rodsiagarage/main.dart';

part 'service_event.dart';
part 'service_state.dart';

class ServiceBloc extends Bloc<ServiceEvent, ServiceState> {
  final ServiceRepository serviceRepository;
  StreamSubscription? _servicesSubscription;

  ServiceApi serviceApi = ServiceApi();

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
    } else if (event is ServiceInitializeEvent) {
      yield ServiceInitial();
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
    try {
      yield ServicesLoading();
      event.service.serviceType = ServiceType(
          id: "61265f79f7b19f6ca9064b7e",
          name: "name",
          description: "description");

      event.service.garage = Garage(
          address: Address(
              addressDesc: '', geoLocation: GeoLocation(lat: '', long: '')),
          images: [],
          id: this.mockGarageId,
          name: "",
          phone: "",
          email: "",
          password: "",
          otp: "",
          validatePhone: true);

      await this.serviceRepository.addService(service: event.service);
      yield ServiceAdded();
    } catch (e) {
      yield ServicesError();
    }
  }

  Stream<ServiceState> _mapServiceUpdateToState(ServiceUpdate event) async* {
    serviceRepository.updateService(service: event.service);
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
