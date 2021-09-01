import 'package:flutter/material.dart';
// import 'package:flutter_switch/flutter_switch.dart';
import 'package:getwidget/components/toggle/gf_toggle.dart';
import 'package:getwidget/getwidget.dart';
import 'package:rodsiagarage/constants.dart';

class AppbarGarage extends StatefulWidget {
  AppbarGarage({Key? key}) : super(key: key);

  @override
  _AppbarGarageState createState() => _AppbarGarageState();
}

class _AppbarGarageState extends State<AppbarGarage> {
  bool statusOpen = false;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      centerTitle: true,
      backgroundColor: primaryColor,
      actions: [
        // FlutterSwitch(
        //   height: 20.0,
        //   width: 40.0,
        //   padding: 4.0,
        //   toggleSize: 15.0,
        //   borderRadius: 10.0,
        //   activeColor: primaryColor,
        //   value: statusOpen,
        //   onToggle: (value) {},
        // ),
        TextButton(
            onPressed: () {},
            child: ImageIcon(AssetImage('assets/images/icon-notify.png'))),
        GFToggle(
          onChanged: (value) {},
          value: statusOpen,
        )
      ],
    );
  }
}
