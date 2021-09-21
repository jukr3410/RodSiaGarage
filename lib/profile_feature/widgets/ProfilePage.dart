import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:getwidget/components/button/gf_button.dart';
import 'package:getwidget/types/gf_button_type.dart';
import 'package:rodsiagarage/constants.dart';
import 'package:rodsiagarage/core/models/garage_model.dart';
import 'package:rodsiagarage/core/models/user_model.dart';
import 'package:rodsiagarage/home_feature/widgets/carouselImage.dart';

import 'package:rodsiagarage/profile_feature/widgets/infoProfile.dart';

class ProfilePage extends StatefulWidget {
  final Garage garage;
  ProfilePage({Key? key, required this.garage}) : super(key: key);

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
            Colors.yellow.shade800,
            Colors.yellow.shade400,
            Colors.yellow.shade50
          ])),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: textColorBlack,
        ),
        backgroundColor: Colors.transparent,
        body: Column(
          children: [
            // Container(
            //   alignment: Alignment.centerLeft,
            //   child: backPage(),
            // ),
            SizedBox(
              height: 20,
            ),
            InfoProfile(
              garage: widget.garage,
            ),
            SizedBox(
              height: 20,
            ),

            Padding(
              padding: const EdgeInsets.all(defualtPaddingMedium),
              child: CarouselImage(),
            ),
            Container(
                decoration: BoxDecoration(
                    shape: BoxShape.circle, color: textColorBlack),
                child: IconButton(
                  icon: Icon(Icons.add),
                  onPressed: () {},
                  color: primaryColor,
                )),
            SizedBox(
              height: 5,
            ),
            Text('แก้ไขรูปภาพ')
          ],
        ),
      ),
    );
  }
}
