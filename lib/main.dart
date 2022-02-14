import 'package:flutter/material.dart';
import 'package:parichaya_frontend/providers/documents.dart';
import 'package:parichaya_frontend/providers/theme_provider.dart';
import 'package:parichaya_frontend/screens/document_detail_full_screen_gallery.dart';
import 'package:provider/provider.dart';

import 'screens/buttom_navigation_base.dart';
import 'screens/add_document.dart';
import 'screens/document_details.dart';
import 'screens/edit_document.dart';
import 'screens/document_detail_full_screen_gallery.dart';

void main() {
  runApp(ChangeNotifierProvider<ThemeProvider>(
    create: (_) => ThemeProvider(),
    child: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => Documents(),
      child: Consumer<ThemeProvider>(
        builder: (context, provider, child) {
          return MaterialApp(
            title: 'Parichaya',

            // TODO: Customize theme
            //themeMode: ThemeMode.system,
            // theme: ThemeData(
            //   primarySwatch: Colors.blue,
            //   fontFamily: 'OpenSans',
            //   // brightness: Brightness.dark,
            //   // fontFamily: 'Quicksand',
            //   // splashFactory: InkRipple.splashFactory,
            // ),

            theme: ThemeData.light(),
            darkTheme: ThemeData.dark(),
            themeMode: provider.themeMode,

            //lightTheme: MyThemes.lightTheme,

            debugShowCheckedModeBanner: false,
            routes: {
              '/': (ctx) => const ButtomNavigationBase(),
              AddDocuments.routeName: (ctx) => const AddDocuments(),
              DocumentDetails.routeName: (ctx) => const DocumentDetails(),
              EditDocument.routeName: (ctx) => const EditDocument(),
              DocumentDetailFullScreenGallery.routeName: (ctx) =>
                  const DocumentDetailFullScreenGallery(),
            },
            onUnknownRoute: (settings) {
              return MaterialPageRoute(
                builder: (ctx) => const ButtomNavigationBase(),
              );
            },
          );
        },
      ),
    );
  }
}
