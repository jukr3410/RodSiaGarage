import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:map_pin_picker/map_pin_picker.dart';
import 'package:geocoder/geocoder.dart';
import 'package:rodsiagarage/constants.dart';
import 'package:rodsiagarage/main.dart';

class LocationPicker extends StatefulWidget {
  @override
  _LocationPickerState createState() => _LocationPickerState();
}

class _LocationPickerState extends State<LocationPicker> {
  Completer<GoogleMapController> _controller = Completer();
  MapPickerController mapPickerController = MapPickerController();

  CameraPosition cameraPosition = CameraPosition(
    target: LatLng(13.7245601, 100.4930247),
    zoom: 14.4746,
  );

  late Address address;

  var textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          navigateBackToAddInfo();
        },
        label: Text(
          'เลือกตำแหน่ง',
          style: const TextStyle(color: textColorBlack, fontSize: fontSizeM),
        ),
        icon: Icon(
          Icons.location_on,
          color: textColorBlack,
        ),
        backgroundColor: primaryColor,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      body: Column(
        children: [
          Expanded(
            child: MapPicker(
              // pass icon widget
              iconWidget: Icon(
                Icons.location_pin,
                size: 50,
              ),
              //add map picker controller
              mapPickerController: mapPickerController,
              child: GoogleMap(
                zoomGesturesEnabled: true,
                myLocationEnabled: true,
                // hide location button
                myLocationButtonEnabled: true,
                mapType: MapType.normal,
                //  camera position
                initialCameraPosition: cameraPosition,
                onMapCreated: (GoogleMapController controller) {
                  _controller.complete(controller);
                },
                onCameraMoveStarted: () {
                  // notify map is moving
                  mapPickerController.mapMoving();
                },
                onCameraMove: (cameraPosition) {
                  this.cameraPosition = cameraPosition;
                },
                onCameraIdle: () async {
                  // notify map stopped moving
                  mapPickerController.mapFinishedMoving();
                  //get address name from camera position
                  List<Address> addresses = await Geocoder.local
                      .findAddressesFromCoordinates(Coordinates(
                          cameraPosition.target.latitude,
                          cameraPosition.target.longitude));
                  // update the ui with the address
                  textController.text = '${addresses.first.addressLine ?? ''}';
                },
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomAppBar(
        color: primaryColor,
        elevation: 0,
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 8, horizontal: 8),
          color: primaryColor,
          child: TextFormField(
            readOnly: true,
            decoration: InputDecoration(
                contentPadding: EdgeInsets.zero, border: InputBorder.none),
            controller: textController,
            style: TextStyle(fontSize: fontSizeM, color: textColorBlack),
          ),
          // icon: Icon(Icons.directions_boat),
        ),
      ),
    );
  }

  void navigateBackToAddInfo() {
    logger.d(cameraPosition);
    Navigator.pop(context, cameraPosition);
  }
}
