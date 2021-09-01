part of 'add_service_bloc.dart';

abstract class AddServiceEvent extends Equatable {
  const AddServiceEvent();

  @override
  List<Object> get props => [];
}

class AddServiceClick extends AddServiceEvent {
  final Service service;

  const AddServiceClick({required this.service});
}
