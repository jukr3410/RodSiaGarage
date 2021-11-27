import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:fswitch/fswitch.dart';
import 'package:locally/locally.dart';
import 'package:rodsiagarage/constants.dart';
import 'package:rodsiagarage/core/models/garage_model.dart';
import 'package:rodsiagarage/core/repository/request_service_api.dart';
import 'package:rodsiagarage/core/repository/request_service_repository.dart';
import 'package:rodsiagarage/global_widgets/alertPopupBackHomePage.dart';
import 'package:rodsiagarage/global_widgets/bottomBar.dart';
import 'package:rodsiagarage/history_feature/bloc/request_service_bloc.dart';
import 'package:rodsiagarage/home_feature/bloc/garage_info_bloc.dart';

class CustomAppBar extends StatefulWidget {
  @override
  _CustomAppBarState createState() => _CustomAppBarState();
}

class _CustomAppBarState extends State<CustomAppBar> {
  bool status = true;

  late GarageInfoBloc _garageInfoBloc;

  @override
  void initState() {
    _garageInfoBloc = BlocProvider.of<GarageInfoBloc>(context)
      ..add(GarageInfoLoad());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<GarageInfoBloc, GarageInfoState>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        if (state is GarageInfoLoadSuccess) {
          return SafeArea(
            child: Scaffold(
                resizeToAvoidBottomInset: false,
                bottomNavigationBar: BlocProvider(
                    create: (context) => RequestServiceBloc(
                        requestServiceRepository: RequestServiceRepository()),
                    child: BottomNavigrationBar(garage: state.garage)),
                body: Center(
                  child: Column(
                    children: [
                      TextButton(
                          onPressed: () {
                            navigateToService();
                          },
                          child: Text("Service")),
                      TextButton(
                          onPressed: () {
                            trackingRequestService();
                          },
                          child: Text('Tracking')),
                    ],
                  ),
                )),
          );
        }
        return Container(
          color: textColorWhite,
          child: Center(
              child: CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(primaryColor),
          )),
        );
      },
    );
  }

  void navigateToService() {
    Navigator.pushNamed(context, SERVICE_LIST_ROUTE);
  }

  void trackingRequestService() {
    Navigator.pushNamed(context, TRACKING_REQUEST_ROUTE);
  }
}
