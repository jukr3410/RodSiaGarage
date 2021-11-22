import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fswitch/fswitch.dart';
import 'package:rodsiagarage/constants.dart';
import 'package:rodsiagarage/core/models/garage_model.dart';
import 'package:rodsiagarage/global_widgets/InboxPage.dart';
import 'package:rodsiagarage/global_widgets/alertPopupYesNo.dart';
import 'package:rodsiagarage/global_widgets/alertShowChangeStatus.dart';
import 'package:rodsiagarage/global_widgets/hexTocolor.dart';
import 'package:rodsiagarage/global_widgets/menusSetting.dart';
import 'package:rodsiagarage/home_feature/bloc/garage_info_bloc.dart';
import 'package:rodsiagarage/home_feature/widgets/homePage.dart';
import 'package:fancy_bottom_navigation/fancy_bottom_navigation.dart';
import 'package:rodsiagarage/notify_feature/widgets/notifyPage.dart';
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
  @override
  void initState() {
    _garageInfoBloc = BlocProvider.of<GarageInfoBloc>(context)
      ..add(GarageInfoLoad());
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
    TabData(iconData: Icons.notifications, title: "แจ้งเตือน"),
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
      NotifyPage(),
      MenusSetting(garage: widget.garage),
    ];
    return SafeArea(
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
                textColor: textColorBlack),
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
    );
  }

  setAppBar() {
    return AppBar(
      backgroundColor: primaryColor,
      title: Stack(
        alignment: Alignment.center,
        children: [
          // Align(
          //     alignment: Alignment.centerLeft,
          //     child: Text(
          //       _menuBarTest[_selectedIndex].title,
          //       style: TextStyle(color: textColorBlack),
          //     )),
          Align(
            alignment: Alignment.centerRight,
            child: FSwitch(
              open: status,
              height: 30,
              width: 75,
              onChanged: (v) {
                _navigateToChangeStatus(context, v);
              },
              closeChild: Text(
                'Offline',
                style: TextStyle(fontSize: 12),
              ),
              openChild: Text(
                'Online',
                style: TextStyle(
                  fontSize: 12,
                ),
              ),
              openColor: Colors.green.shade600,
            ),
          ),
          // Align(
          //   alignment: Alignment.centerRight,
          //   child: IconButton(
          //     icon: Icon(
          //       Icons.notifications,
          //       color: textColorBlack,
          //       size: 30,
          //     ),
          //     onPressed: () {},
          //   ),
          // ),
        ],
      ),
    );
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
