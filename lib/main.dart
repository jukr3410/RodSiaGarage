import 'package:flutter/material.dart';
import 'package:rodsiagarage/router.dart';

void main() {
  runApp(RodSiaGarageApp(router: AppRouter()));
}

class RodSiaGarageApp extends StatelessWidget {
  final AppRouter router;

  const RodSiaGarageApp({Key? key, required this.router}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      onGenerateRoute: router.generateRoute,
    );
  }
}
