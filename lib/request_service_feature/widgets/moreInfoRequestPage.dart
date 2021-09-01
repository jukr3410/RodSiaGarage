import 'package:flutter/material.dart';
import 'package:rodsiagarage/constants.dart';
import 'package:rodsiagarage/global_widgets/buttonAcceptAndDecline.dart';
import 'package:rodsiagarage/request_service_feature/widgets/moreInfoRequestCard.dart';

class MoreInfoRequestPage extends StatefulWidget {
  MoreInfoRequestPage({Key? key}) : super(key: key);

  @override
  _MoreInfoRequestPageState createState() => _MoreInfoRequestPageState();
}

class _MoreInfoRequestPageState extends State<MoreInfoRequestPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: primaryColor,
        ),
        body: Column(
          children: [
            MoreInfoRequestCard(),
            SizedBox(
              height: defualtPaddingMedium,
            ),
            ButtonAcceptAndDecline()
          ],
        ));
  }
}
