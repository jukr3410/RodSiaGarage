import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fswitch/fswitch.dart';
import 'package:locally/locally.dart';
import 'package:rodsiagarage/authentication/bloc/authentication_bloc.dart';
import 'package:rodsiagarage/constants.dart';
import 'package:rodsiagarage/core/models/garage_model.dart';
import 'package:rodsiagarage/core/models/request_service_model.dart';
import 'package:rodsiagarage/core/repository/garage_repository.dart';
import 'package:rodsiagarage/core/repository/request_service_api.dart';
import 'package:rodsiagarage/global_widgets/InboxPage.dart';
import 'package:rodsiagarage/global_widgets/alertPopupYesNo.dart';
import 'package:rodsiagarage/global_widgets/alertShowChangeStatus.dart';
import 'package:rodsiagarage/global_widgets/hexTocolor.dart';
import 'package:rodsiagarage/global_widgets/menusSetting.dart';
import 'package:rodsiagarage/history_feature/bloc/request_service_bloc.dart';
import 'package:rodsiagarage/history_feature/widgets/viewbar.dart';
import 'package:rodsiagarage/home/appBar.dart';
import 'package:rodsiagarage/home/bloc/home_bloc.dart';
import 'package:rodsiagarage/home_feature/bloc/garage_info_bloc.dart';
import 'package:rodsiagarage/home_feature/widgets/homePage.dart';
import 'package:fancy_bottom_navigation/fancy_bottom_navigation.dart';
import 'package:rodsiagarage/main.dart';
import 'package:rodsiagarage/notify_feature/widgets/notifyPage.dart';
import 'package:rodsiagarage/profile_feature/bloc/profile_bloc.dart';
import 'package:rodsiagarage/profile_feature/widgets/ProfilePage.dart';

class BottomNavigrationBar extends StatefulWidget {
  final Garage garage;
  BottomNavigrationBar({Key? key, required this.garage}) : super(key: key);

  @override
  _BottomNavigrationBarState createState() => _BottomNavigrationBarState();
}

class _BottomNavigrationBarState extends State<BottomNavigrationBar> {
  int _selectedIndex = 0;
  bool status = true;

  late GarageInfoBloc _garageInfoBloc;
  late RequestServiceBloc _requestServiceBloc;

  RequestServiceApi requestServiceApi = RequestServiceApi();
  List<RequestService> requestServices = [];

  showMessage() {
    Locally locally;
    logger.d('showMessage');
    locally = Locally(
      context: context,
      payload: 'test',
      pageRoute: MaterialPageRoute(
          builder: (_) => MultiBlocProvider(providers: [
                BlocProvider(
                    create: (BuildContext context) => AuthenticationBloc(
                        garageRepository: GarageRepository())),
                BlocProvider(
                  create: (BuildContext context) => HomeBloc(),
                ),
                BlocProvider(
                  create: (BuildContext context) =>
                      ProfileBloc(garageRepository: GarageRepository()),
                ),
                BlocProvider(
                    create: (BuildContext context) =>
                        GarageInfoBloc(garageRepository: GarageRepository()))
              ], child: CustomAppBar())),
      appIcon: 'mipmap/ic_launcher',
    );
    locally.show(title: "บริการรถเสีย", message: "มีคำขอใช้บริการใหม่");
  }

  @override
  void initState() {
    _garageInfoBloc = BlocProvider.of<GarageInfoBloc>(context)
      ..add(GarageInfoLoad());
    _requestServiceBloc = BlocProvider.of<RequestServiceBloc>(context)
      ..add(RequestServiceLoadWithStatusRealTime(status: 'รอยืนยัน'));
    super.initState();
  }

  // List<BottomNavigationBarItem> _menuBar = <BottomNavigationBarItem>[
  //   BottomNavigationBarItem(
  //       icon: Container(
  //         margin: EdgeInsets.only(left: 30),
  //         child: ImageIcon(AssetImage(tImageAsset('profile'))),
  //       ),
  //       label: 'Profile'),
  //   BottomNavigationBarItem(
  //       label: 'HomePage',
  //       icon: Container(
  //         margin: EdgeInsets.only(bottom: 10),
  //         child: CircleAvatar(
  //           backgroundColor: Colors.white,
  //           child: ImageIcon(
  //             AssetImage(tImageAsset('home')),
  //           ),
  //         ),
  //       )),
  //   BottomNavigationBarItem(
  //       icon: Container(
  //         margin: EdgeInsets.only(right: 30),
  //         child: ImageIcon(AssetImage(tImageAsset('inbox'))),
  //       ),
  //       label: 'Inbox'),
  // ];

  List<TabData> _menuBarTest = <TabData>[
    TabData(iconData: Icons.home, title: "หน้าหลัก"),
    TabData(iconData: Icons.history, title: "การใช้บริการ"),
    TabData(iconData: Icons.format_align_left, title: "เพิ่มเติม"),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> _pageWidget = <Widget>[
      HomePage(),
      ViewBars(garage: widget.garage),
      MenusSetting(garage: widget.garage),
    ];
    return BlocListener<RequestServiceBloc, RequestServiceState>(
      listener: (context, state) {
        if (state is RequestServicesLoadRealTimeSuccess) {
          if (requestServices.length < state.requestServices.length) {
            showMessage();
          }
          requestServices = state.requestServices;
        }
      },
      child: SafeArea(
        child: Scaffold(
            appBar: setAppBar(),
            body: _pageWidget.elementAt(_selectedIndex),
            extendBody: true,

            // floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
            // floatingActionButton:
            //     Container(height: 60, width: 60, child: _buttonHomePage()),
            bottomNavigationBar: Container(
              height: 60,
              child: FancyBottomNavigation(
                  tabs: _menuBarTest,
                  onTabChangedListener: _onItemTapped,
                  barBackgroundColor: primaryColor,
                  initialSelection: 0,
                  inactiveIconColor: textColorBlack,
                  circleColor: textColorBlack,
                  textColor: Colors.transparent),
            )
            // BottomNavigationBar(
            //   items: _menuBar,
            //   currentIndex: _selectedIndex,
            //   unselectedItemColor: Colors.grey.shade700,
            //   onTap: _onItemTapped,
            //   fixedColor: Colors.black,
            //   type: BottomNavigationBarType.fixed,
            //   selectedFontSize: 13,
            //   showUnselectedLabels: false,
            //   showSelectedLabels: false,
            //   unselectedIconTheme: IconThemeData(size: 24),
            //   backgroundColor: hexToColor(primaryCodeColor),
            // ),
            ),
      ),
    );
  }

  setAppBar() {
    return AppBar(
      backgroundColor: primaryColor,
      automaticallyImplyLeading: false,
      title: Align(
        alignment: Alignment.centerRight,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            CircleAvatar(
              backgroundColor: isGarageOpen(widget.garage) == 'เปิด'
                  ? greenStatus
                  : redStatus,
              maxRadius: 5,
            ),
            SizedBox(
              width: 5,
            ),
            Text(
              'สถานะ: ร้าน' + isGarageOpen(widget.garage),
              style: TextStyle(color: textColorBlack, fontSize: fontSizeM),
            ),
          ],
        ),
        // FSwitch(
        //     open: status,
        //     height: 30,
        //     width: 75,
        //     onChanged: (v) {
        //       _navigateToChangeStatus(context, v);
        //     },
        //     closeChild: Text(
        //       'Offline',
        //       style: TextStyle(fontSize: 12),
        //     ),
        //     openChild: Text(
        //       'Online',
        //       style: TextStyle(
        //         fontSize: 12,
        //       ),
        //     ),
        //     openColor: Colors.green.shade600,
        //   ),
      ),
    );
  }

  String isGarageOpen(Garage garage) {
    DateTime now = DateTime.now();

    // logger.d(now.hour.toString() +
    //     ":" +
    //     now.minute.toString() +
    //     ":" +
    //     now.second.toString() +
    //     ", day: " +
    //     now.weekday.toString());
    var openGarage = garage.openingHour!.open.split(".");
    var closeGarage = garage.openingHour!.close.split(".");
    // logger.d(openGarage);
    var openHour = int.parse(openGarage[0]);
    var openMinute = int.parse(openGarage[1]);
    var closeHour = int.parse(closeGarage[0]);
    var closeMinute = int.parse(closeGarage[1]);

    var status = "ปิด";
    var textColor = textColorRed;

    switch (now.weekday) {
      case 1:
        if ((garage.openingDayOfWeek!.mo == true) &&
            (now.hour >= openHour && now.minute >= openMinute)) {
          status = "เปิด";
          textColor = textColorGreen;
          if (now.hour > closeHour && now.minute > closeMinute) {
            status = "ปิด";
            textColor = textColorRed;
          }
        }
        break;
      case 2:
        if ((garage.openingDayOfWeek!.tu == true) &&
            (now.hour >= openHour && now.minute >= openMinute)) {
          status = "เปิด";
          textColor = textColorGreen;
          if (now.hour > closeHour && now.minute > closeMinute) {
            status = "ปิด";
            textColor = textColorRed;
          }
        }
        break;
      case 3:
        if ((garage.openingDayOfWeek!.we == true) &&
            (now.hour >= openHour && now.minute >= openMinute)) {
          status = "เปิด";
          textColor = textColorGreen;
          if (now.hour > closeHour && now.minute > closeMinute) {
            status = "ปิด";
            textColor = textColorRed;
          }
        }
        break;
      case 4:
        if ((garage.openingDayOfWeek!.th == true) &&
            (now.hour >= openHour && now.minute >= openMinute)) {
          status = "เปิด";
          textColor = textColorGreen;
          if (now.hour > closeHour && now.minute > closeMinute) {
            status = "ปิด";
            textColor = textColorRed;
          }
        }
        break;
      case 5:
        if ((garage.openingDayOfWeek!.fr == true) &&
            (now.hour >= openHour && now.minute >= openMinute)) {
          status = "เปิด";
          textColor = textColorGreen;
          if (now.hour > closeHour && now.minute > closeMinute) {
            status = "ปิด";
            textColor = textColorRed;
          }
        }
        break;
      case 6:
        if ((garage.openingDayOfWeek!.sa == true) &&
            (now.hour >= openHour && now.minute >= openMinute)) {
          status = "เปิด";
          textColor = textColorGreen;
          if (now.hour > closeHour && now.minute > closeMinute) {
            status = "ปิด";
            textColor = textColorRed;
          }
        }
        break;
      case 7:
        if ((garage.openingDayOfWeek!.su == true) &&
            (now.hour >= openHour && now.minute >= openMinute)) {
          status = "เปิด";
          textColor = textColorGreen;
          if (now.hour > closeHour && now.minute > closeMinute) {
            status = "ปิด";
            textColor = textColorRed;
          }
        }
        break;
    }
    return status;
  }

  void _navigateToChangeStatus(BuildContext context, bool v) async {
    await showDialog<String>(
        context: context,
        builder: (BuildContext context) => AlertShowChangeStatus());

    setState(() {
      status = v;
      if (status == true) {
        print('Status: Online');
      } else {
        print('Status: Offline');
      }
    });
  }
}
