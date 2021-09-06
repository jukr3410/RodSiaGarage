import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:rodsiagarage/core/repository/garage_repository.dart';

part 'authentication_event.dart';
part 'authentication_state.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  final GarageRepository garageRepository;

  AuthenticationBloc({required this.garageRepository}) : super(Uninitialized());

  String mockGarageId = "1234";

  @override
  Stream<AuthenticationState> mapEventToState(
    AuthenticationEvent event,
  ) async* {
    if (event is AppStarted) {
      yield* _mapAppStartedToState();
    }
  }

  Stream<AuthenticationState> _mapAppStartedToState() async* {
    try {
      // final isSignedIn = await garageRepository.isAuthenticated();
      // if (!isSignedIn) {
      //   await garageRepository.authenticate();
      // }
      // final garageId = await garageRepository.getGarageId();
      yield Authenticated(mockGarageId);
    } catch (_) {
      yield Unauthenticated();
    }
  }
}
