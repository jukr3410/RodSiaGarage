import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:rodsiagarage/core/models/service_model.dart';
import 'package:rodsiagarage/core/repository/service_repository.dart';

part 'add_service_event.dart';
part 'add_service_state.dart';

class AddServiceBloc extends Bloc<AddServiceEvent, AddServiceState> {
  final ServiceRepository serviceRepository = ServiceRepository();

  AddServiceBloc() : super(AddServiceInitial());

  @override
  Stream<AddServiceState> mapEventToState(
    AddServiceEvent event,
  ) async* {}
}
