import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rodsiagarage/garage_manage_feature/bloc/add_service_bloc.dart';
import 'package:rodsiagarage/garage_manage_feature/bloc/service_bloc.dart';
import 'package:toast/toast.dart';

class AddServiceScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final _controller = TextEditingController();
    return Scaffold(
      appBar: AppBar(
        title: Text('Add'),
      ),
      body: BlocListener<AddServiceBloc, AddServiceState>(
        listener: (context, state) {
          if (state is ServiceAdded) {
            Navigator.pop(context);
          } else if (state is AddServiceError) {
            Toast.show(
              state.error,
              context,
              duration: 3,
              backgroundColor: Colors.red,
              gravity: Toast.CENTER,
            );
          }
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
}
