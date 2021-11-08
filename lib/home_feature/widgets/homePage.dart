import 'package:cached_network_image/cached_network_image.dart';
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
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(defualtPaddingLow),
        child: Column(
          children: [
            SizedBox(
              height: 10,
            ),
            Row(
              children: [
                SizedBox(
                  width: 10,
                ),
                CircleAvatar(
                  backgroundColor: Colors.transparent,
                  radius: 40,
                  child: ClipOval(
                    child: CachedNetworkImage(
                      imageUrl:
                          'https://i.pinimg.com/736x/e4/11/dc/e411dccaccc59c5ba86524c3baa74647.jpg',
                      placeholder: (context, url) => CircularProgressIndicator(
                        color: textColorBlack,
                      ),
                      errorWidget: (context, url, error) => Icon(Icons.error),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                SizedBox(
                  width: 20,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      '168 garages',
                      style: TextStyle(
                          fontSize: fontSizeLarge, fontWeight: FontWeight.w600),
                      softWrap: true,
                      maxLines: 1,
                    ),
                    Row(
                      children: [
                        Text(
                          tPhone + ': ',
                          style: TextStyle(
                              color: Colors.grey.shade700,
                              fontSize: fontSizeLow - 2),
                        ),
                        Text(
                          '0613512548',
                          style: TextStyle(
                              color: Colors.grey.shade700,
                              fontSize: fontSizeLow - 2),
                        )
                      ],
                    ),
                    Row(
                      children: [
                        Text(
                          tEmail + ': ',
                          style: TextStyle(
                              color: Colors.grey.shade700,
                              fontSize: fontSizeLow - 2),
                        ),
                        Text(
                          'ggg@mail.com',
                          style: TextStyle(
                              color: Colors.grey.shade700,
                              fontSize: fontSizeLow - 2),
                        )
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
                          onPressed: () {
                            navigateToService();
                          }),
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
                          onPressed: () {
                            navigatorToHistory();
                          }),
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
                          onPressed: () {
                            navigatorTosupportCenter();
                          }),
                    ),
                    Text(tSupportCenter)
                  ],
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  void navigateToService() {
    Navigator.pushNamed(context, SERVICE_LIST_ROUTE);
  }

  void navigatorTosupportCenter() {
    Navigator.pushNamed(context, SUPPORT_CENTER_ROUTE);
  }

  void navigatorToHistory() {
    Navigator.pushNamed(context, HISTORY_ROUTE);
  }
}
