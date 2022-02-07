import 'package:flutter/material.dart';

import './screens/buttomNavigationBase.dart';
import './screens/add_documents_screen.dart';
import 'screens/view_document_screen.dart';

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
      routes: {
        '/': (ctx) => const ButtomNavigationBase(),
        AddDocuments.routeName: (ctx) => const AddDocuments(),
        ViewDocuments.routeName: (ctx) => const ViewDocuments(),
      },
      onUnknownRoute: (settings) {
        return MaterialPageRoute(
          builder: (ctx) => const ButtomNavigationBase(),
        );
      },
    );
  }
}
