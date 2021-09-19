import 'package:flutter/material.dart';
import 'package:fswitch/fswitch.dart';
import 'package:rodsiagarage/constants.dart';
import 'package:rodsiagarage/global_widgets/InboxPage.dart';
import 'package:rodsiagarage/global_widgets/hexTocolor.dart';
import 'package:rodsiagarage/home_feature/widgets/homePage.dart';
import 'package:rodsiagarage/global_widgets/notifyPage.dart';
import 'package:rodsiagarage/global_widgets/profilePage.dart';
import 'package:fancy_bottom_navigation/fancy_bottom_navigation.dart';

class BottomNavigrationBar extends StatefulWidget {
  BottomNavigrationBar({Key? key}) : super(key: key);

  @override
  _BottomNavigrationBarState createState() => _BottomNavigrationBarState();
}

class _BottomNavigrationBarState extends State<BottomNavigrationBar> {
  int _selectedIndex = 0;
  bool status = true;

  List<BottomNavigationBarItem> _menuBar = <BottomNavigationBarItem>[
    BottomNavigationBarItem(
        icon: Container(
          margin: EdgeInsets.only(left: 30),
          child: ImageIcon(AssetImage(tImageAsset('profile'))),
        ),
        label: 'Profile'),
    BottomNavigationBarItem(
        label: 'HomePage',
        icon: Container(
          margin: EdgeInsets.only(bottom: 10),
          child: CircleAvatar(
            backgroundColor: Colors.white,
            child: ImageIcon(
              AssetImage(tImageAsset('home')),
            ),
          ),
        )),
    BottomNavigationBarItem(
        icon: Container(
          margin: EdgeInsets.only(right: 30),
          child: ImageIcon(AssetImage(tImageAsset('inbox'))),
        ),
        label: 'Inbox'),
  ];
  List<TabData> _menuBarTest = <TabData>[
    TabData(iconData: Icons.account_circle_sharp, title: "Profile"),
    TabData(iconData: Icons.home, title: "Home"),
    TabData(iconData: Icons.message, title: "Inbox")
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> _pageWidget = <Widget>[
      ProfilePage(),
      HomePage(),
      InboxPage(),
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
              initialSelection: 1,
              inactiveIconColor: textColorBlack,
              circleColor: textColorBlack,
            ),
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
          Align(
            alignment: Alignment.center,
            child: FSwitch(
              open: status,
              height: 35,
              width: 80,
              onChanged: (v) {
                setState(() {
                  status = v;
                  if (status == true) {
                    print('Status: Online');
                  } else {
                    print('Status: Offline');
                  }
                });
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
              openColor: Colors.green.shade800,
            ),
          ),
          Align(
            alignment: Alignment.centerRight,
            child: TextButton(
                onPressed: () {},
                child: ImageIcon(
                  AssetImage('assets/images/icon-notify.png'),
                  color: textColorBlack,
                )),
          ),
        ],
      ),
    );
  }
}
