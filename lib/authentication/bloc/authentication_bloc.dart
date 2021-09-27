import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:rodsiagarage/core/models/garage_model_db.dart';
import 'package:rodsiagarage/core/repository/garage_repository.dart';

part 'authentication_event.dart';
part 'authentication_state.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  final GarageRepository garageRepository;

  AuthenticationBloc({required this.garageRepository})
      : super(AuthenticationUninitialized());

  @override
  Stream<AuthenticationState> mapEventToState(
    AuthenticationEvent event,
  ) async* {
    if (event is AppStarted) {
      yield* _mapAppStartedToState();
    } else if (event is LoggedIn) {
      yield* _mapLoggedInToState(event);
    } else if (event is LoggedOut) {
      yield* _mapLoggedOutToState();
    }
  }

  Stream<AuthenticationState> _mapAppStartedToState() async* {
    final bool hasToken = await garageRepository.hasToken();

    if (hasToken) {
      yield AuthenticationAuthenticated();
    } else {
      yield AuthenticationUnauthenticated();
    }
  }

  Stream<AuthenticationState> _mapLoggedInToState(LoggedIn event) async* {
    yield AuthenticationLoading();

    await garageRepository.persistToken(garageDB: event.garageDB);

    yield AuthenticationAuthenticated();
  }

  Stream<AuthenticationState> _mapLoggedOutToState() async* {
    yield AuthenticationLoading();

    await garageRepository.deleteToken(id: 0);

    yield AuthenticationUnauthenticated();
  }
}
