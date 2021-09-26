import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:getwidget/getwidget.dart';
import 'package:intl/intl.dart';
import 'package:rodsiagarage/constants.dart';
import 'package:rodsiagarage/core/models/request_service_model.dart';
import 'package:rodsiagarage/core/models/service_model.dart';
import 'package:rodsiagarage/core/models/service_type_model.dart';
import 'package:rodsiagarage/garage_manage_feature/bloc/service_bloc.dart';
import 'package:rodsiagarage/global_widgets/alertPopupYesNo.dart';
import 'package:rodsiagarage/global_widgets/hexTocolor.dart';
import 'package:rodsiagarage/main.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:direct_select/direct_select.dart';

import 'package:top_snackbar_flutter/top_snack_bar.dart';

class AddServiceScreen extends StatefulWidget {
  AddServiceScreen({Key? key}) : super(key: key);

  @override
  _AddServiceScreenState createState() => _AddServiceScreenState();
}

class _AddServiceScreenState extends State<AddServiceScreen> {
  //final _formKey = GlobalKey<FormBuilderState>();
  FocusNode myFocusNode = new FocusNode();
  FocusNode myFocusNode1 = new FocusNode();

  Service _service = Service(id: "", name: "", description: "");
  ServiceType _serviceType = ServiceType(id: '', name: '', description: '');

  int val = -1;

  late ServiceBloc _serviceBloc;
  final _controller = TextEditingController();
  static final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    _serviceBloc = BlocProvider.of<ServiceBloc>(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        iconTheme: IconThemeData(color: textColorBlack),
        backgroundColor: primaryColor,
        centerTitle: true,
        title: Text(
          tAddService,
          style: TextStyle(color: textColorBlack, fontSize: fontSizeSemiLarge),
        ),
      ),
      body: setBody(),
    );
  }

  setBody() {
    //_service!.serviceType = ServiceType(id: "1234", name: "134", description: "1234");
    return Center(
        child:
            BlocConsumer<ServiceBloc, ServiceState>(listener: (context, state) {
      if (state is ServiceAdded) {
        navigateToServiceList();
        showTopSnackBar(
            context, CustomSnackBar.success(message: mServiceAdded));
      } else if (state is ServicesError) {
        showTopSnackBar(
          context,
          CustomSnackBar.error(
            message: mError,
          ),
        );
      }
    }, builder: (context, state) {
      return Padding(
          padding: EdgeInsets.all(defualtPaddingMedium),
          child: Form(
              key: _formKey,
              child: Column(children: <Widget>[
                Container(
                    child: TextFormField(
                  focusNode: myFocusNode,
                  initialValue: '',
                  cursorColor: textColorBlack,
                  //style: Theme.of(context).textTheme.headline5,
                  decoration: InputDecoration(
                      hoverColor: primaryColor,
                      hintText: 'ชื่อบริการ',
                      labelText: 'ชื่อบริการ',
                      labelStyle: TextStyle(
                          color: myFocusNode.hasFocus
                              ? textColorBlack
                              : Colors.black)),
                  validator: (val) {
                    if (val == null || val.trim().isEmpty) {
                      return 'โปรระบุชื่อบริการ';
                    }
                  },
                  onChanged: (value) => {_service.name = value},
                )),
                SizedBox(
                  height: 20,
                ),
                Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'เลือกประเภทของบริการ',
                      style: TextStyle(fontSize: fontSizeMedium),
                    )),
                SizedBox(
                  height: 10,
                ),
                Container(
                  height: 270,
                  child: ListView.builder(
                      itemCount: mockupServiceType.length,
                      itemBuilder: (context, index) {
                        return ListTile(
                          title:
                              _makeCardWidget(mockupServiceType[index], index),
                          trailing: Radio(
                              activeColor: primaryColor,
                              value: index,
                              groupValue: val,
                              onChanged: (int? value) {
                                setState(() {
                                  val = value!;
                                  _serviceType = mockupServiceType[index];
                                  logger.d(_serviceType.name);
                                });
                              }),
                        );
                      }),
                ),
                SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.all(defualtPaddingLow),
                  child: TextFormField(
                    cursorColor: primaryColor,
                    scrollPadding: EdgeInsets.only(top: 10),
                    maxLines: 3,
                    style: const TextStyle(
                        color: textColorBlack, fontSize: fontSizeLow),
                    decoration: InputDecoration(
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: primaryColor,
                            width: 2,
                          ),
                        ),
                        labelText: 'รายละเอียดเพื่มเติม',
                        alignLabelWithHint: true,
                        fillColor: Colors.red,
                        contentPadding: EdgeInsets.all(defualtPaddingLow),
                        labelStyle: TextStyle(
                            fontSize: fontSizeLow, color: textColorBlack),
                        border: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: hexToColor('#C4C4C4'), width: 0),
                        )),
                    onChanged: (val) {
                      _service.description = val;
                    },
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter some text';
                      }
                    },
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Container(
                      height: buttonHeightSmall,
                      width: buttonWidthSmall,
                      decoration: BoxDecoration(
                          borderRadius: borderRadiusMedium,
                          color: primaryColor),
                      child: TextButton(
                        child: Text(
                          tAddService,
                          style: TextStyle(color: textColorBlack),
                        ),
                        onPressed: () {
                          _navigateAndDisplayDelete(context);
                        },
                      ),
                    ),
                    GFButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      text: tCancleThai,
                      textColor: textColorBlack,
                      shape: GFButtonShape.pills,
                      color: bgColor,
                    ),
                  ],
                ),
              ])));
    }));
  }

  _makeCardWidget(ServiceType serviceT, int index) {
    return GestureDetector(
      child: Card(
        elevation: 3,
        margin: new EdgeInsets.symmetric(vertical: 4.0),
        color: cardColor,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 16.0),
              child: SizedBox(
                height: 30,
                width: 30,
                child: Image.asset(
                  tImageAsset(serviceType[index].toString()),
                  width: 10,
                ),
              ),
            ),
            Flexible(
                child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 10.0, vertical: 8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    serviceT.name,
                    style: new TextStyle(
                        fontSize: fontSizeLow,
                        fontWeight: FontWeight.w600,
                        color: textColorBlack),
                  ),
                  Container(
                    margin: new EdgeInsets.only(top: 0),
                    child: Text(
                      serviceT.description.toString(),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                      softWrap: false,
                      style: TextStyle(
                          fontSize: 14.0,
                          fontWeight: FontWeight.normal,
                          color: textColorBlack),
                    ),
                  )
                ],
              ),
            )),
          ],
        ),
      ),
      onTap: () {
        //Navigator.pushNamed(context, EDIT_SERVICE_ROUTE);
        // navigateToServiceEdit(service);
      },
    );
  }

  void navigateToServiceList() {
    Navigator.pop(context);
  }

  @override
  void dispose() {
    // Clean up the controller when the widget is removed from the widget tree.
    // This also removes the _printLatestValue listener.
    _controller.dispose();
    super.dispose();
  }

  void _navigateAndDisplayDelete(BuildContext context) async {
    final result = await showDialog<String>(
        context: context,
        builder: (BuildContext context) =>
            AlertPopupYesNo(title: 'คุณต้องการลบบริการนี้ใช้ไหม'));
    if (result == 'Ok') {
      logger.d("${_service.name}");
      _serviceBloc.add(ServiceAdd(_service));
      navigatorToDelete();
    }
  }

  void _navigateAndDisplayEdit(BuildContext context, int index) async {
    final result = await showDialog<String>(
        context: context,
        builder: (BuildContext context) =>
            AlertPopupYesNo(title: 'คุณต้องกาแก้ไขบริการนี้ใช้ไหม'));
    if (result == 'Ok') {
      // Navigator.pushNamed(context, EDITCAR_CARTYPE_ROUTE,
      //     arguments: EditCarNoNewCar(
      //         carOld: widget.user.cars[index], index: index + 1));
    }
  }

  void navigatorToDelete() {
    //   Navigator.push(
    //       context,
    //       MaterialPageRoute(
    //           builder: (BuildContext context) => ProfilePage(user: widget.user)));
  }
}
