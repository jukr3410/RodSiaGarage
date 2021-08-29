import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'add_service_event.dart';
part 'add_service_state.dart';

class AddServiceBloc extends Bloc<AddServiceEvent, AddServiceState> {
  AddServiceBloc() : super(AddServiceInitial());

  @override
  Stream<AddServiceState> mapEventToState(
    AddServiceEvent event,
  ) async* {
    // TODO: implement mapEventToState
  }
}
