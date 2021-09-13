import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:getwidget/getwidget.dart';
import 'package:intl/intl.dart';
import 'package:rodsiagarage/constants.dart';
import 'package:rodsiagarage/core/models/service_model.dart';
import 'package:rodsiagarage/core/models/service_type_model.dart';
import 'package:rodsiagarage/garage_manage_feature/bloc/service_bloc.dart';
import 'package:rodsiagarage/main.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
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
      appBar: setAppBar(),
      body: setBody(),
    );
  }

  setAppBar() {
    return AppBar(
      backgroundColor: primaryColor,
      centerTitle: true,
      title: Text(
        tAddService,
        style: TextStyle(color: textColorBlack, fontSize: fontSizeSemiLarge),
      ),
      leading: IconButton(
        icon: Icon(
          Icons.arrow_back,
          color: iconColorBlack,
        ),
        onPressed: () {
          navigateToServiceList();
        },
      ),
      actions: [
        // IconButton(
        //   icon: Icon(Icons.add, color: iconColorBlack),
        //   onPressed: () {},
        //   iconSize: 30.0,
        // ),
      ],
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
          padding: EdgeInsets.all(16.0),
          child: Form(
              key: _formKey,
              child: Column(children: <Widget>[
                Container(
                    padding: EdgeInsets.fromLTRB(15, 0, 15, 0),
                    child: TextFormField(
                      focusNode: myFocusNode,
                      initialValue: '',
                      cursorColor: textColorBlack,
                      //style: Theme.of(context).textTheme.headline5,
                      decoration: InputDecoration(
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
                Container(
                    padding: EdgeInsets.fromLTRB(15, 0, 15, 0),
                    child: TextFormField(
                      focusNode: myFocusNode1,
                      maxLines: 2,
                      initialValue: '',
                      cursorColor: textColorBlack,
                      //style: Theme.of(context).textTheme.headline5,
                      decoration: InputDecoration(
                          hintText: 'รายละเอียด',
                          labelText: 'รายละเอียด',
                          labelStyle: TextStyle(
                              color: myFocusNode1.hasFocus
                                  ? textColorBlack
                                  : Colors.black)),
                      // validator: (val) {
                      //   if (val == null || val.trim().isEmpty) {
                      //     return 'โปรระบุรายละเอียด';
                      //   }
                      // },
                      onChanged: (value) => {_service.description = value},
                    )),
                Container(
                  width: MediaQuery.of(context).size.width,
                  alignment: Alignment.center,
                  margin: const EdgeInsets.symmetric(
                      horizontal: 40.0, vertical: 8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GFButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        text: tCancleThai,
                        textColor: textColorBlack,
                        shape: GFButtonShape.pills,
                        color: bgColor,
                      ),
                      Text("|"),
                      GFButton(
                          onPressed: () {
                            logger.d("${_service.name}");
                            _serviceBloc.add(ServiceAdd(_service));
                          },
                          text: tAddService,
                          shape: GFButtonShape.pills,
                          color: textColorBlack),
                    ],
                  ),
                ),
              ])));
    }));
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
}
