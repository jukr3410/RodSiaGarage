import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:rodsiagarage/constants.dart';
import 'package:cached_network_image/cached_network_image.dart';

class CarouselImage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return CarouselImageState();
  }
}

class CarouselImageState extends State<CarouselImage> {
  int currentPos = 0;

  List imgList = [
    'https://images.unsplash.com/photo-1453728013993-6d66e9c9123a?ixid=MnwxMjA3fDB8MHxzZWFyY2h8Mnx8dmlld3xlbnwwfHwwfHw%3D&ixlib=rb-1.2.1&w=1000&q=80',
    'https://cdn.pixabay.com/photo/2015/04/23/22/00/tree-736885__480.jpg',
    'https://www.industrialempathy.com/img/remote/ZiClJf-1920w.jpg',
    'https://images.unsplash.com/photo-1612151855475-877969f4a6cc?ixid=MnwxMjA3fDB8MHxzZWFyY2h8MXx8aGQlMjBpbWFnZXxlbnwwfHwwfHw%3D&ixlib=rb-1.2.1&w=1000&q=80',
  ];

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        CarouselSlider.builder(
            itemCount: imgList.length,
            options: CarouselOptions(
                autoPlay: true,
                onPageChanged: (index, reason) {
                  setState(() {
                    currentPos = index;
                  });
                }),
            itemBuilder: (context, index, realIndex) =>
                MyImageView(imgList[index])),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: imgList.map((url) {
            int index = imgList.indexOf(url);
            return Container(
              width: 8.0,
              height: 8.0,
              margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 2.0),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: currentPos == index
                    ? Color.fromRGBO(0, 0, 0, 0.9)
                    : Color.fromRGBO(0, 0, 0, 0.4),
              ),
            );
          }).toList(),
        ),
      ]),
    );
  }
}

class MyImageView extends StatelessWidget {
  String imgPath;

  MyImageView(this.imgPath);

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 500,
        width: 300,
        color: primaryColor,
        margin: EdgeInsets.symmetric(horizontal: 5),
        child: FittedBox(
          fit: BoxFit.fill,
          child: CachedNetworkImage(
            imageUrl: imgPath,
            placeholder: (context, url) => CircularProgressIndicator(),
            errorWidget: (context, url, error) => Icon(Icons.error),
          ),
          // Image.asset(imgPath)
          // Image.network(imgPath),
        ));
  }
}
