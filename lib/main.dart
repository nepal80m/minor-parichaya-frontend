import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import './providers/documents.dart';
import 'providers/share_links.dart';
import './providers/theme_provider.dart';

import 'screens/buttom_navigation_base.dart';
import 'screens/add_document.dart';
import 'screens/document_details.dart';
import 'screens/edit_document.dart';
import 'screens/full_screen_image.dart';
import 'screens/select_document.dart';
import 'screens/set_expiry.dart';
import 'screens/share_details.dart';

void main() {
  runApp(ChangeNotifierProvider<ThemeProvider>(
    create: (_) => ThemeProvider(),
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => Documents()),
        ChangeNotifierProvider(create: (_) => ShareLinks())
      ],
      child: Consumer<ThemeProvider>(
        builder: (context, provider, child) {
          return MaterialApp(
            title: 'Parichaya',

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
              FullScreenImage.routeName: (ctx) => const FullScreenImage(),
              SelectDocument.routeName: (ctx) => const SelectDocument(),
              SetExpiry.routeName: (ctx) => const SetExpiry(),
              ShareDetails.routeName: (ctx) => const ShareDetails(),
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
