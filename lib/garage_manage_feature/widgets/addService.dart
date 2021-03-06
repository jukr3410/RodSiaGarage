import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:getwidget/getwidget.dart';
import 'package:intl/intl.dart';
import 'package:rodsiagarage/constants.dart';
import 'package:rodsiagarage/core/models/garage_model.dart';
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

class AddServiceScreen extends StatefulWidget {
  final Garage garage;
  AddServiceScreen({Key? key, required this.garage}) : super(key: key);

  @override
  _AddServiceScreenState createState() => _AddServiceScreenState();
}

class _AddServiceScreenState extends State<AddServiceScreen> {
  //final _formKey = GlobalKey<FormBuilderState>();
  FocusNode myFocusNode = new FocusNode();
  FocusNode myFocusNode1 = new FocusNode();

  Service _service = Service(
      id: "",
      name: "",
      description: "",
      serviceType: mockupServiceType[1],
      garage: gargeMockup);

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
          tAddService,
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
        navigatorToListSerivce(widget.garage);
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
                        hintText: '??????????????????????????????',
                        labelText: '??????????????????????????????',
                        labelStyle: TextStyle(
                            color: myFocusNode.hasFocus
                                ? textColorBlack
                                : Colors.black)),
                    validator: (val) {
                      if (val == null || val.trim().isEmpty) {
                        return '???????????????????????????????????????????????????';
                      }
                    },
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        '????????????????????????????????????????????????????????????',
                        style: TextStyle(fontSize: fontSizeM),
                      )),
                  SizedBox(
                    height: 10,
                  ),
                  BlocConsumer<ServiceTypeBloc, ServiceTypeState>(
                      listener: (context, state) {},
                      builder: (context, state) {
                        if (state is ServiceTypesLoadSuccess) {
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
                                            _service.serviceType =
                                                state.serviceTypes[val];
                                            logger.d(_service.serviceType.name);
                                          });
                                        }),
                                  ),
                                );
                              });
                        }
                        return Center(
                          child: CircularProgressIndicator(
                            valueColor:
                                AlwaysStoppedAnimation<Color>(primaryColor),
                          ),
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
                        labelText: '?????????????????????????????????????????????????????????',
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
                        return '???????????????????????????????????????????????????';
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
                            tAddService,
                            style: TextStyle(color: textColorBlack),
                          ),
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              _service.name = _nameController.text;
                              _service.description = _descController.text;
                              _service.garage = gargeMockup;
                              _navigateAndDisplayAddSerivce(context);
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
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
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
                Text(
                  serviceT.description.toString(),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                  softWrap: false,
                  style: TextStyle(
                      fontSize: 14.0,
                      fontWeight: FontWeight.normal,
                      color: textColorBlack),
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

  @override
  void dispose() {
    // Clean up the controller when the widget is removed from the widget tree.
    // This also removes the _printLatestValue listener.
    _descController.dispose();
    _nameController.dispose();
    super.dispose();
  }

  void _navigateAndDisplayAddSerivce(BuildContext context) async {
    final result = await showDialog<String>(
        context: context,
        builder: (BuildContext context) =>
            AlertPopupYesNo(title: '??????????????????????????????????????????????????????????????????????????????????????????'));
    if (result == 'Ok') {
      logger.d("${_service.name}");
      _service.garage = widget.garage;
      _serviceBloc.add(ServiceAdd(_service));
    }
  }

  void navigationToBack() {
    Navigator.pop(context);
  }

  void navigatorToListSerivce(Garage garage) {
    Navigator.pushNamed(context, SERVICE_LIST_ROUTE, arguments: garage);
  }
}
