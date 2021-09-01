import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
// import 'package:lite_rolling_switch/lite_rolling_switch.dart';
import 'package:rodsiagarage/constants.dart';
import 'package:rodsiagarage/global_widgets/appbarGarage.dart';
import 'package:rodsiagarage/request_service_feature/widgets/moreInfoRequestPage.dart';
import 'package:rodsiagarage/router.dart';
import 'package:logging/logging.dart';

void main() {
  _setupLogging();
  Bloc.observer = GarageBlocObserver();
  runApp(RodSiaGarageApp(router: AppRouter()));
} 

class RodSiaGarageApp extends StatelessWidget {
  final AppRouter router;

  const RodSiaGarageApp({Key? key, required this.router}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(fontFamily: 'Kanit'),
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        // appBar: AppBar(
        //   centerTitle: true,
        //   backgroundColor: primaryColor,
        //   actions: [
        //     LiteRollingSwitch(
        //       value: true,
        //       textOn: 'active',
        //       textOff: 'inactive',
        //       colorOn: Colors.deepOrange,
        //       colorOff: Colors.blueGrey,
        //       iconOn: Icons.lightbulb_outline,
        //       iconOff: Icons.power_settings_new,
        //       onChanged: (bool state) {
        //         print('turned ${(state) ? 'on' : 'off'}');
        //       },
        //     ),
        //     TextButton(
        //         onPressed: () {},
        //         child: ImageIcon(AssetImage('assets/images/icon-notify.png'))),
        //   ],
        // ),
        body: MoreInfoRequestPage(),
      ),
      // onGenerateRoute: router.generateRoute,
    );
  }
}

class GarageBlocObserver extends BlocObserver {
  @override
  void onEvent(Bloc bloc, Object? event) {
    print(event);
    super.onEvent(bloc, event);
  }

  @override
  void onChange(BlocBase bloc, Change change) {
    print(change);
    super.onChange(bloc, change);
  }

  @override
  void onTransition(Bloc bloc, Transition transition) {
    print(transition);
    super.onTransition(bloc, transition);
  }

  @override
  void onError(BlocBase bloc, Object error, StackTrace stackTrace) {
    print('$error, $stackTrace');
    super.onError(bloc, error, stackTrace);
  }
}

void _setupLogging() {
  Logger.root.level = Level.ALL;
  Logger.root.onRecord.listen((rec) {
    print('${rec.level.name}: ${rec.time}: ${rec.message}');
  });
}
