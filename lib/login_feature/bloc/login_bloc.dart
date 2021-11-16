import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:rodsiagarage/authentication/bloc/authentication_bloc.dart';
import 'package:rodsiagarage/core/models/garage_model_db.dart';
import 'package:rodsiagarage/core/repository/garage_repository.dart';

import '../../main.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final GarageRepository garageRepository;
  final AuthenticationBloc authenticationBloc;

  LoginBloc({required this.garageRepository, required this.authenticationBloc})
      : super(LoginInitial());

  @override
  Stream<LoginState> mapEventToState(
    LoginEvent event,
  ) async* {
    if (event is LoginButtonPressed) {
      yield* _mapLoginButtonPressedInToState(event);
    }
  }

  Stream<LoginState> _mapLoginButtonPressedInToState(
      LoginButtonPressed event) async* {
    yield LoginLoading();

    try {
      final GarageDB garageDB = await garageRepository.authenticate(
        phone: event.phone,
        password: event.password,
      );
      logger.d('garageDB Token: ${garageDB.token}');

      authenticationBloc.add(LoggedIn(garageDB: garageDB));
      //yield LoginInitial();
      yield LoginSuccess();
    } catch (error) {
      yield LoginFaliure(error: error.toString());
    }
  }
}
