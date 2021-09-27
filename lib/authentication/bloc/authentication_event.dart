part of 'authentication_bloc.dart';

abstract class AuthenticationEvent extends Equatable {
  const AuthenticationEvent();

  @override
  List<Object> get props => [];
}

class AppStarted extends AuthenticationEvent {
  @override
  List<Object> get props => [];
}

class LoggedIn extends AuthenticationEvent {
  final GarageDB garageDB;

  const LoggedIn({required this.garageDB});

  @override
  List<Object> get props => [garageDB];

  @override
  String toString() => 'LoggedIn { garage: $garageDB.phone }';
}

class LoggedOut extends AuthenticationEvent {}
