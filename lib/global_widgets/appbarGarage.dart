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
    return AppBar(
      // centerTitle: true,
      backgroundColor: primaryColor,
      actions: [
        LiteRollingSwitch(
          value: true,
          textOn: 'active',
          textOff: 'inactive',
          colorOn: Colors.deepOrange,
          colorOff: Colors.blueGrey,
          iconOn: Icons.lightbulb_outline,
          iconOff: Icons.power_settings_new,
          onChanged: (bool state) {
            print('turned ${(state) ? 'on' : 'off'}');
          },
        ),
        TextButton(
            onPressed: () {},
            child: ImageIcon(AssetImage('assets/images/icon-notify.png'))),
       
      ],
    );
  }
}
