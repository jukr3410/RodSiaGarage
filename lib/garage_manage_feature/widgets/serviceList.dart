import 'package:flutter/material.dart';
import 'dart:ui';
import 'package:rodsiagarage/constants.dart';

class ServiceListScreen extends StatefulWidget {
  @override
  _ServiceListScreenState createState() => _ServiceListScreenState();
}

class _ServiceListScreenState extends State<ServiceListScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: primaryColor,
          centerTitle: true,
          title: Text(
            tServiceGarage,
            style:
                TextStyle(color: textColorBlack, fontSize: fontSizeSemiLarge),
          ),
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back,
              color: iconColorBlack,
            ),
            onPressed: () {
              Navigator.pop(context);
              // Let's create a new instance of the home page
              // Navigator.pushReplacement(
              //   context,
              //   MAIN_ROUTE
              // );
            },
          ),
          actions: [
            IconButton(
              icon: Icon(Icons.add, color: Colors.white),
              onPressed: () {
                navigateToAddService();
              },
              iconSize: 40.0,
            ),
          ],
        ),
        body: body(context));
  }

  body(context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
      Stack(
        clipBehavior: Clip.none,
        children: [
          Container(
              height: MediaQuery.of(context).size.height * 0.2,
              width: double.infinity,
              child: ImageFiltered(
                imageFilter: ImageFilter.blur(sigmaY: 4, sigmaX: 4),
                child: Image.network(
                  'https://file.chobrod.com/2018/11/21/VakJH1VD/4-197f.jpg',
                  fit: BoxFit.cover,
                ),
              )),
          Positioned(
            top: 40,
            left: 30,
            child: Row(children: <Widget>[
              Text("8", style: TextStyle(fontSize: 70.0)),
              Padding(
                padding: const EdgeInsets.all(defualtPaddingLow),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("สมยศ การช่าง", style: TextStyle(fontSize: 25.0)),
                    Text("บริการ".toUpperCase(),
                        style: TextStyle(fontSize: fontSizeMedium)),
                  ],
                ),
              ),
            ]),
          ),
          Positioned(
            bottom: -40,
            right: 15,
            child: FloatingActionButton(
              onPressed: () {
                navigateToAddService();
              },
              child: IconButton(
                icon: Icon(Icons.add, color: Colors.white),
                onPressed: () {
                  navigateToAddService();
                },
                iconSize: 40.0,
              ),
              backgroundColor: primaryColor,
            ),
          )
        ],
      )
    ]);
  }

  void navigateToAddService() {
    Navigator.pushNamed(context, ADD_SERVICE_ROUTE);
  }
}
