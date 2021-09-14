import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'request_service_event.dart';
part 'request_service_state.dart';

class RequestServiceBloc extends Bloc<RequestServiceEvent, RequestServiceState> {
  RequestServiceBloc() : super(RequestServiceInitial());

  @override
  Stream<RequestServiceState> mapEventToState(
    RequestServiceEvent event,
  ) async* {
    // TODO: implement mapEventToState
  }
}
