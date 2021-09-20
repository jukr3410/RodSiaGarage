import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
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
    // TODO: implement mapEventToState
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

  Stream<ProfileState> _mapUserUpdateToState(GarageUpdate event) async* {
    try {
      yield ProfileUpdating();
      final res = await this.garageRepository.updateGarage(garage: event.garage);
      yield ProfileUpdated();
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
