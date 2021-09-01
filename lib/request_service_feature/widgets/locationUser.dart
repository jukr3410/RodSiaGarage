import 'package:flutter/material.dart';
import 'package:rodsiagarage/constants.dart';

class LocationUser extends StatefulWidget {
  LocationUser({Key? key}) : super(key: key);

  @override
  _LocationUserState createState() => _LocationUserState();
}

class _LocationUserState extends State<LocationUser> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(defualtPaddingLow),
      child: Row(
        children: [
          Column(
            children: [
              Text(tLocationThai),
              SizedBox(height: 10),
              Text(tProblemThai)
            ],
          ),
          Expanded(
            child: Container(
              alignment: Alignment.centerRight,
              child: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  shape: CircleBorder(),
                  padding: EdgeInsets.all(defualtPaddingLow),
                  primary: Colors.black,
                ),
                child: ImageIcon(
                  AssetImage('image/icon-location.png'),
                  color: primaryColor,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
