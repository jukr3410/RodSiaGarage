import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'dart:ui';
import 'package:rodsiagarage/constants.dart';
import 'package:rodsiagarage/core/models/service_model.dart';
import 'package:rodsiagarage/garage_manage_feature/bloc/service_bloc.dart';

class ServiceListScreen extends StatefulWidget {
  @override
  _ServiceListScreenState createState() => _ServiceListScreenState();
}

class _ServiceListScreenState extends State<ServiceListScreen> {
  ScrollController scrollController = ScrollController();
  late ServiceBloc _serviceBloc;

  final List<Service> _services = [];

  @override
  void initState() {
    _serviceBloc = BlocProvider.of<ServiceBloc>(context)..add(ServiceLoad());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: setAppBar(), body: body());
  }

  setAppBar() {
    return AppBar(
      backgroundColor: primaryColor,
      centerTitle: true,
      title: Text(
        tServiceGarage,
        style: TextStyle(color: textColorBlack, fontSize: fontSizeSemiLarge),
      ),
      leading: IconButton(
        icon: Icon(
          Icons.arrow_back,
          color: iconColorBlack,
        ),
        onPressed: () {
          Navigator.pop(context);
          // Let's create a new instance of the home page
          // Navigator.pushReplacement(
          //   context,
          //   MAIN_ROUTE
          // );
        },
      ),
      actions: [
        IconButton(
          icon: Icon(Icons.add, color: iconColorBlack),
          onPressed: () {
            navigateToAddService();
          },
          iconSize: 30.0,
        ),
      ],
    );
  }

  body() {
    return Container(
      margin: EdgeInsets.all(16.0),
      child: BlocConsumer<ServiceBloc, ServiceState>(
        listener: (context, state) {
          if (state is ServicesLoading) {
            // ScaffoldMessenger.of(context)
            //     .showSnackBar(SnackBar(content: Text(garageState.message)));

          } else if (state is ServicesLoadSuccess && state.services.isEmpty) {
            // ScaffoldMessenger.of(context)
            //     .showSnackBar(SnackBar(content: Text('No more garages')));
          } else if (state is ServicesError) {
            // ScaffoldMessenger.of(context)
            //     .showSnackBar(SnackBar(content: Text(garageState.error)));

            // showTopSnackBar(
            //   context,
            //   CustomSnackBar.error(
            //     message: mError,
            //   ),
            // );

          }
          return;
        },
        builder: (context, state) {
          if (state is ServiceInitial ||
              state is ServicesLoading && _services.isEmpty) {
            return Center(
                child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
              child: CircularProgressIndicator(),
            ));
          } else if (state is ServicesLoadSuccess) {
            _services.addAll(state.services);
            ScaffoldMessenger.of(context).hideCurrentSnackBar();
          } else if (state is ServicesError && _services.isEmpty) {
            return Center(
                child: Column(
              children: [
                IconButton(
                  onPressed: () {
                    _serviceBloc..add(ServiceLoad());
                  },
                  icon: Icon(Icons.refresh),
                ),
                const SizedBox(height: 15),
                Text(mError, textAlign: TextAlign.center),
              ],
            ));
          }
          return ListView.builder(
            itemBuilder: (context, index) => _makeCardWidget(_services[index]),
            itemCount: _services.length,
          );
        },
      ),
    );
  }

  _makeCardWidget(Service service) {
    return GestureDetector(
      child: Card(
        elevation: 3,
        margin: new EdgeInsets.symmetric(vertical: 8.0),
        color: cardColor,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: SizedBox(
                height: 60,
                width: 60,
                child: Icon(Icons.build_circle_outlined,
                    size: 40, color: iconColorBlack),
              ),
            ),
            Flexible(
                child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    service.name,
                    style: new TextStyle(
                        fontSize: fontSizeSemiLarge,
                        fontWeight: FontWeight.w600,
                        color: textColorBlack),
                  ),
                  Container(
                      margin: new EdgeInsets.only(top: 4),
                      child: Row(children: [
                        Text(
                          service.serviceType.name,
                          style: new TextStyle(
                              fontSize: fontSizeLow,
                              fontWeight: FontWeight.w600,
                              color: textColorBlack),
                        ),
                      ])),
                  Container(
                    margin: new EdgeInsets.only(top: 0),
                    child: Text(
                      service.description,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                      softWrap: false,
                      style: TextStyle(
                          fontSize: 14.0,
                          fontWeight: FontWeight.normal,
                          color: textColorBlack),
                    ),
                  )
                ],
              ),
            )),
          ],
        ),
      ),
      onTap: () {
        Navigator.pushNamed(context, EDIT_SERVICE_ROUTE);
      },
    );
  }

  void navigateToAddService() {
    Navigator.pushNamed(context, ADD_SERVICE_ROUTE);
  }

  void navigateToServiceEdit() {
    Navigator.pushNamed(context, EDIT_SERVICE_ROUTE);
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }
}
