import 'package:flutter/material.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:fswitch/fswitch.dart';
import 'package:rodsiagarage/constants.dart';
import 'package:rodsiagarage/global_widgets/alertPopupBackHomePage.dart';
import 'package:rodsiagarage/global_widgets/bottomBar.dart';

class CustomAppBar extends StatefulWidget {
  @override
  _CustomAppBarState createState() => _CustomAppBarState();
}

class _CustomAppBarState extends State<CustomAppBar> {
  bool status = true;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          backgroundColor: primaryColor,
          resizeToAvoidBottomInset: false,
          bottomNavigationBar: BottomNavigrationBar(),
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

  void navigateToService() {
    Navigator.pushNamed(context, SERVICE_LIST_ROUTE);
  }

  void trackingRequestService() {
    Navigator.pushNamed(context, TRACKING_REQUEST_ROUTE);
  }
}
