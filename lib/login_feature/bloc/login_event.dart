part of 'login_bloc.dart';

abstract class LoginEvent extends Equatable {
  const LoginEvent();

  @override
  List<Object> get props => [];
}

class LoginButtonPressed extends LoginEvent {
  final String phone;
  final String password;

  const LoginButtonPressed({required this.phone, required this.password});

  @override
  List<Object> get props => [phone, password];

  @override
  String toString() =>
      'LoginButtonPressed { phone: $phone, password: $password }';
}
