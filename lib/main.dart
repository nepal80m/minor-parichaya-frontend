import 'package:flutter/material.dart';
import 'package:parichaya_frontend/providers/documents.dart';
import 'package:provider/provider.dart';
import 'screens/buttom_navigation_base.dart';
import 'screens/add_document.dart';
import 'screens/document_details.dart';
import 'screens/edit_document.dart';
import 'screens/full_screen_image.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => Documents(),
      child: MaterialApp(
        title: 'Parichaya',
        // TODO: Customize theme
        theme: ThemeData(
          primarySwatch: Colors.blue,
          fontFamily: 'OpenSans',
          // fontFamily: 'Quicksand',
          // splashFactory: InkRipple.splashFactory,
        ),
        debugShowCheckedModeBanner: false,
        darkTheme: ThemeData.dark(),
        themeMode: ThemeMode.dark,
        routes: {
          '/': (ctx) => const ButtomNavigationBase(),
          AddDocuments.routeName: (ctx) => const AddDocuments(),
          DocumentDetails.routeName: (ctx) => const DocumentDetails(),
          EditDocument.routeName: (ctx) => const EditDocument(),
          FullScreenImage.routeName: (ctx) => const FullScreenImage(),
        },
        onUnknownRoute: (settings) {
          return MaterialPageRoute(
            builder: (ctx) => const ButtomNavigationBase(),
          );
        },
      ),
    );
  }
}
