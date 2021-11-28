import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:rodsiagarage/core/models/garage_model.dart';
import 'package:rodsiagarage/core/repository/garage_api.dart';
import 'package:rodsiagarage/core/repository/garage_repository.dart';
import 'package:rodsiagarage/main.dart';

part 'register_event.dart';
part 'register_state.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  final GarageRepository garageRepository;
  StreamSubscription? _garagesSubscription;

  GarageApi garageApi = GarageApi();

  RegisterBloc({required this.garageRepository}) : super(RegisterInitial());

  @override
  Stream<RegisterState> mapEventToState(
    RegisterEvent event,
  ) async* {
    if (event is RegisterAddNumber) {
      yield* _mapRegisterAddNumberToState(event);
    } else if (event is RegisterVerifyOtp) {
      yield* _mapRegisterVerifyOtpToState(event);
    } else if (event is RegisterSendOtp) {
      yield* _mapRegisterSendOtpToState(event);
    } else if (event is RegisterButtonPressed) {
      yield* _mapRegisterButtonPressedToState(event);
    } else if (event is ResetButtonPressed) {
      yield* _mapResetButtonPressedToState(event);
    } else if (event is ResetCheckPhoneNumber) {
      yield* _mapResetCheckPhoneNumberToState(event);
    } else {
      yield RegisterInitial();
    }
  }

  Stream<RegisterState> _mapRegisterAddNumberToState(
      RegisterAddNumber event) async* {
    try {
      yield RegisterLoading();
      // test
      //yield RegisterAddNumberSuccess();

      var isPhoneNumberExist = await this
          .garageRepository
          .checkUsedNumberPhone(garage: event.garage);
      logger.d("isPhoneNumberExist: $isPhoneNumberExist");

      if (isPhoneNumberExist == false) {
        var addedNumber =
            await this.garageRepository.addGarage(garage: event.garage);
        logger.d("addedNumber: $addedNumber");
        if (addedNumber == true) {
          yield RegisterAddNumberSuccess();
        } else if (addedNumber == false) {
          yield RegisterError();
        }
        //yield RegisterAddNumberSuccess();
      } else if (isPhoneNumberExist == true) {
        yield RegisterAddNumberExist();
      }
    } catch (e) {
      logger.e(e);
      yield RegisterError();
    }
  }

  Stream<RegisterState> _mapRegisterVerifyOtpToState(
      RegisterVerifyOtp event) async* {
    try {
      yield RegisterLoading();
      // test
      // yield RegisterVerifySuccess();

      var isSuccess =
          await this.garageRepository.verifyOtpGarage(garage: event.garage);
      if (isSuccess == true) {
        yield RegisterVerifySuccess();
      } else {
        yield RegisterVerifyFailed();
      }
    } catch (e) {
      logger.e(e);
      yield RegisterError();
    }
  }

  Stream<RegisterState> _mapRegisterSendOtpToState(
      RegisterSendOtp event) async* {
    try {
      yield RegisterLoading();
      // test
      //yield RegisterSendVerifyOtpSuccess();

      var isSendOtp = await this
          .garageRepository
          .requestSendOtpGarage(garage: event.garage);
      logger.d("RegisterSendOtp: $isSendOtp");
      if (isSendOtp == true) {
        yield RegisterSendVerifyOtpSuccess();
      } else {
        yield RegisterError();
      }
    } catch (e) {
      logger.e(e);
      yield RegisterError();
    }
  }

  Stream<RegisterState> _mapRegisterButtonPressedToState(
      RegisterButtonPressed event) async* {
    try {
      yield RegisterLoading();

      var isRegisted =
          await this.garageRepository.updateGarage(garage: event.garage);
      if (isRegisted == true) {
        yield RegisterSuccess();
      } else {
        yield RegisterError();
      }
    } catch (e) {
      logger.e(e);
      yield RegisterError();
    }
  }

  Stream<RegisterState> _mapResetCheckPhoneNumberToState(
      ResetCheckPhoneNumber event) async* {
    try {
      yield ResetLoading();
      logger.d("Phone: ${event.garage.phone}");
      var isPhoneNumberExist = await this
          .garageRepository
          .checkUsedNumberPhone(garage: event.garage);
      logger.d("isPhoneNumberExist: $isPhoneNumberExist");

      if (isPhoneNumberExist == false) {
        yield ResetNumberNotExist();
      } else if (isPhoneNumberExist == true) {
        yield ResetNumberExist();
      }
    } catch (e) {
      logger.e(e);
      yield RegisterError();
    }
  }

  Stream<RegisterState> _mapResetButtonPressedToState(
      ResetButtonPressed event) async* {
    try {
      yield ResetLoading();

      final res = await this
          .garageRepository
          .updateGaragePassword(garage: event.garage);
      yield ResetSuccess();
    } catch (e) {
      logger.e(e);
      yield ResetError();
    }
  }

  @override
  Future<void> close() {
    _garagesSubscription?.cancel();
    return super.close();
  }
}
