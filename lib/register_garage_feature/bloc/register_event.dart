part of 'register_bloc.dart';

abstract class RegisterEvent extends Equatable {
  const RegisterEvent();

  @override
  List<Object> get props => [];
}

class RegisterButtonPressed extends RegisterEvent {
  final Garage garage;

  const RegisterButtonPressed({required this.garage});

  @override
  String toString() => 'Register {garage: $garage}';
}

class RegisterCheckPhoneNumber extends RegisterEvent {
  final String phoneNumber;

  const RegisterCheckPhoneNumber({required this.phoneNumber});

  @override
  List<Object> get props => [phoneNumber];

  @override
  String toString() => 'RegisterCheckPhoneNumber phoneNumber: ${phoneNumber}';
}

class RegisterAddNumber extends RegisterEvent {
  final Garage garage;

  const RegisterAddNumber({required this.garage});

  @override
  List<Object> get props => [garage];

  @override
  String toString() => 'RegisterAddNumber garage: ${garage}';
}

class RegisterVerifyOtp extends RegisterEvent {
  final Garage garage;

  const RegisterVerifyOtp({required this.garage});

  @override
  List<Object> get props => [garage];

  @override
  String toString() => 'Register garage: ${garage}';
}

class RegisterSendOtp extends RegisterEvent {
  final Garage garage;

  const RegisterSendOtp({required this.garage});

  @override
  List<Object> get props => [garage];

  @override
  String toString() => 'RegisterSendOtpAgian garage: ${garage}';
}

class ResetCheckPhoneNumber extends RegisterEvent {
  final Garage garage;

  const ResetCheckPhoneNumber({required this.garage});

  @override
  List<Object> get props => [garage];

  @override
  String toString() => 'RegisterAddNumber garage: ${garage.toJson()}';
}

class ResetButtonPressed extends RegisterEvent {
  final Garage garage;

  const ResetButtonPressed({required this.garage});

  @override
  String toString() => 'Register {garage: $garage}';
}
