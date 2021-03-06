import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:getwidget/components/button/gf_button.dart';
import 'package:getwidget/types/gf_button_type.dart';
import 'package:rodsiagarage/constants.dart';
import 'package:rodsiagarage/core/models/garage_model.dart';
import 'package:rodsiagarage/core/models/service_model.dart';
import 'package:rodsiagarage/core/models/user_model.dart';
import 'package:rodsiagarage/garage_manage_feature/bloc/service_bloc.dart';
import 'package:rodsiagarage/home_feature/widgets/carouselImage.dart';
import 'package:rodsiagarage/profile_feature/widgets/buttonToEditProfile.dart';
import 'package:rodsiagarage/profile_feature/widgets/infoAddress.dart';

import 'package:rodsiagarage/profile_feature/widgets/infoProfile.dart';

class ProfilePage extends StatefulWidget {
  final Garage garage;
  ProfilePage({Key? key, required this.garage}) : super(key: key);

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  List<Service> _services = [];
  late ServiceBloc _serviceBloc;

  @override
  void initState() {
    _serviceBloc = BlocProvider.of<ServiceBloc>(context)
      ..add(ServiceLoad(garageId: widget.garage.id));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(color: bgColor
          // gradient: LinearGradient(
          //     begin: Alignment.topLeft,
          //     end: Alignment.bottomRight,
          //     colors: [
          //   Colors.yellow.shade800,
          //   Colors.yellow.shade400,
          //   Colors.yellow.shade50
          // ])
          ),
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          iconTheme: IconThemeData(color: textColorBlack),
          title: Align(
            alignment: Alignment.centerRight,
            child: buttonToEditProfile(
              garage: widget.garage,
            ),
          ),
          backgroundColor: primaryColor,
          leading: IconButton(
              icon: Icon(Icons.arrow_back_ios, color: textColorBlack),
              onPressed: () =>
                  Navigator.of(context).popUntil((route) => route.isFirst)),
        ),
        backgroundColor: Colors.transparent,
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(defualtPaddingMedium),
            child: BlocConsumer<ServiceBloc, ServiceState>(
              listener: (context, state) {
                if (state is ServicesLoadSuccess) {
                  _services = state.services;
                }
              },
              builder: (context, state) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    InfoProfile(
                      garage: widget.garage,
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      '?????????????????????????????????-?????????:',
                      style: TextStyle(
                          fontSize: fontSizeM, fontWeight: FontWeight.w600),
                    ),
                    Text(_showOpenDate()),
                    Text(
                        '${widget.garage.openingHour!.open.toString()} - ${widget.garage.openingHour!.close.toString()} ???.'),
                    SizedBox(
                      height: 10,
                    ),
                    Text('????????????????????????'+tServiceThai + ': ',
                        style: TextStyle(
                            fontSize: fontSizeM, fontWeight: FontWeight.w600)),
                    Container(
                      width: 200,
                      height: 25,
                      child: ListView.builder(
                          shrinkWrap: true,
                          scrollDirection: Axis.horizontal,
                          itemCount: widget.garage.typeCarRepairs.length,
                          itemBuilder: (context, index) {
                            return Row(
                              children: [
                                Image.asset(
                                  tImageAsset(
                                      widget.garage.typeCarRepairs[index].type),
                                  width: 25,
                                ),
                                SizedBox(
                                  width: 5,
                                )
                              ],
                            );
                          }),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    InfoAddress(
                      garage: widget.garage,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      '?????????????????????????????????????????????:',
                      style: TextStyle(
                          fontSize: fontSizeM, fontWeight: FontWeight.w600),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    CarouselImage(images: widget.garage.images!),
                    SizedBox(
                      height: 10,
                    ),
                    Align(
                      child: Column(
                        children: [
                          Container(
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: textColorBlack),
                              child: IconButton(
                                icon: Icon(Icons.edit),
                                onPressed: () {
                                  navigatorToEditImages();
                                },
                                color: primaryColor,
                              )),
                          SizedBox(
                            height: 5,
                          ),
                          Text('?????????????????????????????????')
                        ],
                      ),
                    )
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }

  String _showOpenDate() {
    String sun = widget.garage.openingDayOfWeek!.su == true ? 'Sun, ' : '';
    String mon = widget.garage.openingDayOfWeek!.mo == true ? 'Mon, ' : '';
    String tue = widget.garage.openingDayOfWeek!.tu == true ? 'Tue, ' : '';
    String wed = widget.garage.openingDayOfWeek!.we == true ? 'Wed, ' : '';
    String thu = widget.garage.openingDayOfWeek!.th == true ? 'Thu, ' : '';
    String fri = widget.garage.openingDayOfWeek!.fr == true ? 'Fri, ' : '';
    String sat = widget.garage.openingDayOfWeek!.sa == true ? 'Sat, ' : '';

    String opentime = "$sun$mon$tue$wed$thu$fri$sat";
    return opentime;
  }

  navigatorToMenuPage() {
    Navigator.pushNamed(context, MAIN_ROUTE);
  }

  navigatorToEditImages() {
    Navigator.pushNamed(context, EDIR_IMAGES_ROUTE, arguments: widget.garage);
  }
}
