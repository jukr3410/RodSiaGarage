import 'package:flutter/material.dart';
import 'package:rodsiagarage/constants.dart';
import 'package:rodsiagarage/request_service_feature/widgets/barTrackingPage.dart';
import 'package:rodsiagarage/request_service_feature/widgets/buttonTrackingStatus.dart';
import 'package:rodsiagarage/request_service_feature/widgets/locationUser.dart';
import 'package:rodsiagarage/request_service_feature/widgets/nameGarageAndUser.dart';
import 'package:rodsiagarage/constants.dart';

class TrackingRequestPage extends StatefulWidget {
  TrackingRequestPage({Key? key}) : super(key: key);

  @override
  _TrackingRequestPageState createState() => _TrackingRequestPageState();
}

class _TrackingRequestPageState extends State<TrackingRequestPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryColor,
      body: Column(
        children: [
          SizedBox(
            height: 50,
          ),
          NameGarageAndUser(),
          LocationUser(),
          BarTrackingpage(),
          SizedBox(
            height: 5,
          ),
          ButtonTrackingStatus()
        ],
      ),
    );
  }
}
