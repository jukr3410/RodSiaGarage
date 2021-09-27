import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'dart:ui';
import 'package:rodsiagarage/constants.dart';
import 'package:rodsiagarage/core/models/service_model.dart';
import 'package:rodsiagarage/garage_manage_feature/bloc/service_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:rodsiagarage/global_widgets/alertPopupYesNo.dart';

class ServiceListScreen extends StatefulWidget {
  @override
  _ServiceListScreenState createState() => _ServiceListScreenState();
}

class _ServiceListScreenState extends State<ServiceListScreen> {
  ScrollController scrollController = ScrollController();
  late ServiceBloc _serviceBloc;

  List<Service> _services = [];

  @override
  void initState() {
    _serviceBloc = BlocProvider.of<ServiceBloc>(context)..add(ServiceLoad());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: setAppBar(),
      body: body(),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          navigateToAddService();
        },
        backgroundColor: primaryColor,
        icon: Icon(
          Icons.add,
          color: iconColorBlack,
          size: 30,
        ),
        label: Text(
          tAddService,
          style: TextStyle(color: textColorBlack, fontSize: fontSizeMedium),
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
        style: TextStyle(color: textColorBlack, fontSize: fontSizeSemiLarge),
      ),
      // leading: IconButton(
      //   icon: Icon(
      //     Icons.arrow_back,
      //     color: iconColorBlack,
      //   ),
      //   onPressed: () {
      //     navigateToMain();

      //   },
      // ),
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

  body() {
    return Container(
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
          return new Container(
            color: Colors.white,
            child: ListView.builder(
              itemCount: _services.length,
              itemBuilder: (context, index) => Slidable(
                actionPane: SlidableDrawerActionPane(),
                actionExtentRatio: 0.18,
                child: _makeCardWidget(_services[index]),
                closeOnScroll: true,
                movementDuration: Duration(seconds: 2),
                actions: <Widget>[
                  new IconSlideAction(
                    caption: tEdit,
                    color: primaryColor,
                    icon: Icons.edit_outlined,
                    onTap: () {
                      navigateToServiceEdit(_services[index]);
                    },
                  ),
                  new IconSlideAction(
                    caption: tDelete,
                    color: Colors.red,
                    icon: Icons.delete,
                    onTap: () {
                      _navigateAndDisplayDelete(context, index);
                    },
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  _makeCardWidget(Service service) {
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
              child: Icon(Icons.build_circle_outlined,
                  size: 45, color: iconColorBlack),
            ),
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
                        fontSize: fontSizeMedium,
                        fontWeight: FontWeight.w600,
                        color: textColorBlack),
                  ),
                  // Text(
                  //   service.serviceType!.name,
                  //   overflow: TextOverflow.ellipsis,
                  //   maxLines: 1,
                  //   softWrap: false,
                  //   style: new TextStyle(
                  //       fontSize: fontSizeLow,
                  //       fontWeight: FontWeight.w600,
                  //       color: textColorBlack),
                  // ),
                  Text(
                    service.description,
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
        //Navigator.pushNamed(context, EDIT_SERVICE_ROUTE);
        // navigateToServiceEdit(service);
      },
    );
  }

  void navigateToMain() {
    Navigator.pop(context);
  }

  Future<void> navigateToAddService() async {
    await Navigator.pushNamed(context, ADD_SERVICE_ROUTE);
    this._services = [];
    _serviceBloc..add(ServiceLoad());
  }

  void _navigateAndDisplayDelete(BuildContext context, int index) async {
    final result = await showDialog<String>(
        context: context,
        builder: (BuildContext context) =>
            AlertPopupYesNo(title: 'คุณต้องการลบบริการนี้ใช้ไหม'));
    if (result == 'Ok') {
      navigatorToDelete();
    }
  }

  void _navigateAndDisplayEdit(BuildContext context, int index) async {
    final result = await showDialog<String>(
        context: context,
        builder: (BuildContext context) =>
            AlertPopupYesNo(title: 'คุณต้องการแก้ไขบริการนี้ใช้ไหม'));
    if (result == 'Ok') {
      // navigateToServiceEdit(service);
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
        arguments: {'service': service});
    // this._services = [];
    // _serviceBloc..add(ServiceLoad());
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }
}
