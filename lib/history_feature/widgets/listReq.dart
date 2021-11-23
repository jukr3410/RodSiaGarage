import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:rodsiagarage/constants.dart';
import 'package:rodsiagarage/core/models/garage_model.dart';
import 'package:rodsiagarage/core/models/request_service_model.dart';
import 'package:rodsiagarage/history_feature/bloc/request_service_bloc.dart';

class ListReq extends StatefulWidget {
  final Garage garage;
  ListReq({Key? key, required this.garage}) : super(key: key);

  @override
  _ListReqState createState() => _ListReqState();
}

class _ListReqState extends State<ListReq> {
  late RequestServiceBloc _requestServiceBloc;
  List<RequestService> _reqServices = [];
  Widget _widget = Center(
    child: CircularProgressIndicator(),
  );

  @override
  void initState() {
    _requestServiceBloc = BlocProvider.of<RequestServiceBloc>(context)
      ..add(RequestServiceLoad());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   backgroundColor: primaryColor,
      //   centerTitle: true,
      //   title: Text('ประวัติการใช้งาน'),
      //   iconTheme: IconThemeData(color: textColorBlack),
      //   titleTextStyle: TextStyle(
      //       color: textColorBlack, fontSize: fontSizeXXl, fontFamily: 'Kanit'),
      // ),
      body: BlocConsumer<RequestServiceBloc, RequestServiceState>(
          listener: (context, state) {},
          builder: (context, state) {
            print(state.toString());
            if (state is RequestServicesLoadSuccess) {
              for (var i = 0; i < state.requestServices.length; i++) {
                if (state.requestServices[i].status == 'รอการตอบรับ') {
                  _reqServices.add(state.requestServices[i]);
                }
                _widget = ListView.builder(
                    shrinkWrap: true,
                    scrollDirection: Axis.vertical,
                    itemCount: _reqServices.length,
                    itemBuilder: (context, index) {
                      return cardNotify(_reqServices[index]);
                    });
              }
            } else if (state is RequestServicesError) {
              _widget = Center(child: Text('ยังไม่มีการขอใข้บริการ!'));
            }
            return _widget;
          }),
    );
  }

  Widget cardNotify(RequestService requestService) {
    return GestureDetector(
      child: Card(
        elevation: 2,
        margin: new EdgeInsets.symmetric(
            horizontal: defualtPaddingLow - 2, vertical: defualtPaddingLow - 7),
        color: cardColor,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              SizedBox(
                width: 10,
              ),
              Image.asset(
                tImageAsset(requestService.service.serviceType.name),
                width: 35,
                height: 35,
                fit: BoxFit.cover,
              ),
              SizedBox(
                width: 20,
              ),
              Expanded(
                flex: 12,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      requestService.service.name,
                      softWrap: true,
                      maxLines: 1,
                      overflow: TextOverflow.fade,
                      style: new TextStyle(
                          fontSize: fontSizeXl - 1,
                          fontWeight: FontWeight.bold,
                          color: textColorBlack),
                    ),
                    Text(
                      requestService.user.name,
                      softWrap: true,
                      maxLines: 1,
                      overflow: TextOverflow.fade,
                      style: new TextStyle(
                          fontSize: fontSizeM - 1,
                          fontWeight: FontWeight.bold,
                          color: textColorBlack),
                    ),
                    Row(
                      children: [
                        Text(
                          DateFormat('dd-MMM-yyyy | HH:MM น.').format(
                              DateTime.parse(
                                  requestService.createdAt.toString())),
                          style: TextStyle(
                              color: textColorBlack, fontSize: fontSizeM - 2),
                        ),
                        Text(" ~ "),
                        Text(
                          "12 กก.",
                          style: TextStyle(
                            color: textColorBlack,
                            fontSize: fontSizeM - 2,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Expanded(
                flex: 2,
                child: Icon(
                  Icons.navigate_next,
                  size: 40,
                ),
              )

              // )
            ],
          ),
        ),
      ),
      onTap: () {
        navigatorToShowDetailReq(requestService);
      },
    );
  }

  navigatorToShowDetailReq(RequestService req) {
    Navigator.pushNamed(context, SHOWINFO_DETAILREQ_ROUTE, arguments: req);
  }
}
