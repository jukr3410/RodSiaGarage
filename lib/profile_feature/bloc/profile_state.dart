part of 'profile_bloc.dart';

abstract class ProfileState extends Equatable {
  const ProfileState();

  @override
  List<Object> get props => [];
}

class ProfileInitial extends ProfileState {}

class ProfileLoading extends ProfileState {}

class GarageLoadSuccess extends ProfileState {
  final Garage garage;

  const GarageLoadSuccess({required this.garage});

  @override
  List<Object> get props => [garage];

  @override
  String toString() => 'UserLoadSuccess { user: $garage }';
}

class ProfileError extends ProfileState {}

class ProfileUpdating extends ProfileState {}

class ProfileUpdated extends ProfileState {}

class CheckPasswordSuccesss extends ProfileState {
  final bool status;
  const CheckPasswordSuccesss({required this.status});
}

class CheckPasswordError extends ProfileState {
  final bool status;
  const CheckPasswordError({required this.status});
}
