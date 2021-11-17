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
import 'package:rodsiagarage/garage_manage_feature/bloc/service_type_bloc.dart';
import 'package:rodsiagarage/global_widgets/alertPopupYesNo.dart';
import 'package:rodsiagarage/global_widgets/hexTocolor.dart';
import 'package:rodsiagarage/main.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:direct_select/direct_select.dart';

import 'package:top_snackbar_flutter/top_snack_bar.dart';

@immutable
class EditServiceScreen extends StatefulWidget {
  Service service;
  EditServiceScreen({Key? key, required this.service}) : super(key: key);

  @override
  _EditServiceScreenState createState() => _EditServiceScreenState();
}

class _EditServiceScreenState extends State<EditServiceScreen> {
  FocusNode myFocusNode = new FocusNode();
  FocusNode myFocusNode1 = new FocusNode();

  int val = -1;

  late ServiceBloc _serviceBloc;
  late ServiceTypeBloc _serviceTypeBloc;

  final _nameController = TextEditingController();
  final _descController = TextEditingController();
  static final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    _serviceBloc = BlocProvider.of<ServiceBloc>(context);
    _serviceTypeBloc = BlocProvider.of<ServiceTypeBloc>(context)
      ..add(ServiceTypeLoad());
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
          tEditService,
          style: TextStyle(color: textColorBlack, fontSize: fontSizeXl),
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
              child: SingleChildScrollView(
                child: Column(children: <Widget>[
                  TextFormField(
                    controller: _nameController,
                    focusNode: myFocusNode,
                    cursorColor: textColorBlack,
                    //style: Theme.of(context).textTheme.headline5,
                    decoration: InputDecoration(
                        hoverColor: primaryColor,
                        hintText: widget.service.name,
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
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'เลือกประเภทของบริการ',
                        style: TextStyle(fontSize: fontSizeM),
                      )),
                  SizedBox(
                    height: 10,
                  ),
                  BlocConsumer<ServiceTypeBloc, ServiceTypeState>(
                      listener: (context, state) {
                    return;
                  }, builder: (context, state) {
                    if (state is ServiceTypesLoadSuccess) {
                      for (var i = 0; i < state.serviceTypes.length; i++) {
                        if (state.serviceTypes[i].name ==
                            widget.service.serviceType.name) {
                          val = i;
                        }
                      }
                      return ListView.builder(
                          shrinkWrap: true,
                          scrollDirection: Axis.vertical,
                          itemCount: mockupServiceType.length,
                          itemBuilder: (context, index) {
                            return Card(
                              elevation: 3,
                              // margin: new EdgeInsets.symmetric(vertical: 4.0),
                              color: cardColor,
                              child: ListTile(
                                title: _makeCardWidget(
                                    state.serviceTypes[index], index),
                                trailing: Radio(
                                    activeColor: primaryColor,
                                    value: index,
                                    groupValue: val,
                                    onChanged: (int? value) {
                                      setState(() {
                                        val = value!;
                                        widget.service.serviceType =
                                            state.serviceTypes[val];
                                        logger
                                            .d(widget.service.serviceType.name);
                                      });
                                    }),
                              ),
                            );
                          });
                    }
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }),
                  SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    cursorColor: primaryColor,
                    controller: _descController,
                    scrollPadding: EdgeInsets.only(top: 10),
                    maxLines: 3,
                    style: const TextStyle(
                        color: textColorBlack, fontSize: fontSizeS),
                    decoration: InputDecoration(
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: primaryColor,
                            width: 2,
                          ),
                        ),
                        labelText: 'รายละเอียดเพื่มเติม',
                        hintText: widget.service.description,
                        alignLabelWithHint: true,
                        fillColor: Colors.red,
                        contentPadding: EdgeInsets.all(defualtPaddingLow),
                        labelStyle: TextStyle(
                            fontSize: fontSizeS, color: textColorBlack),
                        border: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: hexToColor('#C4C4C4'), width: 0),
                        )),
                    // onChanged: (val) {
                    //   _service.description = val;
                    // },
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'โปรระบุรายละเอียด';
                      }
                    },
                  ),
                  SizedBox(
                    height: 10,
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
                            tEditService,
                            style: TextStyle(color: textColorBlack),
                          ),
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              widget.service.name = _nameController.text;
                              widget.service.description = _descController.text;
                              _navigateAndDisplayEdit(context);
                            }
                          },
                        ),
                      ),
                      GFButton(
                        onPressed: () {
                          navigationToBack();
                        },
                        text: tCancleThai,
                        textColor: textColorBlack,
                        shape: GFButtonShape.pills,
                        color: bgColor,
                      ),
                    ],
                  ),
                ]),
              )));
    }));
  }

  _makeCardWidget(ServiceType serviceT, int index) {
    return GestureDetector(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 8.0, right: 10),
            child: Image.asset(
              tImageAsset(serviceType[index].toString()),
              width: 40,
            ),
          ),
          Flexible(
              child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  serviceT.name,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                  softWrap: false,
                  style: new TextStyle(
                      fontSize: fontSizeM,
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
      onTap: () {
        //Navigator.pushNamed(context, EDIT_SERVICE_ROUTE);
        // navigateToServiceEdit(service);
      },
    );
  }

  void navigateToServiceList() {
    Navigator.pop(context);
  }

  void _navigateAndDisplayEdit(BuildContext context) async {
    final result = await showDialog<String>(
        context: context,
        builder: (BuildContext context) =>
            AlertPopupYesNo(title: 'คุณต้องการแก้ไขบริการนี้ใช้ไหม'));
    if (result == 'Ok') {
      _serviceBloc.add(ServiceUpdate(widget.service));
      logger.d('${widget.service}');
      navigatorToListSerivce();
    }
  }

  void navigationToBack() {
    Navigator.pop(context);
  }

  void navigatorToListSerivce() {
    Navigator.pushNamed(context, SERVICE_LIST_ROUTE);
  }

  @override
  void dispose() {
    // Clean up the controller when the widget is removed from the widget tree.
    // This also removes the _printLatestValue listener.
    _descController.dispose();
    _nameController.dispose();
    super.dispose();
  }
}
