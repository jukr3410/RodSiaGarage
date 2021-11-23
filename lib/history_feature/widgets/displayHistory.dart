import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rodsiagarage/core/models/garage_model.dart';
import 'package:rodsiagarage/core/repository/request_service_repository.dart';
import 'package:rodsiagarage/history_feature/bloc/request_service_bloc.dart';
import 'package:rodsiagarage/history_feature/widgets/listHistory.dart';

class DisplayHistory extends StatelessWidget {
  final Garage garage;
  const DisplayHistory({Key? key, required this.garage}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
          create: (context) => RequestServiceBloc(
              requestServiceRepository: RequestServiceRepository()),
          child: Listhistory(garage: garage)),
    );
  }
}
