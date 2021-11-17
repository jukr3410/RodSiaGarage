part of 'garage_info_bloc.dart';

abstract class GarageInfoEvent extends Equatable {
  const GarageInfoEvent();

  @override
  List<Object> get props => [];
}

class GarageInfoInitializeEvent extends GarageInfoEvent {}

class GarageInfoLoad extends GarageInfoEvent {}
