import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'dart:ui';
import 'package:rodsiagarage/constants.dart';
import 'package:rodsiagarage/core/models/garage_model.dart';
import 'package:rodsiagarage/core/models/service_model.dart';
import 'package:rodsiagarage/garage_manage_feature/bloc/service_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:rodsiagarage/garage_manage_feature/widgets/editService.dart';
import 'package:rodsiagarage/garage_manage_feature/widgets/showInfoService.dart';
import 'package:rodsiagarage/global_widgets/alertPopupYesNo.dart';

class ServiceListScreen extends StatefulWidget {
  final Garage garage;

  ServiceListScreen({required this.garage});
  @override
  _ServiceListScreenState createState() => _ServiceListScreenState();
}

class _ServiceListScreenState extends State<ServiceListScreen> {
  ScrollController scrollController = ScrollController();
  late ServiceBloc _serviceBloc;

  List<Service> _services = [];

  @override
  void initState() {
    _serviceBloc = BlocProvider.of<ServiceBloc>(context)
      ..add(ServiceLoad(garageId: widget.garage.id));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: setAppBar(),
      body: Container(
        margin: EdgeInsets.all(defualtPaddingLow),
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
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(primaryColor),
                ),
              ));
            } else if (state is ServicesLoadSuccess) {
              _services = state.services;
              ScaffoldMessenger.of(context).hideCurrentSnackBar();
            } else if (state is ServicesError && _services.isEmpty) {
              return Center(
                  child: Column(
                children: [
                  IconButton(
                    onPressed: () {
                      _serviceBloc
                        ..add(ServiceLoad(garageId: widget.garage.id));
                    },
                    icon: Icon(Icons.refresh),
                  ),
                  const SizedBox(height: 15),
                  Text(mError, textAlign: TextAlign.center),
                ],
              ));
            }
            return new Container(
              color: Colors.white,
              child: ListView.builder(
                itemCount: _services.length,
                itemBuilder: (context, index) => Slidable(
                  actionPane: SlidableDrawerActionPane(),
                  actionExtentRatio: 0.18,
                  child: _makeCardWidget(context, _services[index]),
                  closeOnScroll: true,
                  movementDuration: Duration(seconds: 2),
                  actions: <Widget>[
                    new IconSlideAction(
                      caption: tEdit,
                      color: primaryColor,
                      icon: Icons.edit_outlined,
                      onTap: () {
                        _navigateAndDisplayEdit(context, _services[index]);
                      },
                    ),
                    new IconSlideAction(
                      caption: tDelete,
                      color: Colors.red,
                      icon: Icons.delete,
                      onTap: () {
                        _navigateAndDisplayDelete(context, _services[index]);
                      },
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          navigateToAddService(widget.garage);
        },
        backgroundColor: primaryColor,
        icon: Icon(
          Icons.add,
          color: iconColorBlack,
          size: 30,
        ),
        label: Text(
          tAddService,
          style: TextStyle(color: textColorBlack, fontSize: fontSizeL),
        ),
      ),
    );
  }

  setAppBar() {
    return AppBar(
      iconTheme: IconThemeData(color: textColorBlack),
      backgroundColor: primaryColor,
      centerTitle: true,
      title: Text(
        tServiceGarage,
        style: TextStyle(color: textColorBlack, fontSize: fontSizeXl),
      ),
      leading: IconButton(
          icon: Icon(Icons.arrow_back_ios, color: textColorBlack),
          onPressed: () =>
              Navigator.of(context).popUntil((route) => route.isFirst)),
      actions: [
        // IconButton(
        //   icon: Icon(Icons.add, color: iconColorBlack),
        //   onPressed: () {
        //     navigateToAddService();
        //   },
        //   iconSize: 30.0,
        // ),
      ],
    );
  }

  _makeCardWidget(BuildContext context, Service service) {
    return GestureDetector(
      child: Card(
        elevation: 3,
        // margin: new EdgeInsets.symmetric(vertical: 8.0),
        color: cardColor,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
                padding: const EdgeInsets.only(
                  left: 15.0,
                ),
                child: Image.asset(
                  tImageAsset(service.serviceType.name),
                  width: 40,
                )),
            Flexible(
                child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 13.0, vertical: 8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    service.name,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                    softWrap: false,
                    style: new TextStyle(
                        fontSize: fontSizeL,
                        fontWeight: FontWeight.w600,
                        color: textColorBlack),
                  ),
                  // Text(
                  //   service.serviceType!.name,
                  //   overflow: TextOverflow.ellipsis,
                  //   maxLines: 1,
                  //   softWrap: false,
                  //   style: new TextStyle(
                  //       fontSize: fontSizeM,
                  //       fontWeight: FontWeight.w600,
                  //       color: textColorBlack),
                  // ),
                  Text(
                    service.description!,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                    softWrap: false,
                    style: TextStyle(
                        fontSize: 14.0,
                        fontWeight: FontWeight.normal,
                        color: textColorBlack),
                  )
                ],
              ),
            )),
          ],
        ),
      ),
      onTap: () {
        _navigateToShowInfoService(context, service);
      },
    );
  }

  void navigatorToListSerivce() {
    Navigator.pushNamed(context, SERVICE_LIST_ROUTE, arguments: widget.garage);
  }

  Future<void> navigateToAddService(Garage garage) async {
    await Navigator.pushNamed(context, ADD_SERVICE_ROUTE, arguments: garage);
  }

  void _navigateAndDisplayDelete(BuildContext context, Service service) async {
    final result = await showDialog<String>(
        context: context,
        builder: (BuildContext context) =>
            AlertPopupYesNo(title: 'คุณต้องการลบบริการนี้ใช้ไหม'));
    if (result == 'Ok') {
      _serviceBloc.add(ServiceDelete(service));
      // new Future.delayed(const Duration(seconds: 3), () {
      //   navigatorToListSerivce();
      // });
      navigatorToListSerivce();
    }
  }

  void _navigateToShowInfoService(BuildContext context, Service service) {
    showDialog<String>(
        context: context,
        builder: (BuildContext context) => ShowInfoService(service: service));
  }

  void _navigateAndDisplayEdit(BuildContext context, Service service) async {
    final result = await showDialog<String>(
        context: context,
        builder: (BuildContext context) =>
            AlertPopupYesNo(title: 'คุณต้องการแก้ไขบริการนี้ใช้ไหม'));
    if (result == 'Ok') {
      navigateToServiceEdit(service);
    }
  }

  void navigatorToDelete() {
    // Navigator.push(
    //     context,
    //     MaterialPageRoute(
    //         builder: (BuildContext context) => ProfilePage(user: widget.user)));
  }

  void navigateToServiceEdit(Service service) async {
    await Navigator.pushNamed(context, EDIT_SERVICE_ROUTE,
        arguments: EditService(garage: widget.garage, service: service));
    // this._services = [];
    // _serviceBloc..add(ServiceLoad());
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }
}
