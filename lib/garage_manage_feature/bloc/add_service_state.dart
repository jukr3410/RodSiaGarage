part of 'add_service_bloc.dart';

abstract class AddServiceState extends Equatable {
  const AddServiceState();

  @override
  List<Object> get props => [];
}

class AddServiceInitial extends AddServiceState {}

class AddServiceError extends AddServiceState {
  final String error;

  AddServiceError({required this.error});
}

class AddingService extends AddServiceState {}

class ServiceAdded extends AddServiceState {}
