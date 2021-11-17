part of 'garage_info_bloc.dart';

abstract class GarageInfoState extends Equatable {
  const GarageInfoState();

  @override
  List<Object> get props => [];
}

class GarageInfoInitial extends GarageInfoState {}

class GarageInfoLoading extends GarageInfoState {}

class GarageInfoLoadSuccess extends GarageInfoState {
  final Garage garage;

  const GarageInfoLoadSuccess({required this.garage});

  @override
  List<Object> get props => [garage];

  @override
  String toString() =>
      'ServicesLoadSuccess { garage: ${garage.toJson()} }';
}

class GarageInfoError extends GarageInfoState {}
