import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:rodsiagarage/core/models/garage_model.dart';
import 'package:rodsiagarage/core/repository/garage_api.dart';
import 'package:rodsiagarage/core/repository/garage_repository.dart';
import 'package:rodsiagarage/main.dart';

part 'garage_info_event.dart';
part 'garage_info_state.dart';

class GarageInfoBloc extends Bloc<GarageInfoEvent, GarageInfoState> {
  final GarageRepository garageRepository;
  GarageApi garageApi = GarageApi();
  GarageInfoBloc({required this.garageRepository}) : super(GarageInfoInitial());

  @override
  Stream<GarageInfoState> mapEventToState(GarageInfoEvent event) async* {
    if (event is GarageInfoLoad) {
      try {
        final garage = await this.garageRepository.getGarageInfoPhone();
        yield GarageInfoLoadSuccess(garage: garage);
      } catch (e) {
        logger.e(e);
        yield GarageInfoError();
      }
    }
  }
}
