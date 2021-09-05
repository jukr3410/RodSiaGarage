import 'package:flutter/material.dart';
import 'package:getwidget/components/button/gf_button.dart';
import 'package:getwidget/types/gf_button_type.dart';
import 'package:rodsiagarage/constants.dart';
import 'package:rodsiagarage/router.dart';

class AlertPopupBackHomePage extends StatefulWidget {
  AlertPopupBackHomePage({Key? key}) : super(key: key);

  @override
  _AlertPopupBackHomePageState createState() => _AlertPopupBackHomePageState();
}

class _AlertPopupBackHomePageState extends State<AlertPopupBackHomePage> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: cardWidthLow,
        decoration: BoxDecoration(
          borderRadius: borderRadiusMedium,
          boxShadow: [boxShadow],
          color: bgColor,
        ),
        child: Padding(
          padding: const EdgeInsets.all(defualtPaddingMedium),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                tFinishProvideService,
                style: TextStyle(fontSize: 18),
              ),
              SizedBox(
                height: defualtPaddingMedium,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                      height: buttonHeightSmall,
                      width: buttonWidthSmall + 20,
                      child: TextButton(
                        onPressed: () {
                          Navigator.pushNamed(context, HOMEPAGE_ROUTE);
                        },
                        child: Text(tBackToHomePage),
                        style: flatButtonStyle(primaryColor, textColorBlack),
                      )),
                  GFButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text(tCancleThai),
                    textColor: textColorBlack,
                    type: GFButtonType.transparent,
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
