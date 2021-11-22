import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:rodsiagarage/constants.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:rodsiagarage/core/models/garage_model.dart';

class CarouselImage extends StatefulWidget {
  final List<ImageGarage> images;
  CarouselImage({required this.images});

  @override
  State<StatefulWidget> createState() {
    return CarouselImageState();
  }
}

class CarouselImageState extends State<CarouselImage> {
  int currentPos = 0;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        CarouselSlider.builder(
            itemCount: widget.images.length,
            options: CarouselOptions(
                autoPlay: true,
                onPageChanged: (index, reason) {
                  setState(() {
                    currentPos = index;
                  });
                }),
            itemBuilder: (context, index, realIndex) =>
                MyImageView(widget.images[index].image)),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: widget.images.map((url) {
            int index = widget.images.indexOf(url);
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
            placeholder: (context, url) => CircularProgressIndicator(
              color: textColorBlack,
            ),
            errorWidget: (context, url, error) => Icon(Icons.error),
          ),
          // Image.asset(imgPath)
          // Image.network(imgPath),
        ));
  }
}
