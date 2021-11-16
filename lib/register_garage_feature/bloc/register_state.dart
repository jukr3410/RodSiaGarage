part of 'register_bloc.dart';

abstract class RegisterState extends Equatable {
  const RegisterState();

  @override
  List<Object> get props => [];
}

class RegisterInitial extends RegisterState {}

class RegisterError extends RegisterState {}

class RegisterLoading extends RegisterState {}

class RegisterSuccess extends RegisterState {}

class RegisterAddNumberSuccess extends RegisterState {}

class RegisterAddNumberExist extends RegisterState {}

class RegisterSendVerifyOtpSuccess extends RegisterState {}

class RegisterVerifySuccess extends RegisterState {}

class RegisterVerifyFailed extends RegisterState {}
