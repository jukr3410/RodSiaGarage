import 'package:flutter/material.dart';
import 'package:rodsiagarage/constants.dart';
import 'package:rodsiagarage/global_widgets/InboxPage.dart';
import 'package:rodsiagarage/global_widgets/hexTocolor.dart';
import 'package:rodsiagarage/global_widgets/homePage.dart';
import 'package:rodsiagarage/global_widgets/notifyPage.dart';
import 'package:rodsiagarage/global_widgets/profilePage.dart';

class BottomNavigrationBar extends StatefulWidget {
  BottomNavigrationBar({Key? key}) : super(key: key);
  static const routeName = '/';

  @override
  _BottomNavigrationBarState createState() => _BottomNavigrationBarState();
}

class _BottomNavigrationBarState extends State<BottomNavigrationBar> {
  int _selectedIndex = 0;

  List<Widget> _pageWidget = <Widget>[
    ProfilePage(),
    InboxPage(),
  ];
  List<BottomNavigationBarItem> _menuBar = <BottomNavigationBarItem>[
    BottomNavigationBarItem(
        icon: Container(
          margin: EdgeInsets.only(right: 20),
          child: ImageIcon(AssetImage("assets/images/icon-profile.png")),
        ),
        label: 'Profile'),
    BottomNavigationBarItem(
        icon: Container(
          margin: EdgeInsets.only(left: 20),
          child: ImageIcon(AssetImage("assets/images/icon-inbox.png")),
        ),
        label: 'Inbox'),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pageWidget.elementAt(_selectedIndex),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: Container(height: 60, width: 60, child: HomePage()),
      bottomNavigationBar: Container(
        child: BottomNavigationBar(
          items: _menuBar,
          currentIndex: _selectedIndex,
          // selectedItemColor: Theme.of(context).primaryColor,
          unselectedItemColor: Colors.grey.shade500,
          onTap: _onItemTapped,
          fixedColor: Colors.black,
          type: BottomNavigationBarType.fixed,
          selectedFontSize: 13,
          showUnselectedLabels: false,
          showSelectedLabels: false,
          unselectedIconTheme: IconThemeData(size: 24),
          backgroundColor: hexToColor(primaryCodeColor),
          // backgroundColor: Color(0xFECE2F),
        ),
      ),
    );
  }
}
