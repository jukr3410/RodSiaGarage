import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:intl/intl.dart';
import 'package:rodsiagarage/constants.dart';
import 'package:rodsiagarage/core/models/service_model.dart';
import 'package:rodsiagarage/garage_manage_feature/bloc/service_bloc.dart';

class AddServiceScreen extends StatefulWidget {
  final bool isEditing;
  final Service? service;

  AddServiceScreen({
    Key? key,
    required this.isEditing,
    this.service,
  }) : super(key: key);

  @override
  _AddServiceScreenState createState() => _AddServiceScreenState();
}

class _AddServiceScreenState extends State<AddServiceScreen> {
  final _formKey = GlobalKey<FormBuilderState>();
  FocusNode myFocusNode = new FocusNode();

  Service? _service;

  bool get isEditing => widget.isEditing;

  @override
  Widget build(BuildContext context) {
    final _controller = TextEditingController();
    return Scaffold(appBar: setAppBar(), body: setBody());
  }

  setAppBar() {
    return AppBar(
      backgroundColor: primaryColor,
      centerTitle: true,
      title: Text(
        isEditing ? tEditService : tAddService,
        style: TextStyle(color: textColorBlack, fontSize: fontSizeSemiLarge),
      ),
      leading: IconButton(
        icon: Icon(
          Icons.arrow_back,
          color: iconColorBlack,
        ),
        onPressed: () {
          Navigator.pop(context);
          // Let's create a new instance of the home page
          // Navigator.pushReplacement(
          //   context,
          //   MAIN_ROUTE
          // );
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
    return Padding(
        padding: EdgeInsets.all(16.0),
        child: Form(
            key: _formKey,
            child: Column(children: <Widget>[
              Container(
                  padding: EdgeInsets.fromLTRB(15, 10, 15, 0),
                  child: TextFormField(
                    focusNode: myFocusNode,
                    initialValue: isEditing ? widget.service?.name : '',
                    autofocus: !isEditing,
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
                        return 'Please enter some text';
                      }
                    },
                    onSaved: (value) => _service!.name = value!,
                  )),
              TextFormField(
                initialValue: isEditing ? widget.service?.description : '',
                maxLines: 10,
                style: Theme.of(context).textTheme.subtitle1,
                decoration: InputDecoration(
                  hintText: 'Additional Notes...',
                ),
                onSaved: (value) => _service!.description = value!,
              )
            ])));
  }

  void navigateToServiceList() {
    Navigator.pushReplacementNamed(context, SERVICE_LIST_ROUTE);
  }
}
