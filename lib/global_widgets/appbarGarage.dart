import 'package:flutter/material.dart';
import 'package:lite_rolling_switch/lite_rolling_switch.dart';
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
    return _appBar;
  }
}

AppBar _appBar = AppBar(
  // centerTitle: true,
  backgroundColor: primaryColor,
  actions: [
    Padding(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 65),
      child: Container(
        alignment: Alignment.center,
        child: LiteRollingSwitch(
          value: true,
          textOn: '  Online',
          textOff: '  Offline',
          colorOn: Colors.green,
          colorOff: Colors.blueGrey,
          iconOn: Icons.online_prediction_rounded,
          iconOff: Icons.power_settings_new,
          onChanged: (value) {
            print('turned ${(value) ? 'on' : 'off'}');
          },
        ),
      ),
    ),
    TextButton(
        onPressed: () {},
        child: ImageIcon(
          AssetImage('assets/images/icon-notify.png'),
          color: textColorBlack,
        )),
  ],
);
