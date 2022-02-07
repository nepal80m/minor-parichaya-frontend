import 'package:flutter/material.dart';
import './screens/buttomNavigationBase.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Parichaya',
      // TODO: Customize theme
      theme: ThemeData(
        primarySwatch: Colors.blue,
        fontFamily: 'OpenSans',
        // fontFamily: 'Quicksand',
        // splashFactory: InkRipple.splashFactory,
      ),
      debugShowCheckedModeBanner: false,
      home: const ButtomNavigationBase(),
    );
  }
}
