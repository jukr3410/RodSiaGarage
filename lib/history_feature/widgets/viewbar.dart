import 'package:flutter/material.dart';
import 'package:rodsiagarage/core/models/garage_model.dart';

import 'package:rodsiagarage/global_widgets/hexTocolor.dart';
import 'package:rodsiagarage/constants.dart';
import 'package:rodsiagarage/history_feature/widgets/displayHistory.dart';
import 'package:rodsiagarage/history_feature/widgets/displayReq.dart';

class ViewBars extends StatefulWidget {
  final Garage garage;
  ViewBars({Key? key, required this.garage}) : super(key: key);

  @override
  _ViewBarsState createState() => _ViewBarsState();
}

class _ViewBarsState extends State<ViewBars>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    _tabController = TabController(length: 2, vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _tabController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              children: [
                Expanded(
                  child: Container(
                    margin: EdgeInsets.only(
                        bottom: 10, top: 10, right: 20, left: 20),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: borderRadiusHight,
                        boxShadow: [boxShadow]),
                    child: TabBar(
                      controller: _tabController,
                      // give the indicator a decoration (color and border radius)
                      indicator: BoxDecoration(
                        borderRadius: BorderRadius.circular(
                          25.0,
                        ),
                        color: hexToColor(primaryCodeColor),
                      ),
                      labelColor: textColorBlack,
                      labelStyle: TextStyle(fontSize: 15),
                      unselectedLabelColor: hexToColor(primaryCodeColor),
                      tabs: [
                        // first tab [you can add an icon using the icon property]
                        Tab(
                          child: Text(
                            'กำลังรอการตอบรับ',
                            style: TextStyle(fontFamily: 'Kanit'),
                          ),
                          iconMargin: EdgeInsets.only(bottom: 2, top: 5),
                        ),

                        // second tab [you can add an icon using the icon property]
                        Tab(
                          child: Text(
                            'ประวัติการให้บริการ',
                            style: TextStyle(fontFamily: 'Kanit'),
                          ),
                          iconMargin: EdgeInsets.only(bottom: 2, top: 5),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            Expanded(
              child: TabBarView(
                controller: _tabController,
                children: [
                  // first tab bar view widget
                  Center(
                      child: DisplayReq(
                    garage: widget.garage,
                  )),

                  // second tab bar view widget
                  // Center(
                  //   child: Text(
                  //     'List view',
                  //     style: TextStyle(
                  //       fontSize: 25,
                  //       fontWeight: FontWeight.w600,
                  //     ),
                  //   ),
                  // ),

                  Center(
                    child: DisplayHistory(
                      garage: widget.garage,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
