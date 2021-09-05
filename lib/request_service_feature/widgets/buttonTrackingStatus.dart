import 'package:flutter/material.dart';
import 'package:getwidget/components/button/gf_button.dart';
import 'package:getwidget/getwidget.dart';
import 'package:getwidget/shape/gf_button_shape.dart';
import 'package:rodsiagarage/constants.dart';
import 'package:rodsiagarage/global_widgets/alertPopupYesNo.dart';
import 'package:rodsiagarage/global_widgets/buttonMoreOption.dart';

class ButtonTrackingStatus extends StatefulWidget {
  ButtonTrackingStatus({Key? key}) : super(key: key);

  @override
  _ButtonTrackingStatusState createState() => _ButtonTrackingStatusState();
}

class _ButtonTrackingStatusState extends State<ButtonTrackingStatus> {
  int numTextStatus = 0;
  String textNextStatus() {
    return trackingStatus[numTextStatus].toString();
  }

  void _onTappedNextStatus() {
    setState(() {
      numTextStatus <= trackingStatus.length - 1
          ? numTextStatus++
          : numTextStatus = trackingStatus.length - 1;
    });
  }

  void _navigateAndDisplaySelection(BuildContext context) async {
    final result = await showDialog<String>(
        context: context,
        builder: (BuildContext context) =>
            AlertPopupYesNo(title: tUpdateTrackingStatus));
    if (result == 'Ok') {
      _onTappedNextStatus();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        right: defualtPaddingMedium,
        left: defualtPaddingMedium,
        top: defualtPaddingLow,
      ),
      child: Row(
        children: [
          Container(
              height: buttonHeightMedium,
              width: buttonWidthMedium + 40,
              child: TextButton(
                  style: flatButtonStyle(primaryColor, textColorBlack),
                  onPressed: () {
                    if (numTextStatus < trackingStatus.length - 1) {
                      showDialog<String>(
                          context: context,
                          builder: (BuildContext context) =>
                              AlertPopupYesNo(title: tUpdateTrackingStatus));
                      _navigateAndDisplaySelection(context);
                    } else {
                      ScaffoldMessenger.of(context)
                        ..removeCurrentSnackBar()
                        ..showSnackBar(SnackBar(
                            backgroundColor: textColorBlack,
                            content: Text(tFinishProvideService)));
                    }
                  },
                  child: Text(
                    textNextStatus(),
                    style: TextStyle(fontSize: fontSizeMedium),
                  ))),
          Expanded(
            flex: 2,
            child: ButtonMoreOption(),
          )
        ],
      ),
    );
  }
}
