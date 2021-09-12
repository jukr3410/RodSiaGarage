import 'package:flutter/material.dart';
import 'package:getwidget/components/button/gf_button.dart';
import 'package:getwidget/getwidget.dart';
import 'package:getwidget/shape/gf_button_shape.dart';
import 'package:rodsiagarage/constants.dart';
import 'package:rodsiagarage/global_widgets/alertPopupYesNo.dart';
import 'package:rodsiagarage/global_widgets/buttonMoreOption.dart';
import 'package:slider_button/slider_button.dart';

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
      child: Column(
        children: [
          if (numTextStatus == 0) _SlidButton(),
          if (numTextStatus == 1) _SlidButton(),
          if (numTextStatus == 2) _SlidButton(),
          if (numTextStatus == 3) _SlidButton(),
        ],
      ),
    );
  }

  Color finishService() {
    Color colorButton;
    numTextStatus == trackingStatus.length - 1
        ? colorButton = Colors.blue
        : colorButton = primaryColor;
    return colorButton;
  }

  Widget _SlidButton() {
    return Center(
        child: SliderButton(
          
      action: () {
        _onTappedNextStatus();
        if (numTextStatus == trackingStatus.length) {
          Navigator.pushNamed(context, "");
        }
      },

      ///Put label over here
      // alignLabel: Alignment.center,
      label: Text(
        textNextStatus(),
        style: TextStyle(
            color: Colors.white, fontWeight: FontWeight.w500, fontSize: 20),
      ),
      icon: Center(
          child: Icon(
        Icons.arrow_forward_ios,
        color: primaryColor,
        size: 40.0,
      )),

      boxShadow: BoxShadow(
        color: Colors.black38,
        blurRadius: 5,
      ),

      width: 300,
      radius: defualtPaddingLow,
      buttonColor: bgColor,
      backgroundColor: finishService(),
      highlightedColor: primaryColor,
      baseColor: bgColor,
    ));
  }

  Widget TextButtonNextStatus() {
    return Row(
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
    );
  }
}
