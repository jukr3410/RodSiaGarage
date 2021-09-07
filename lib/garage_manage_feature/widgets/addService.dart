import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rodsiagarage/constants.dart';
import 'package:rodsiagarage/garage_manage_feature/bloc/service_bloc.dart';

class AddServiceScreen extends StatefulWidget {
  @override
  _AddServiceScreenState createState() => _AddServiceScreenState();
}

class _AddServiceScreenState extends State<AddServiceScreen> {
  @override
  Widget build(BuildContext context) {
    final _controller = TextEditingController();
    return Scaffold(
      appBar: setAppBar(),
      body: BlocListener<ServiceBloc, ServiceState>(
        listener: (context, state) {
          if (state is ServiceAdded) {
            Navigator.pop(context);
          } else if (state is AddServiceError) {}
        },
        child: Container(
          margin: EdgeInsets.all(20.0),
          child: Center(
            child: Text("Add Service"),
          ),
        ),
      ),
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
}
