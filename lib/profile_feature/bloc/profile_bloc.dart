import 'dart:async';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:rodsiagarage/core/models/garage_login.dart';
import 'package:rodsiagarage/core/models/garage_model.dart';
import 'package:rodsiagarage/core/models/user_model.dart';
import 'package:rodsiagarage/core/repository/garage_repository.dart';

import '../../main.dart';

part 'profile_event.dart';
part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  final GarageRepository garageRepository;
  StreamSubscription? _servicesSubscription;

  ProfileBloc({required this.garageRepository}) : super(ProfileInitial());

  String mockUserId = "6129f203748ba19d14a2c1df";

  @override
  Stream<ProfileState> mapEventToState(
    ProfileEvent event,
  ) async* {
    if (event is ProfileLoadFormPhone) {
      yield* _mapGarageFormPhoneLoadToState();
    } else if (event is CheckPassword) {
      yield* _checkPasswordToState(event.garageLogin);
    } else if (event is GarageUpdateNoPassword) {
      yield* _mapGarageUpdateNoPasswordToState(event.garage, event.image);
    } else if (event is GarageUpdatePassword) {
      yield* _mapGarageUpdatePasswordToState(event.garage);
    } else if (event is UploadImage) {
      yield* _uploadImageToState(event.image);
    } else if (event is UploadImageProfile) {
      yield* _uploadImageProfileToState(event.image);
    } else if (event is UploadMultiImage) {
      yield* _uploadMultiImageToState(event.images);
    }
  }

  Stream<ProfileState> _mapServiceLoadToState() async* {
    try {
      final garage = await this.garageRepository.getGarageInfo(id: mockUserId);
      yield GarageLoadSuccess(garage: garage);
    } catch (e) {
      logger.e(e);
      yield ProfileError();
    }
  }

  Stream<ProfileState> _mapGarageFormPhoneLoadToState() async* {
    try {
      final garage = await this.garageRepository.getGarageInfoPhone();
      yield GarageLoadSuccess(garage: garage);
    } catch (e) {
      logger.e(e);
      yield ProfileError();
    }
  }

  Stream<ProfileState> _mapGarageUpdateToState(Garage garage) async* {
    try {
      yield ProfileUpdating();
      final res = await this.garageRepository.updateGarage(garage: garage);
      yield ProfileUpdated();
    } catch (e) {
      logger.e(e);
      yield ProfileError();
    }
  }

  Stream<ProfileState> _mapGarageUpdateNoPasswordToState(
      Garage garage, File? image) async* {
    try {
      yield ProfileUpdating();
      await this.garageRepository.updateGarageNoPassword(garage: garage);
      if (image != null) {
        await this.garageRepository.updateGarageProfile(image: image);
      }
      yield ProfileUpdated();
    } catch (e) {
      logger.e(e);
      yield ProfileError();
    }
  }

  Stream<ProfileState> _mapGarageUpdatePasswordToState(Garage garage) async* {
    try {
      yield ProfileUpdating();
      await this.garageRepository.updateGaragePassword(garage: garage);
      yield ProfileUpdated();
    } catch (e) {
      logger.e(e);
      yield ProfileError();
    }
  }

  Stream<ProfileState> _checkPasswordToState(GarageLogin garageLogin) async* {
    try {
      bool status =
          await this.garageRepository.checkPassword(garageLogin: garageLogin);
      if (status == true) {
        yield CheckPasswordSuccesss(status: status);
      } else {
        yield CheckPasswordError(status: status);
      }
    } catch (e) {
      logger.e(e);
      yield ProfileError();
    }
  }

  Stream<ProfileState> _uploadImageToState(File image) async* {
    try {
      bool status = await this.garageRepository.updateGarageImage(image: image);
      if (status == true) {
        yield UploadImageSuccess();
      }
    } catch (e) {
      logger.e(e);
      yield ProfileError();
    }
  }

  Stream<ProfileState> _uploadImageProfileToState(File image) async* {
    try {
      bool status =
          await this.garageRepository.updateGarageProfile(image: image);
      if (status == true) {
        yield UploadImageSuccess();
      }
    } catch (e) {
      logger.e(e);
      yield ProfileError();
    }
  }

  Stream<ProfileState> _uploadMultiImageToState(List<File> images) async* {
    try {
      bool status =
          await this.garageRepository.updateGarageMultiImage(images: images);
      if (status == true) {
        yield UploadImageSuccess();
      }
    } catch (e) {
      logger.e(e);
      yield ProfileError();
    }
  }

  @override
  Future<void> close() {
    _servicesSubscription?.cancel();
    return super.close();
  }
}
