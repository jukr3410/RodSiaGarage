import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:getwidget/getwidget.dart';
import 'package:rodsiagarage/constants.dart';
import 'package:rodsiagarage/global_widgets/hexTocolor.dart';

class AlertRequestService extends StatefulWidget {
  AlertRequestService({Key? key}) : super(key: key);

  @override
  _AlertRequestServiceState createState() => _AlertRequestServiceState();
}

class _AlertRequestServiceState extends State<AlertRequestService> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: cardWidthMedium,
        decoration: BoxDecoration(
          borderRadius: borderRadiusMedium,
          boxShadow: [boxShadow],
          color: bgColor,
        ),
        child: Padding(
          padding: const EdgeInsets.only(top: defualtPaddingMedium),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            // crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisSize: MainAxisSize.min,
            children: [
              Image(image: AssetImage('assets/images/icon-battery.png')),
              SizedBox(height: 20),
              Text(
                tAlertRequestService,
                style: TextStyle(fontSize: 18),
              ),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('ชื่อ: '),
                  Text('XXXXXXXX'),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('ยานภาหนะ: '),
                  Text('Honda Civic 1.6L'),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('บริการ: '),
                  Text('แบตเตอรี่'),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('ระยะทาง: '),
                  Text('2.5 กิโลเมตร'),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('รายละเอียดเพื่มเติม: '),
                  Flexible(
                      child: Text(
                    'xxxxxxxxxxxxx',
                    softWrap: true,
                  )),
                ],
              ),
              SizedBox(height: defualtPaddingHight),
              Container(
                height: buttonHeightMedium,
                width: double.infinity,
                child: TextButton(
                  style: TextButton.styleFrom(
                    textStyle: TextStyle(
                      fontSize: 15,
                    ),
                    backgroundColor: primaryColor,
                    primary: textColorBlack,
                    shape: const RoundedRectangleBorder(
                      borderRadius: borderRadiusMediumOnlyBottom,
                    ),
                  ),
                  child: Text(tMoreInfoThai),
                  onPressed: () {},
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
