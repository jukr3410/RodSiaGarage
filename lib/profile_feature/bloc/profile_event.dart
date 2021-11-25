part of 'profile_bloc.dart';

abstract class ProfileEvent extends Equatable {
  const ProfileEvent();

  @override
  List<Object> get props => [];
}

class ProfileLoad extends ProfileEvent {}

class ProfileLoadFormPhone extends ProfileEvent {}

class GarageUpdate extends ProfileEvent {
  final Garage garage;

  const GarageUpdate(this.garage);

  @override
  List<Object> get props => [garage];

  @override
  String toString() => 'UserUpdate {user: $garage}';
}

class GarageUpdateNoPassword extends ProfileEvent {
  final Garage garage;
  final File? image;

  const GarageUpdateNoPassword({required this.garage, this.image});

  @override
  List<Object> get props => [garage];

  @override
  String toString() => 'UserUpdate {user: $garage}';
}

class GarageUpdatePassword extends ProfileEvent {
  final Garage garage;

  const GarageUpdatePassword(this.garage);

  @override
  List<Object> get props => [garage];

  @override
  String toString() => 'UserUpdate {user: $garage}';
}

class CheckPassword extends ProfileEvent {
  final GarageLogin garageLogin;
  const CheckPassword({required this.garageLogin});
}

class UploadImage extends ProfileEvent {
  final File image;
  const UploadImage({required this.image});
}

class UploadImageProfile extends ProfileEvent {
  final File image;
  const UploadImageProfile({required this.image});
}

class UploadMultiImage extends ProfileEvent {
  final List<File> images;
  const UploadMultiImage({required this.images});
}
