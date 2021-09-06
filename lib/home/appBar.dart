import 'package:flutter/material.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:fswitch/fswitch.dart';
import 'package:rodsiagarage/constants.dart';
import 'package:rodsiagarage/global_widgets/alertPopupBackHomePage.dart';

class CustomAppBar extends StatefulWidget {
  @override
  _CustomAppBarState createState() => _CustomAppBarState();
}

class _CustomAppBarState extends State<CustomAppBar> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: setAppBar(),
      body: AlertPopupBackHomePage(),
    );
  }

  setAppBar() {
    return AppBar(
      // centerTitle: true,
      backgroundColor: primaryColor,
      centerTitle: true,
      title: Row(mainAxisSize: MainAxisSize.min, children: <Widget>[
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 0),
          child: Container(
            alignment: Alignment.center,
            child: Row(
              children: [
                // LiteRollingSwitch(
                //   value: true,
                //   textOn: '  Online',
                //   textOff: '  Offline',
                //   colorOn: Colors.green,
                //   colorOff: Colors.blueGrey,
                //   // iconOn: Icons.online_prediction_rounded,
                //   // iconOff: Icons.power_settings_new,
                //   onChanged: (value) {
                //     print('turned ${(value) ? 'on' : 'off'}');
                //   },
                // ),
                FSwitch(
                  open: true,
                  height: 30,
                  width: 70,
                  onChanged: (v) {},
                  closeChild: Text(
                    'Offline',
                    style: TextStyle(fontSize: 12),
                  ),
                  openChild: Text(
                    'Online',
                    style: TextStyle(fontSize: 12),
                  ),
                  openColor: Colors.green,
                ),
              ],
            ),
          ),
        ),
      ]),
      actions: [
        TextButton(
            onPressed: () {},
            child: ImageIcon(
              AssetImage('assets/images/icon-notify.png'),
              color: textColorBlack,
            )),
        TextButton(
            onPressed: () {
              navigateToService();
            },
            child: Text("Service")),
      ],
    );
  }

  void navigateToService() {
    Navigator.pushNamed(context, SERVICE_LIST_ROUTE);
  }
}
