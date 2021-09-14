import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:rodsiagarage/core/models/service_type_model.dart';
import 'package:rodsiagarage/core/repository/service_type_api.dart';
import 'package:rodsiagarage/core/repository/service_type_repository.dart';

import '../../main.dart';

part 'service_type_event.dart';
part 'service_type_state.dart';

class ServiceTypeBloc extends Bloc<ServiceTypeEvent, ServiceTypeState> {
  final ServiceTypeRepository serviceTypeRepository;
  StreamSubscription? _servicesSubscription;

  ServiceTypeApi serviceTypeApi = ServiceTypeApi();

  ServiceTypeBloc({required this.serviceTypeRepository})
      : super(ServiceTypeInitial());

  @override
  Stream<ServiceTypeState> mapEventToState(
    ServiceTypeEvent event,
  ) async* {
    if (event is ServiceTypeLoad) {
      yield* _mapServiceTypeLoadToState();
    }
  }

  Stream<ServiceTypeState> _mapServiceTypeLoadToState() async* {
    try {
      final serviceTypes = await this.serviceTypeRepository.getServiceTypes();
      yield ServiceTypesLoadSuccess(serviceTypes: serviceTypes);
    } catch (e) {
      logger.e(e);
      yield ServiceTypesError();
    }
  }
}
