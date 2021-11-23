import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:getwidget/getwidget.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:rodsiagarage/constants.dart';
import 'package:rodsiagarage/core/models/distance_matrix.dart';
import 'package:rodsiagarage/core/models/request_service_model.dart';
import 'package:rodsiagarage/home/app.dart';
import 'package:rodsiagarage/main.dart';
import 'package:rodsiagarage/request_service_feature/bloc/request_service_bloc.dart';
import 'package:rodsiagarage/request_service_feature/widgets/barTrackingPage.dart';
import 'package:rodsiagarage/request_service_feature/widgets/buttonTrackingStatus.dart';
import 'package:rodsiagarage/request_service_feature/widgets/locationUser.dart';
import 'package:rodsiagarage/request_service_feature/widgets/nameGarageAndUser.dart';
import 'package:rodsiagarage/constants.dart';
import 'package:rodsiagarage/request_service_feature/widgets/trackingRequestCard.dart';
import 'package:slide_to_confirm/slide_to_confirm.dart';

class TrackingRequestPage extends StatefulWidget {
  RequestService requestService;
  TrackingRequestPage({Key? key, required this.requestService})
      : super(key: key);

  @override
  _TrackingRequestPageState createState() => _TrackingRequestPageState();
}

class _TrackingRequestPageState extends State<TrackingRequestPage> {
  late GoogleMapController _mapController;
  late RequestServiceBloc _requestServiceBloc;

  late LatLng currentPosition;
  late LatLng destinationPosition;

  List<LatLng> latlongs = [];
  BitmapDescriptor? customIcon1;
  List<Marker> markers = <Marker>[];

  PolylinePoints polylinePoints = PolylinePoints();
  List<Polyline> polyline = [];

  late RequestService _requestService;
  late DistanceMatrix _distanceMatrix;

  String titleStutus = '';

  @override
  void initState() {
    //_requestService = widget.requestService;
    // currentPosition = LatLng(
    //     double.parse(widget.requestService.geoLocationUser.lat),
    //     double.parse(widget.requestService.geoLocationUser.long));

    // destinationPosition = LatLng(
    //     double.parse(widget.requestService.geoLocationGarage.lat),
    //     double.parse(widget.requestService.geoLocationGarage.long));
    _requestServiceBloc = BlocProvider.of<RequestServiceBloc>(context)
      ..add(LoadRequestService(requestServiceId: '619bf3b24f962e0016ea745a'));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          centerTitle: true,
          backgroundColor: primaryColor,
          automaticallyImplyLeading: false,
          title: Text(
            titleStutus,
            style: TextStyle(color: textColorBlack),
          )),
      backgroundColor: bgColor,
      body: BlocConsumer<RequestServiceBloc, RequestServiceState>(
        listener: (context, state) {
          if (state is RequestServiceLoading) {
            createMarker(context);
          } else if (state is RequestServiceLoadSuccess) {
            _requestService = state.requestService;
            logger.d(_requestService.toJson());
            setState(() {
              titleStutus = state.requestService.status;
            });

            //_distanceMatrix = state.distanceMatrix;
            currentPosition = LatLng(
                double.parse(state.requestService.geoLocationUser.lat),
                double.parse(state.requestService.geoLocationUser.long));

            destinationPosition = LatLng(
                double.parse(state.requestService.geoLocationGarage.lat),
                double.parse(state.requestService.geoLocationGarage.long));
            latlongs = [];
            latlongs.add(currentPosition);
            latlongs.add(destinationPosition);

            markers = getMarkers(latlongs, customIcon1!);
            getPolyline(latlongs);
          } else if (state is RequestServiceComleted) {
            navigateToRequestComplated(_requestService);
          }
        },
        builder: (context, state) {
          if (state is RequestServiceInService) {
            return Stack(
              children: <Widget>[
                GoogleMap(
                  initialCameraPosition:
                      CameraPosition(target: currentPosition, zoom: 14.0),
                  myLocationEnabled: true,
                  myLocationButtonEnabled: false,
                  compassEnabled: true,
                  scrollGesturesEnabled: true,
                  mapType: MapType.normal,
                  //myLocationButtonEnabled: false,
                  zoomGesturesEnabled: true,
                  polylines: Set<Polyline>.of(polyline),
                  markers: Set<Marker>.of(markers),
                  onMapCreated: (GoogleMapController controller) {
                    _mapController = controller;
                  },
                ),
                // Show current location button
                SafeArea(
                  child: Align(
                    alignment: Alignment.topRight,
                    child: Padding(
                      padding: const EdgeInsets.only(right: 8.0, top: 20.0),
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
                SafeArea(
                    child: Align(
                        alignment: Alignment.bottomCenter,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Padding(
                                padding: const EdgeInsets.only(bottom: 10.0),
                                child: TrackingRequestCard(
                                  requestService: _requestService,
                                  duration: "2"
                                  // ((_distanceMatrix
                                  //             .rows[0].elements[0].duration.value /
                                  //         60))
                                  //     .toStringAsFixed(0)
                                  ,
                                  distance: "2"
                                  // (_distanceMatrix
                                  //             .rows[0].elements[0].distance.value ~/
                                  //         1000)
                                  //     .toStringAsFixed(1)
                                  ,
                                )),
                            Padding(
                                padding: const EdgeInsets.only(bottom: 10.0),
                                child: ConfirmationSlider(
                                    onConfirmation: () => changeStatus(),
                                    width: cardWidthLarge,
                                    foregroundColor: primaryColor,
                                    sliderButtonContent: Icon(
                                      Icons.chevron_right,
                                      color: textColorBlack,
                                      size: 40,
                                    ),
                                    iconColor: textColorBlack,
                                    stickToEnd: false,
                                    text: "เปลี่ยนสถานะเป็น",
                                    textStyle: TextStyle(
                                        color: textColorBlack,
                                        fontWeight: FontWeight.bold,
                                        fontSize: fontSizeL))),
                          ],
                        )))
              ],
            );
          }
          return Center(
              child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
            child: CircularProgressIndicator(),
          ));
        },
      ),
    );
  }

  createMarker(context) {
    if (customIcon1 == null) {
      ImageConfiguration configuration = createLocalImageConfiguration(context);

      BitmapDescriptor.fromAssetImage(
              configuration, 'assets/images/car-repair.png')
          .then((icon) {
        setState(() {
          customIcon1 = icon;
        });
      });
    }
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
          icon: setIcon,
          onTap: () {},
          position: latlong);

      markers.add(marker);
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
  }

  navigateToRequestComplated(RequestService? requestService) {
    Navigator.pushReplacementNamed(context, RECAP_DETAIL_REQUREST_ROUTE,
        arguments: {'requestService': requestService});
  }

  void changeStatus() {
    print('Slider changeStatus!');
  }
}
