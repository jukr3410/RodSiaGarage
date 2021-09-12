import 'package:flutter/material.dart';
import 'package:rodsiagarage/constants.dart';
import 'package:rodsiagarage/home/app.dart';
import 'package:rodsiagarage/request_service_feature/widgets/barTrackingPage.dart';
import 'package:rodsiagarage/request_service_feature/widgets/buttonTrackingStatus.dart';
import 'package:rodsiagarage/request_service_feature/widgets/locationUser.dart';
import 'package:rodsiagarage/request_service_feature/widgets/nameGarageAndUser.dart';
import 'package:rodsiagarage/constants.dart';
import 'package:rodsiagarage/request_service_feature/widgets/trackingRequestCard.dart';

class TrackingRequestPage extends StatefulWidget {
  TrackingRequestPage({Key? key}) : super(key: key);

  @override
  _TrackingRequestPageState createState() => _TrackingRequestPageState();
}

class _TrackingRequestPageState extends State<TrackingRequestPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: primaryColor,
        title: Text(
          tInSeriveThai,
          style: TextStyle(color: textColorBlack),
        ),
      ),
      backgroundColor: bgColor,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [TrackingRequestCard(), ButtonTrackingStatus()],
      ),
    );
  }
}
