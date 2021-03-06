import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:rodsiagarage/constants.dart';
import 'package:rodsiagarage/core/models/garage_model.dart';

class InfoAddress extends StatefulWidget {
  final Garage garage;
  InfoAddress({Key? key, required this.garage}) : super(key: key);

  @override
  _InfoAddressState createState() => _InfoAddressState();
}

class _InfoAddressState extends State<InfoAddress> {
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            tLocationThai,
            style: TextStyle(fontSize: fontSizeM, fontWeight: FontWeight.w600),
          ),
          Text(widget.garage.address.addressDesc),
        ],
      ),
    );
  }
}
