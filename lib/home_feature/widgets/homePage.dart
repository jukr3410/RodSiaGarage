import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:rodsiagarage/constants.dart';
import 'package:rodsiagarage/core/dao/garage_dao.dart';
import 'package:rodsiagarage/core/models/garage_model.dart';
import 'package:rodsiagarage/home_feature/bloc/garage_info_bloc.dart';
import 'package:rodsiagarage/home_feature/widgets/carouselImage.dart';
import 'package:rodsiagarage/utils/local_notification_helper.dart';

class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late GarageInfoBloc _garageInfoBloc;

  final notifications = FlutterLocalNotificationsPlugin();

  @override
  void initState() {
    _garageInfoBloc = BlocProvider.of<GarageInfoBloc>(context)
      ..add(GarageInfoLoad());
    super.initState();

    //Android Settings
    //here to parse the app icon that is in the folder : android/app/src/main/res/drawable
    final settingsAndroid = AndroidInitializationSettings('app_icon');

    //iOS Settings
    final settingsIOS = IOSInitializationSettings(
        onDidReceiveLocalNotification: (id, title, body, payload) {
      return onSelectNotification(payload: payload.toString());
    });

    notifications.initialize(
        InitializationSettings(android: settingsAndroid, iOS: settingsIOS),
        onSelectNotification: onSelectNotification(
            payload: "test")); //the action when click the notification
  }

  onSelectNotification({required String payload}) {
    return Navigator.pushNamed(context, SUPPORT_CENTER_ROUTE);
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<GarageInfoBloc, GarageInfoState>(
        builder: (context, state) {
      if (state is GarageInfoLoadSuccess) {
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
                          child:
                              _profileImage(state.garage.logoImage.toString())),
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          state.garage.name,
                          style: TextStyle(
                              fontSize: fontSizeXXl,
                              fontWeight: FontWeight.w600),
                          softWrap: true,
                          maxLines: 1,
                        ),
                        Row(
                          children: [
                            Text(
                              tPhone + ': ',
                              style: TextStyle(
                                  color: Colors.grey.shade700,
                                  fontSize: fontSizeM),
                            ),
                            Text(
                              state.garage.phone,
                              style: TextStyle(
                                  color: Colors.grey.shade700,
                                  fontSize: fontSizeM),
                            )
                          ],
                        ),
                        Row(
                          children: [
                            Text(
                              tEmailThai + ': ',
                              style: TextStyle(
                                  color: Colors.grey.shade700,
                                  fontSize: fontSizeM),
                            ),
                            Text(
                              state.garage.email,
                              style: TextStyle(
                                  color: Colors.grey.shade700,
                                  fontSize: fontSizeM),
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
                CarouselImage(images: state.garage.images!),
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
                                navigateToService(state.garage);
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
                                // navigatorTosupportCenter();
                                showOngoingNotification(notifications,
                                    title: 'Title', body: 'Body');
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
      return Container(
        color: textColorWhite,
        child: Center(
            child: CircularProgressIndicator(
          valueColor: AlwaysStoppedAnimation<Color>(primaryColor),
        )),
      );
    }, listener: (context, state) {
      return;
    });
  }

  _profileImage(String image) {
    if (image == '') {
      return Image.asset(tImageAsset('profile'));
    } else {
      return CachedNetworkImage(
        imageUrl: image,
        placeholder: (context, url) => CircularProgressIndicator(
          color: textColorBlack,
        ),
        errorWidget: (context, url, error) => Icon(Icons.error),
        fit: BoxFit.cover,
        width: 100,
        height: 100,
      );
    }
  }

  void navigateToService(Garage garage) {
    Navigator.pushNamed(context, SERVICE_LIST_ROUTE, arguments: garage);
  }

  void navigatorTosupportCenter() {
    Navigator.pushNamed(context, SUPPORT_CENTER_ROUTE);
  }

  void navigatorToHistory() {
    Navigator.pushNamed(context, HISTORY_ROUTE);
  }

  // test navigate
  void navigatorToRecap() {
    Navigator.pushNamed(context, RECAP_DETAIL_REQUREST_ROUTE);
  }

  void trackingRequestService() {
    Navigator.pushNamed(context, TRACKING_REQUEST_ROUTE);
  }
}
