import 'package:flutter/material.dart';
import 'package:rodsiagarage/constants.dart';
import 'package:rodsiagarage/core/models/request_service_model.dart';

class InboxPage extends StatefulWidget {
  InboxPage({Key? key}) : super(key: key);

  @override
  _InboxPageState createState() => _InboxPageState();
}

class _InboxPageState extends State<InboxPage> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          TextButton(
              onPressed: () {
                navigatorToRecapRequest();
              },
              child: Text("recap-request"))
        ],
      ),
    );
  }

  void navigatorToRecapRequest() {
    Navigator.pushNamed(context, RECAP_DETAIL_REQUREST_ROUTE);
  }
}
