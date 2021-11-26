import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:rodsiagarage/constants.dart';
import 'package:rodsiagarage/core/models/request_service_model.dart';
import 'package:rodsiagarage/global_widgets/alertPopupYesNo.dart';
import 'package:rodsiagarage/main.dart';
import 'package:rodsiagarage/request_service_feature/bloc/request_service_bloc.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';
import 'package:url_launcher/url_launcher.dart' as UrlLauncher;

class MoreInfoRequestPage extends StatefulWidget {
  final RequestService req;
  MoreInfoRequestPage({Key? key, required this.req}) : super(key: key);

  @override
  _MoreInfoRequestPageState createState() => _MoreInfoRequestPageState();
}

class _MoreInfoRequestPageState extends State<MoreInfoRequestPage> {
  late GoogleMapController _mapController;

  late LatLng currentPosition;
  late LatLng destinationPosition;

  List<LatLng> latlongs = [];
  BitmapDescriptor customIcon1 = BitmapDescriptor.defaultMarker;
  List<Marker> markers = <Marker>[];

  PolylinePoints polylinePoints = PolylinePoints();
  List<Polyline> polyline = [];
  late RequestServiceBloc _requestServiceBloc;

  String distance = "0 กม.";

  @override
  void initState() {
    _requestServiceBloc = BlocProvider.of<RequestServiceBloc>(context);
    currentPosition = LatLng(double.parse(widget.req.geoLocationGarage.lat),
        double.parse(widget.req.geoLocationGarage.long));

    destinationPosition = LatLng(double.parse(widget.req.geoLocationUser.lat),
        double.parse(widget.req.geoLocationUser.long));
    latlongs.add(currentPosition);
    latlongs.add(destinationPosition);

    getMarkers(latlongs, customIcon1);
    getPolyline(latlongs);
    _requestServiceBloc.add(GetCurrentLocationAndDistance(
        geoLocationUser: widget.req.geoLocationUser));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    createMarker(context);
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back_ios,
              color: iconColorBlack,
            ),
            onPressed: () {
              navigateToRequestServiceList();
            },
          ),
          title: Text(
            'ยืนยันคำขอบริการ',
            style: TextStyle(color: textColorBlack, fontSize: fontSizeL),
          ),
          centerTitle: true,
          backgroundColor: primaryColor,
        ),
        body: BlocConsumer<RequestServiceBloc, RequestServiceState>(
          listener: (context, state) {
            if (state is UpdatedRequestServiceAccept) {
              logger.d("widget.req: ${widget.req.toJson()}");
              showTopSnackBar(
                  context, CustomSnackBar.success(message: "ยืนยันเรียบร้อย"));
              navigatorToTrackingPage(widget.req);
            }
            if (state is UpdatedRequestServiceCancel) {
              showTopSnackBar(
                  context, CustomSnackBar.info(message: "ปฏิเสธคำขอ"));
              navigatorToHomePage();
            }
            if (state is RequestServiceLoadSuccess) {}
            if (state is CurrentLocationAndDistanceSuccess) {
              logger.d(
                  "distance: ${state.distanceMatrix!.rows[0].elements[0].distance.text}");
              setState(() {
                distance =
                    state.distanceMatrix!.rows[0].elements[0].distance.text;
              });
            }
          },
          builder: (context, state) {
            return Padding(
              padding: const EdgeInsets.only(bottom: 24.0),
              child: Stack(
                children: [
                  Container(
                    height: MediaQuery.of(context).size.height * 0.45,
                    width: double.infinity,
                    child: GoogleMap(
                      initialCameraPosition:
                          CameraPosition(target: currentPosition, zoom: 14.0),
                      myLocationEnabled: true,
                      myLocationButtonEnabled: false,
                      compassEnabled: true,
                      scrollGesturesEnabled: true,
                      mapType: MapType.terrain,
                      //myLocationButtonEnabled: false,
                      zoomGesturesEnabled: true,
                      polylines: Set<Polyline>.of(polyline),
                      markers: Set<Marker>.of(markers),
                      onMapCreated: (GoogleMapController controller) {
                        _mapController = controller;
                      },
                    ),
                  ),
                  // Show current location button
                  SafeArea(
                    child: Align(
                      alignment: Alignment.centerRight,
                      child: Padding(
                        padding: const EdgeInsets.only(right: 16.0),
                        child: ClipOval(
                          child: Material(
                            color: primaryColor,
                            child: InkWell(
                              splashColor: primaryColor, // inkwell color
                              child: SizedBox(
                                width: 56,
                                height: 56,
                                child: Icon(Icons.my_location),
                              ),
                              onTap: () {
                                _mapController.animateCamera(
                                  CameraUpdate.newCameraPosition(
                                    CameraPosition(
                                      target: currentPosition,
                                      zoom: 14.0,
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Center(
                        child: Padding(
                          padding: const EdgeInsets.all(defualtPaddingLow),
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: borderRadiusMedium,
                              boxShadow: [boxShadow],
                              color: bgColor,
                            ),
                            child: Column(
                              children: [
                                Container(
                                  decoration: BoxDecoration(
                                    borderRadius: borderRadiusMediumOnlyTop,
                                    color: primaryColor,
                                  ),
                                  child: Padding(
                                    padding:
                                        const EdgeInsets.all(defualtPaddingLow),
                                    child: Row(
                                      children: [
                                        Flexible(
                                          flex: 7,
                                          child: Row(
                                            children: [
                                              Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 15),
                                                child: Image.asset(
                                                  tImageAsset(widget.req.service
                                                      .serviceType.name),
                                                  width: 27,
                                                ),
                                              ),
                                              Flexible(
                                                child: RichText(
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    strutStyle: StrutStyle(
                                                      fontSize: 5,
                                                    ),
                                                    text: TextSpan(
                                                      text: widget
                                                          .req.service.name,
                                                      style: TextStyle(
                                                          color: Colors.black,
                                                          fontSize: fontSizeXl,
                                                          fontWeight:
                                                              FontWeight.w500,
                                                          fontFamily: 'Kanit'),
                                                    )),
                                              )
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      right: defualtPaddingMedium,
                                      left: defualtPaddingMedium,
                                      top: defualtPaddingLow,
                                      bottom: defualtPaddingLow),
                                  child: Row(
                                    children: [
                                      Expanded(
                                        flex: 4,
                                        child: Column(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            Row(
                                              children: [
                                                Icon(
                                                  Icons.supervised_user_circle,
                                                  color: textColorBlack,
                                                  size: 20,
                                                ),
                                                SizedBox(
                                                  width: 10,
                                                ),
                                                Text(
                                                  widget.req.user.name,
                                                  softWrap: true,
                                                  style: _textStyleSmall,
                                                ),
                                              ],
                                            ),
                                            SizedBox(
                                              height: 5,
                                            ),
                                            Row(
                                              children: [
                                                Image.asset(
                                                  tImageAsset(
                                                      widget.req.car.type),
                                                  width: 20,
                                                ),
                                                SizedBox(
                                                  width: 10,
                                                ),
                                                Row(
                                                  children: [
                                                    Text('รุ่น: '),
                                                    Text(
                                                      widget.req.car.brand,
                                                      softWrap: true,
                                                      style: _textStyleSmall,
                                                    ),
                                                    SizedBox(
                                                      width: 5,
                                                    ),
                                                    Text(
                                                      widget.req.car.model,
                                                      softWrap: true,
                                                      style: _textStyleSmall,
                                                    ),
                                                    SizedBox(
                                                      width: 5,
                                                    ),
                                                    Text(
                                                      widget.req.car.year,
                                                      softWrap: true,
                                                      style: _textStyleSmall,
                                                    ),
                                                    SizedBox(
                                                      width: 5,
                                                    ),
                                                    Text(
                                                      widget
                                                          .req.car.regisNumber,
                                                      softWrap: true,
                                                      style: _textStyleSmall,
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                            SizedBox(
                                              height: 5,
                                            ),
                                            Row(
                                              children: [
                                                Image.asset(
                                                  tImageAsset('distance'),
                                                  width: 20,
                                                ),
                                                SizedBox(
                                                  width: 10,
                                                ),
                                                Text(
                                                  distance,
                                                  softWrap: true,
                                                  style: _textStyleSmall,
                                                ),
                                              ],
                                            ),
                                            SizedBox(
                                              height: 5,
                                            ),
                                            Row(
                                              children: [
                                                Image.asset(
                                                  tImageAsset('location2'),
                                                  width: 20,
                                                ),
                                                SizedBox(
                                                  width: 10,
                                                ),
                                                Container(
                                                  width: 200,
                                                  child: Text(
                                                    widget.req.addressUser,
                                                    softWrap: true,
                                                    style: _textStyleSmall,
                                                    maxLines: 2,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                  ),
                                                ),
                                              ],
                                            ),
                                            SizedBox(
                                              height: 5,
                                            ),
                                            Row(
                                              children: [
                                                Image.asset(
                                                  tImageAsset('desc'),
                                                  width: 20,
                                                ),
                                                SizedBox(
                                                  width: 10,
                                                ),
                                                Container(
                                                  width: 200,
                                                  child: Text(
                                                    widget.req.problemDesc,
                                                    softWrap: true,
                                                    style: _textStyleSmall,
                                                    maxLines: 2,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                  ),
                                                ),
                                              ],
                                            ),
                                            SizedBox(
                                              height: 5,
                                            ),
                                            Row(
                                              children: [
                                                Icon(
                                                  Icons.image,
                                                  color: textColorBlack,
                                                  size: 20,
                                                ),
                                                SizedBox(
                                                  width: 10,
                                                ),
                                                Container(
                                                    height: 40,
                                                    child: ListView.builder(
                                                        scrollDirection:
                                                            Axis.horizontal,
                                                        shrinkWrap: true,
                                                        itemCount: widget
                                                            .req.images!.length,
                                                        itemBuilder:
                                                            (context, index) {
                                                          return Row(
                                                            children: [
                                                              GestureDetector(
                                                                child:
                                                                    CachedNetworkImage(
                                                                  width: 40,
                                                                  height: 40,
                                                                  fit: BoxFit
                                                                      .cover,
                                                                  imageUrl: widget
                                                                      .req
                                                                      .images![
                                                                          index]
                                                                      .image,
                                                                  placeholder: (context,
                                                                          url) =>
                                                                      CircularProgressIndicator(
                                                                    color:
                                                                        textColorBlack,
                                                                  ),
                                                                  errorWidget: (context,
                                                                          url,
                                                                          error) =>
                                                                      Icon(Icons
                                                                          .error),
                                                                ),
                                                                onTap: () {
                                                                  _navigateAndDisplayImage(
                                                                      context,
                                                                      widget
                                                                          .req
                                                                          .images![
                                                                              index]
                                                                          .image);
                                                                },
                                                              ),
                                                              SizedBox(
                                                                width: 5,
                                                              )
                                                            ],
                                                          );
                                                        })),
                                              ],
                                            ),
                                            SizedBox(
                                              height: 5,
                                            ),
                                          ],
                                        ),
                                      ),
                                      Expanded(
                                          child: Column(
                                        children: [
                                          Container(
                                              decoration: BoxDecoration(
                                                  shape: BoxShape.circle,
                                                  color: textColorBlack),
                                              child: IconButton(
                                                icon: Icon(Icons.call),
                                                onPressed: () {
                                                  UrlLauncher.launch(
                                                      'tel://${widget.req.user.phone}');
                                                },
                                                color: primaryColor,
                                              )),
                                          Text(
                                            'โทรสอบถาม',
                                            style:
                                                TextStyle(fontSize: fontSizeS),
                                          )
                                        ],
                                      ))
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                                flex: 45,
                                child: Container(
                                  width: buttonWidthSmall,
                                  height: buttonHeightSmall,
                                  child: TextButton(
                                    onPressed: () {
                                      _navigateAccept(context);
                                    },
                                    child: Text(tOKThai),
                                    style: flatButtonStyle(
                                        primaryColor, textColorBlack),
                                  ),
                                )),
                            Expanded(
                              flex: 2,
                              child: SizedBox(
                                width: 2,
                              ),
                            ),
                            Expanded(
                                flex: 45,
                                child: TextButton(
                                  child: Text(tDeclineThai),
                                  style: TextButton.styleFrom(
                                    primary: textColorBlack,
                                    side: BorderSide(
                                        color: Colors.black26, width: 1),
                                  ),
                                  onPressed: () {
                                    _navigateCancle(context);
                                  },
                                ))
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                    ],
                  ),
                ],
              ),
            );
          },
        ));
  }

  _showFullImage(String image) {
    return Center(
      child: Container(
        width: cardWidthLow,
        decoration: BoxDecoration(
          borderRadius: borderRadiusMedium,
          boxShadow: [boxShadow],
          color: bgColor,
        ),
        child: CachedNetworkImage(
          // height: double.infinity,
          alignment: Alignment.center,
          width: 300,
          fit: BoxFit.cover,
          imageUrl: image,
          placeholder: (context, url) => CircularProgressIndicator(
            color: textColorBlack,
          ),
          errorWidget: (context, url, error) => Icon(Icons.error),
        ),
      ),
    );
  }

  createMarker(context) {
    ImageConfiguration configuration = createLocalImageConfiguration(context);

    BitmapDescriptor.fromAssetImage(
            configuration, 'assets/images/car-repair.png')
        .then((icon) {
      setState(() {
        customIcon1 = icon;
      });
    });
  }

  List<Marker> getMarkers(List<LatLng> latlongs, BitmapDescriptor icon) {
    var markers = <Marker>[];
    BitmapDescriptor setIcon = BitmapDescriptor.defaultMarker;

    latlongs.forEach((latlong) {
      logger.d("latlong: ${latlong.toString()}");
      if (latlong.latitude != currentPosition.latitude) {
        setIcon = icon;
      }
      Marker marker = Marker(
          markerId: MarkerId(latlong.toString()),
          draggable: false,
          icon: BitmapDescriptor.defaultMarker,
          onTap: () {},
          position: latlong);

      markers.add(marker);
    });
    setState(() {
      this.markers = markers;
    });
    return markers;
  }

  void getPolyline(List<LatLng> latlongs) async {
    //var polyline = <Polyline>[];

    List<LatLng> polylineCoordinates = [];

    PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
      "AIzaSyA0WKpMAsoXdtAhRR3X56WgvCh4IN1cBps",
      PointLatLng(currentPosition.latitude, currentPosition.longitude),
      PointLatLng(destinationPosition.latitude, destinationPosition.longitude),
      travelMode: TravelMode.driving,
    );

    if (result.points.isNotEmpty) {
      result.points.forEach((PointLatLng point) {
        polylineCoordinates.add(LatLng(point.latitude, point.longitude));
      });
    } else {
      logger.e(result.errorMessage);
    }

    polyline.add(Polyline(
      polylineId: PolylineId("route"),
      geodesic: true,
      points: polylineCoordinates,
      width: 5,
      color: textColorBlack,
    ));
    setState(() {});
  }

  void _navigateAndDisplayImage(BuildContext context, String image) async {
    final result = await showDialog<String>(
        context: context,
        builder: (BuildContext context) => _showFullImage(image));
    if (result == 'Ok') {}
  }

  void _navigateCancle(BuildContext context) async {
    final result = await showDialog<String>(
        context: context,
        builder: (BuildContext context) =>
            AlertPopupYesNo(title: 'คุณต้องการปฎิเสธใช้ไหม'));
    if (result == 'Ok') {
      widget.req.status = 'ปฏิเสธ';
      logger.d(widget.req.id);
      _requestServiceBloc
          .add(UpdateRequestServiceCancel(requestService: widget.req));
    }
  }

  void _navigateAccept(BuildContext context) async {
    final result = await showDialog<String>(
        context: context,
        builder: (BuildContext context) => AlertPopupYesNo(
              title: 'คุณต้องการให้บริการใช้ไหม',
            ));
    if (result == 'Ok') {
      widget.req.status = 'ยืนยันแล้ว';
      logger.d(widget.req.id);
      _requestServiceBloc
          .add(UpdateRequestServiceAccept(requestService: widget.req));
    }
  }

  TextStyle _textStyleSmall = TextStyle(
    fontSize: fontSizeM,
  );

  navigatorToTrackingPage(RequestService req) {
    Navigator.pushNamed(context, TRACKING_REQUEST_ROUTE, arguments: req);
  }

  navigatorToHomePage() {
    //Navigator.pushNamed(context, MAIN_ROUTE);
    Navigator.pop(context);
  }

  navigateToRequestServiceList() {
    Navigator.pop(context);
  }
}
