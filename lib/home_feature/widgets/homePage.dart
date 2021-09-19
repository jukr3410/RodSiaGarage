import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:rodsiagarage/constants.dart';
import 'package:rodsiagarage/home_feature/widgets/carouselImage.dart';

class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(defualtPaddingMedium),
      child: Column(
        children: [
          Row(
            children: [
              CircleAvatar(
                backgroundColor: Colors.transparent,
                radius: 40,
                child: ClipOval(
                  child: Image.asset(
                    tImageAsset('profile-homePage'),
                    width: 100,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              SizedBox(
                width: 20,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '168 Garage',
                    style: TextStyle(fontSize: fontSizeLarge),
                  ),
                  Row(
                    children: [
                      Text(
                        'ตำแหน่งของคุณ: ',
                      ),
                      Text(
                        '123/456',
                        softWrap: true,
                      ),
                    ],
                  ),
                ],
              )
            ],
          ),
          SizedBox(
            height: 20,
          ),
          CarouselImage(),
          SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Column(
                children: [
                  Container(
                    height: 80,
                    child: IconButton(
                        icon: Image.asset(
                          tImageAsset('serviceOfGarage'),
                        ),
                        iconSize: 100,
                        onPressed: () {}),
                  ),
                  Text(tServiceThai)
                ],
              ),
              Column(
                children: [
                  Container(
                    height: 80,
                    child: IconButton(
                        icon: Image.asset(
                          tImageAsset('history'),
                        ),
                        iconSize: 100,
                        onPressed: () {}),
                  ),
                  Text(tHistory)
                ],
              ),
              Column(
                children: [
                  Container(
                    height: 80,
                    child: IconButton(
                        icon: Image.asset(
                          tImageAsset('supportCenter'),
                        ),
                        iconSize: 100,
                        onPressed: () {}),
                  ),
                  Text(tSupportCenter)
                ],
              ),
            ],
          )
        ],
      ),
    );
  }
}
