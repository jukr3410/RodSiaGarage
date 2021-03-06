import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:getwidget/getwidget.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:map_address_picker/map_address_picker.dart';
import 'package:map_address_picker/models/location_result.dart';
import 'package:rodsiagarage/constants.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:rodsiagarage/core/models/garage_model.dart';
import 'package:rodsiagarage/core/models/geo_location_model.dart';
import 'package:rodsiagarage/main.dart';
import 'package:rodsiagarage/register_garage_feature/bloc/register_bloc.dart';
import 'package:rodsiagarage/register_garage_feature/widgets/locationPicker.dart';
import 'package:time_range_picker/time_range_picker.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';
import 'package:map_pin_picker/map_pin_picker.dart';
import 'package:weekday_selector/weekday_selector.dart';

import 'otp.dart';

class AddInfo extends StatefulWidget {
  Garage garage;
  AddInfo({Key? key, required this.garage}) : super(key: key);
  @override
  _AddInfoState createState() => _AddInfoState();
}

class _AddInfoState extends State<AddInfo> {
  final _controller = TextEditingController();
  GlobalKey<FormState> _form = GlobalKey<FormState>();
  final phoneConTroller = TextEditingController();
  var confirmPass;

  Garage _garage = Garage(
    services: [],
    address:
        Address(geoLocation: GeoLocation(lat: "", long: ""), addressDesc: ""),
    images: [],
    typeCarRepairs: [],
    logoImage: "",
    id: "",
    name: "",
    phone: "",
    email: "",
    otp: "",
    password: "",
    validatePhone: true,
    openingHour: OpeningHour(open: "", close: ""),
    openingDayOfWeek: OpeningDayOfWeek(
        mo: false,
        tu: false,
        we: false,
        th: false,
        fr: false,
        sa: false,
        su: false),
  );

  OpeningDayOfWeek _openingDayOfWeek = OpeningDayOfWeek(
      mo: false,
      tu: false,
      we: false,
      th: false,
      fr: false,
      sa: false,
      su: false);

  late RegisterBloc _registerBloc;
  bool twoWheelState = false;
  bool threeWheelState = false;
  bool fourWheelState = false;
  bool heavyWheelState = false;
  List<TypeCarRepairs> _typeCarRepairs = [];

  CameraPosition cameraPosition = CameraPosition(
    target: LatLng(13.7245601, 100.4930247),
    zoom: 14.4746,
  );

  String address = '';
  String openingTime = '';
  TimeRange? timeRange;

  // start with all days selected.
  final values = List.filled(7, false);

  bool _passwordVisible = false;

  Color getColor(Set<MaterialState> states) {
    const Set<MaterialState> interactiveStates = <MaterialState>{
      MaterialState.pressed,
      MaterialState.hovered,
      MaterialState.focused,
    };
    if (states.any(interactiveStates.contains)) {
      return primaryColor;
    }
    return textColorBlack;
  }

  @override
  void initState() {
    _registerBloc = BlocProvider.of<RegisterBloc>(context);
    _garage = widget.garage;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: BlocConsumer<RegisterBloc, RegisterState>(
        listener: (context, state) {
          if (state is RegisterSuccess) {
            navigateToLogin();
            showTopSnackBar(
                context, CustomSnackBar.success(message: "???????????????????????????????????????????????????"));
          } else if (state is RegisterError) {
            showTopSnackBar(
              context,
              CustomSnackBar.error(
                message: mError,
              ),
            );
          }
        },
        builder: (context, state) {
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
                backgroundColor: Colors.transparent,
                elevation: 0,
                leading: IconButton(
                  icon: Icon(Icons.arrow_back_ios, color: textColorBlack),
                  onPressed: () => navigateBackToOtp(),
                ),
              ),
              backgroundColor: Colors.transparent,
              resizeToAvoidBottomInset: false,
              body: SingleChildScrollView(
                child: Center(
                  child: Column(
                    //mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                            borderRadius: borderRadiusHight,
                            boxShadow: [boxShadow]),
                        // child: ClipRRect(
                        //   borderRadius: BorderRadius.circular(25),
                        //   child: Image.asset(
                        //     'assets/launcher/ic_launcher.png',
                        //     height: 120,
                        //   ),
                        // ),
                      ),
                      // SizedBox(
                      //   height: 30,
                      // ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 0, horizontal: 30),
                        child: Column(
                          // crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Column(
                              children: [
                                Form(
                                  key: _form,
                                  child: Column(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 10, horizontal: 0),
                                        child: Text(
                                          "??????????????????????????????",
                                          style: TextStyle(
                                              color: textColorBlack,
                                              fontSize: fontSizeXXl),
                                        ),
                                      ),
                                      TextFormField(
                                          // maxLength: 25,
                                          onChanged: (value) =>
                                              {_garage.name = value},
                                          textInputAction: TextInputAction.next,
                                          keyboardType: TextInputType.name,
                                          autofocus: true,
                                          textAlign: TextAlign.start,
                                          style: TextStyle(
                                              color: textColorBlack,
                                              fontSize: 15),
                                          inputFormatters: [
                                            //MaskedInputFormatter('(###)-###-####')
                                          ],
                                          decoration: InputDecoration(
                                            // icon: Icon(Icons.phone_android),
                                            filled: true,
                                            fillColor: Colors.white,
                                            alignLabelWithHint: true,
                                            prefixIcon: Icon(
                                              Icons.person,
                                              color: textColorBlack,
                                            ),
              
                                            border: OutlineInputBorder(
                                                borderRadius: borderRadiusMedium,
                                                borderSide: BorderSide.none),
                                            hintText: "????????????",
                                            hintStyle: TextStyle(
                                                color: textColorBlack,
                                                fontSize: 15),
                                          ),
                                          validator: MultiValidator([
                                            RequiredValidator(
                                                errorText: "?????????????????????????????????"),
                                            MinLengthValidator(1,
                                                errorText: "?????????????????????????????????"),
                                          ])),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      TextFormField(
                                          // maxLength: 25,
                                          onChanged: (value) => {
                                                value.isEmpty
                                                    ? _garage.email = ""
                                                    : _garage.email = value
                                              },
                                          textInputAction: TextInputAction.next,
                                          keyboardType: TextInputType.name,
                                          autofocus: true,
                                          textAlign: TextAlign.start,
                                          style: TextStyle(
                                              color: textColorBlack,
                                              fontSize: 15),
                                          inputFormatters: [
                                            //MaskedInputFormatter('(###)-###-####')
                                          ],
                                          decoration: InputDecoration(
                                            // icon: Icon(Icons.phone_android),
                                            filled: true,
                                            prefixIcon: Icon(Icons.email,
                                                color: textColorBlack),
                                            fillColor: Colors.white,
                                            alignLabelWithHint: true,
                                            border: OutlineInputBorder(
                                                borderRadius: borderRadiusMedium,
                                                borderSide: BorderSide.none),
                                            hintText: tEmailThai + " (???????????????????????????)",
                                            hintStyle: TextStyle(
                                                color: textColorBlack,
                                                fontSize: 15),
                                          ),
                                          validator: MultiValidator([
                                            EmailValidator(
                                                errorText:
                                                    '?????????????????????????????????????????????????????????????????????')
                                            // RequiredValidator(errorText: ""),
                                            // MinLengthValidator(14,
                                            //     errorText:
                                            //         "Phone should be atleast 10 number."),
                                          ])),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      TextFormField(
                                          // maxLength: 25,
                                          onChanged: (value) =>
                                              {_garage.password = value},
                                          textInputAction: TextInputAction.next,
                                          keyboardType: TextInputType.text,
                                          autofocus: true,
                                          obscureText: !_passwordVisible,
                                          textAlign: TextAlign.start,
                                          style: TextStyle(
                                              color: textColorBlack,
                                              fontSize: 15),
                                          inputFormatters: [
                                            //MaskedInputFormatter('(###)-###-####')
                                          ],
                                          decoration: InputDecoration(
                                            // icon: Icon(Icons.phone_android),
                                            filled: true,
                                            prefixIcon: Icon(
                                              Icons.security_rounded,
                                              color: textColorBlack,
                                            ),
                                            suffixIcon: IconButton(
                                              icon: Icon(
                                                // Based on passwordVisible state choose the icon
                                                _passwordVisible
                                                    ? Icons.visibility
                                                    : Icons.visibility_off,
                                                color: textColorBlack,
                                              ),
                                              onPressed: () {
                                                // Update the state i.e. toogle the state of passwordVisible variable
                                                setState(() {
                                                  _passwordVisible =
                                                      !_passwordVisible;
                                                });
                                              },
                                            ),
                                            fillColor: Colors.white,
                                            alignLabelWithHint: true,
                                            border: OutlineInputBorder(
                                                borderRadius: borderRadiusMedium,
                                                borderSide: BorderSide.none),
                                            hintText: tPasswordThai,
                                            hintStyle: TextStyle(
                                                color: textColorBlack,
                                                fontSize: 15),
                                          ),
                                          validator: (String? value) {
                                            confirmPass = value;
                                            if (value!.isEmpty) {
                                              return "????????????????????????????????????????????????";
                                            } else if (value.length < 8) {
                                              return "???????????????????????????????????? 8 ???????????????????????????";
                                            } else {
                                              return null;
                                            }
                                          }),
              
                                      SizedBox(
                                        height: 10,
                                      ),
                                      TextFormField(
                                          // maxLength: 25,
                                          textInputAction: TextInputAction.done,
                                          keyboardType: TextInputType.text,
                                          autofocus: true,
                                          obscureText: !_passwordVisible,
                                          textAlign: TextAlign.start,
                                          style: TextStyle(
                                              color: textColorBlack,
                                              fontSize: 15),
                                          inputFormatters: [
                                            //MaskedInputFormatter('(###)-###-####')
                                          ],
                                          decoration: InputDecoration(
                                            // icon: Icon(Icons.phone_android),
                                            filled: true,
                                            prefixIcon: Icon(
                                              Icons.security_rounded,
                                              color: textColorBlack,
                                            ),
                                            fillColor: Colors.white,
                                            alignLabelWithHint: true,
                                            border: OutlineInputBorder(
                                                borderRadius: borderRadiusMedium,
                                                borderSide: BorderSide.none),
                                            hintText: tConfirmPassword,
                                            hintStyle: TextStyle(
                                                color: textColorBlack,
                                                fontSize: 15),
                                          ),
                                          validator: (String? value) {
                                            if (value!.isEmpty) {
                                              return "????????????????????????????????????????????????";
                                            } else if (value.length < 8) {
                                              return "???????????????????????????????????? 8 ???????????????????????????";
                                            } else if (value != confirmPass) {
                                              return "???????????????????????????????????????????????????????????????????????????";
                                            } else {
                                              return null;
                                            }
                                          }),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      // TextFormField(
                                      //     // maxLength: 25,
                                      //     maxLines: 1,
                                      //     keyboardType: TextInputType.text,
                                      //     autofocus: true,
                                      //     obscureText: true,
                                      //     textAlign: TextAlign.start,
                                      //     style: TextStyle(
                                      //         color: textColorBlack,
                                      //         fontSize: 15),
                                      //     inputFormatters: [
                                      //       //MaskedInputFormatter('(###)-###-####')
                                      //     ],
                                      //     decoration: InputDecoration(
                                      //       contentPadding:
                                      //           EdgeInsets.all(defualtPaddingLow),
                                      //       // icon: Icon(Icons.phone_android),
                                      //       filled: true,
                                      //       prefixIcon: Icon(
                                      //         Icons.location_on,
                                      //         color: textColorBlack,
                                      //       ),
                                      //       fillColor: Colors.white,
                                      //       alignLabelWithHint: true,
                                      //       border: OutlineInputBorder(
                                      //           borderRadius: borderRadiusMedium,
                                      //           borderSide: BorderSide.none),
                                      //       hintText: tLocationThai,
              
                                      //       hintStyle: TextStyle(
                                      //           color: textColorBlack,
                                      //           fontSize: 15),
                                      //     ),
                                      //     validator: MultiValidator([])),
              
                                      Row(
                                        children: [
                                          Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: <Widget>[
                                              GFButton(
                                                  shape: GFButtonShape.pills,
                                                  onPressed: () {
                                                    navigateLocationPicker(
                                                        context);
                                                  },
                                                  text: "??????????????????",
                                                  icon: Icon(
                                                    Icons.location_on,
                                                    color: textColorBlack,
                                                  ),
                                                  color: textColorWhite,
                                                  textColor: textColorBlack),
                                            ],
                                          ),
                                          // Text(
                                          //   locationResult == null
                                          //       ? "?????????????????????????????????????????????????????????"
                                          //       : "${locationResult!.latLng!.latitude}\n${locationResult!.latLng!.longitude}",
                                          //   style: const TextStyle(
                                          //       color: textColorBlack,
                                          //       fontSize: fontSizeM),
                                          // ),
                                          SizedBox(
                                            width: 10,
                                          ),
                                          Container(
                                            width: 200,
                                            child: Text(
                                                address.isEmpty
                                                    ? "?????????????????????????????????????????????????????????"
                                                    : "${address}",
                                                style: const TextStyle(
                                                    color: textColorBlack,
                                                    fontSize: fontSizeM),
                                                overflow: TextOverflow.ellipsis,
                                                maxLines: 2),
                                          )
                                        ],
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      // TextFormField(
                                      //   keyboardType: TextInputType.text,
                                      //   cursorColor: primaryColor,
                                      //   scrollPadding: EdgeInsets.only(top: 10),
                                      //   maxLines: 3,
                                      //   style: const TextStyle(
                                      //       color: textColorBlack,
                                      //       fontSize: fontSizeM),
                                      //   decoration: InputDecoration(
                                      //     filled: true,
                                      //     fillColor: Colors.white,
                                      //     focusedBorder: OutlineInputBorder(
                                      //       borderSide: BorderSide(
                                      //         color: primaryColor,
                                      //         width: 2,
                                      //       ),
                                      //     ),
                                      //     labelText: '?????????????????????????????????????????????????????????',
                                      //     alignLabelWithHint: true,
                                      //     contentPadding:
                                      //         EdgeInsets.all(defualtPaddingLow),
                                      //     labelStyle: TextStyle(
                                      //         fontSize: fontSizeM,
                                      //         color: textColorBlack),
                                      //     border: OutlineInputBorder(
                                      //         borderRadius: borderRadiusMedium,
                                      //         borderSide: BorderSide.none),
                                      //   ),
                                      //   validator: (value) {
                                      //     if (value!.isEmpty) {
                                      //       return 'Please enter some text';
                                      //     }
                                      //   },
                                      // ),
                                      //
              
                                      // time pick
                                      Container(
                                        child: Row(
                                          children: [
                                            Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: <Widget>[
                                                GFButton(
                                                    onPressed: () async {
                                                      TimeRange result =
                                                          await showTimeRangePicker(
                                                        context: context,
                                                      );
              
                                                      logger.d(
                                                          "opening time: ${result}");
                                                      timeRange = result;
                                                      setOpeningTime();
                                                    },
                                                    text: "????????????",
                                                    icon: Icon(Icons.av_timer),
                                                    shape: GFButtonShape.pills,
                                                    color: textColorWhite,
                                                    textColor: textColorBlack),
                                              ],
                                            ),
                                            SizedBox(
                                              width: 10,
                                            ),
                                            Text(
                                                openingTime.isEmpty
                                                    ? "????????????????????????????????????????????? - ?????????"
                                                    : "${openingTime}",
                                                style: const TextStyle(
                                                    color: textColorBlack,
                                                    fontSize: fontSizeM),
                                                overflow: TextOverflow.ellipsis,
                                                maxLines: 2)
                                          ],
                                        ),
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      WeekdaySelector(
                                        firstDayOfWeek: DateTime.sunday,
                                        shortWeekdays: [
                                          'Sun',
                                          'Mon',
                                          'Tue',
                                          'Wed',
                                          'Thu',
                                          'Fri',
                                          'Sat',
                                        ],
                                        selectedFillColor: textColorBlack,
                                        onChanged: (int day) {
                                          setState(() {
                                            // Use module % 7 as Sunday's index in the array is 0 and
                                            // DateTime.sunday constant integer value is 7.
                                            final index = day % 7;
                                            // We "flip" the value in this example, but you may also
                                            // perform validation, a DB write, an HTTP call or anything
                                            // else before you actually flip the value,
                                            // it's up to your app's needs.
                                            values[index] = !values[index];
                                          });
                                          logger
                                              .d("day: ${this.values.toList()}");
                                          setTimeOfDay();
                                        },
                                        values: values,
                                      ),
                                      Row(
                                        children: [
                                          Checkbox(
                                            checkColor: Colors.white,
                                            fillColor: MaterialStateProperty
                                                .resolveWith(getColor),
                                            value: twoWheelState,
                                            onChanged: (bool? value) {
                                              setState(() {
                                                twoWheelState = value!;
                                                _typeCarRepairs.add(
                                                    TypeCarRepairs(
                                                        type: 'two-wheel'));
                                              });
                                            },
                                          ),
                                          Image.asset(
                                            tImageAsset(
                                              'two-wheel',
                                            ),
                                            width: 25,
                                          ),
                                          SizedBox(
                                            width: 5,
                                          ),
                                          Text('Two-wheel')
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          Checkbox(
                                            checkColor: Colors.white,
                                            fillColor: MaterialStateProperty
                                                .resolveWith(getColor),
                                            value: threeWheelState,
                                            onChanged: (bool? value) {
                                              setState(() {
                                                threeWheelState = value!;
                                                _typeCarRepairs.add(
                                                    TypeCarRepairs(
                                                        type:
                                                            'three-wheel'));
                                              });
                                            },
                                          ),
                                          Image.asset(
                                            tImageAsset(
                                              'three-wheel',
                                            ),
                                            width: 25,
                                          ),
                                          SizedBox(
                                            width: 5,
                                          ),
                                          Text('Three-wheel')
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          Checkbox(
                                            checkColor: Colors.white,
                                            fillColor: MaterialStateProperty
                                                .resolveWith(getColor),
                                            value: fourWheelState,
                                            onChanged: (bool? value) {
                                              setState(() {
                                                fourWheelState = value!;
                                                _typeCarRepairs.add(
                                                    TypeCarRepairs(
                                                        type:
                                                            'four-wheel'));
                                              });
                                            },
                                          ),
                                          Image.asset(
                                            tImageAsset(
                                              'four-wheel',
                                            ),
                                            width: 25,
                                          ),
                                          SizedBox(
                                            width: 5,
                                          ),
                                          Text('Four-wheel')
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          Checkbox(
                                            checkColor: Colors.white,
                                            fillColor: MaterialStateProperty
                                                .resolveWith(getColor),
                                            value: heavyWheelState,
                                            onChanged: (bool? value) {
                                              setState(() {
                                                heavyWheelState = value!;
                                                _typeCarRepairs.add(
                                                    TypeCarRepairs(
                                                        type:
                                                            'heavy-wheel'));
                                              });
                                            },
                                          ),
                                          Image.asset(
                                            tImageAsset(
                                              'heavy-wheel',
                                            ),
                                            width: 25,
                                          ),
                                          SizedBox(
                                            width: 5,
                                          ),
                                          Text('Heavy-wheel')
                                        ],
                                      ),
                                      SizedBox(
                                        height: 30,
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            TextButton(
                                onPressed: () {
                                  if (_form.currentState!.validate()) {
                                    _garage.typeCarRepairs = _typeCarRepairs;
                                    navigateToLogin();
                                  }
                                },
                                style: TextButton.styleFrom(
                                  elevation: 2,
                                  shadowColor: Colors.black,
                                  shape: StadiumBorder(),
                                  padding: EdgeInsets.only(
                                      left: 110, right: 110, top: 20, bottom: 20),
                                  primary: textColorBlack,
                                  backgroundColor: textColorBlack,
                                  onSurface: Colors.black,
                                ),
                                child: Text(
                                  tRegistration,
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold),
                                )),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  void setOpeningTime() {
    if (timeRange != null) {
      logger.d(
          "start: ${timeRange!.startTime.hour}.${timeRange!.startTime.minute}, end: ${timeRange!.endTime.hour}.${timeRange!.endTime.minute}");
      setState(() {
        this.openingTime =
            "????????????: ${timeRange!.startTime.hour}.${timeRange!.startTime.minute} - ?????????: ${timeRange!.endTime.hour}.${timeRange!.endTime.minute}";
      });
      _garage.openingHour!.open =
          '${timeRange!.startTime.hour}.${timeRange!.startTime.minute}';
      _garage.openingHour!.close =
          '${timeRange!.endTime.hour}.${timeRange!.endTime.minute}';
    }
  }

  void setTimeOfDay() {
    _openingDayOfWeek.su = values[0];
    _openingDayOfWeek.mo = values[1];
    _openingDayOfWeek.tu = values[2];
    _openingDayOfWeek.we = values[3];
    _openingDayOfWeek.th = values[4];
    _openingDayOfWeek.fr = values[5];
    _openingDayOfWeek.sa = values[6];
    logger.d("openingDayOfWeek: ${_openingDayOfWeek.toJson()}");
    setState(() {
      _garage.openingDayOfWeek = _openingDayOfWeek;
    });
  }

  void navigateLocationPicker(BuildContext context) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => LocationPicker()),
    );
    setState(() {
      this.cameraPosition = result['cameraPosition'];
    });
    setState(() {
      this.address = result['address'];
    });
    this._garage.address.addressDesc = result['address'];
    this._garage.address.geoLocation.lat =
        this.cameraPosition.target.latitude.toString();
    this._garage.address.geoLocation.long =
        this.cameraPosition.target.longitude.toString();
  }

  void navigateBackToOtp() {
    Navigator.of(context).pop();
  }

  void navigateToLogin() {
    Navigator.pushReplacementNamed(context, LOGIN_ROUTE);
  }

  void register() {
    _registerBloc.add(RegisterButtonPressed(garage: _garage));
  }

  @override
  void dispose() {
    // Clean up the controller when the widget is removed from the widget tree.
    // This also removes the _printLatestValue listener.
    _controller.dispose();
    super.dispose();
  }
}
