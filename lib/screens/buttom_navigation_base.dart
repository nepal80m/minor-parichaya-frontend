import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:parichaya_frontend/providers/theme_provider.dart';
import 'package:provider/provider.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'dart:async';
import 'package:fluttertoast/fluttertoast.dart';

import '../utils/string.dart';
import '../widgets/custom_icons_icons.dart';
import './add_document.dart';
import 'search_documents.dart';

// import './homepage.dart';
import './document_list.dart';
import './shared_list.dart';
import 'select_document.dart';

class ButtomNavigationBase extends StatefulWidget {
  const ButtomNavigationBase({Key? key}) : super(key: key);

  @override
  State<ButtomNavigationBase> createState() => _ButtomNavigationBaseState();
}

class _ButtomNavigationBaseState extends State<ButtomNavigationBase> {
  int _screenIndex = 0;
  final name = 'Peter Griffin';
  final number = " 988434633";
  bool isSwitched = false;
  bool isOnline = true;
  late StreamSubscription internetSubscription;

  @override
  void initState() {
    super.initState();

    internetSubscription =
        InternetConnectionChecker().onStatusChange.listen((status) {
      final isOnline = (status == InternetConnectionStatus.connected);

      setState(() {
        this.isOnline = isOnline;
      });
    });
  }

  @override
  void dispose() {
    internetSubscription.cancel();

    super.dispose();
  }

  void _selectScreen(int index) {
    setState(() {
      _screenIndex = index;
    });
  }

  final List<Map<String, Object>> _screens = [
    // {
    //   'screen': HomePage(),
    //   'title': 'My Identity Docs',
    // },
    {
      'screen': const DocumentList(),
      'title': 'My Identity Docs',
    },
    {
      'screen': const SharedList(),
      'title': 'Shared Docs',
    },
    // {
    //   'screen': const ReceivedList(),
    //   'title': 'Received Docs',
    // },
    // {
    //   'screen': const Extras(),
    //   'title': 'Extra',
    // },
  ];

  Widget? _getFAB() {
    if (_screenIndex == 0) {
      return FloatingActionButton(
          onPressed: () {
            Navigator.of(context).pushNamed(AddDocuments.routeName);
          },
          tooltip: 'Add New Doc',
          elevation: 2,
          child: const Icon(
            Icons.add_rounded,
            size: 30,
          ));
    } else if (_screenIndex == 1 && isOnline) {
      return FloatingActionButton(
        onPressed: () {
          Navigator.of(context).pushNamed(SelectDocument.routeName);
        },
        tooltip: 'Add Shared Doc',
        elevation: 2,
        child: const Icon(
          Icons.add_link_rounded,
          size: 30,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        // Add a ListView to the drawer. This ensures the user can scroll
        // through the options in the drawer if there isn't enough vertical
        // space to fit everything.

        child: ListView(
          // Important: Remove any padding from the ListView.
          padding: EdgeInsets.zero,
          children: [
            // TODO: Complete this drawer

            SizedBox(
              height: 130,
              child: DrawerHeader(
                decoration: BoxDecoration(
                  color: !isSwitched
                      ? Theme.of(context).primaryColor
                      : Colors.blue.withGreen(232),
                ),
                child: Row(
                  children: [
                    // Padding(
                    // padding: EdgeInsets.all(10),
                    //  child:
                    CircleAvatar(
                      backgroundColor: Colors.white,
                      // radius: 50,
                      child: Text(
                        name[0].toUpperCase(),
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Theme.of(context).primaryColor,
                            fontSize: 20),
                      ),
                    ),
                    //   ),
                    const SizedBox(width: 20),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          name,
                          style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 16),
                        ),
                        // Text(
                        //   number,
                        //   style: const TextStyle(
                        //       color: Colors.white,
                        //       fontWeight: FontWeight.bold,
                        //       fontSize: 14),
                        // ),
                        // Text('goerranger@gmail.com'),
                      ],
                    ),
                  ],
                ),
              ),
            ),
//Switch for dark mode
            Consumer<ThemeProvider>(
              builder: (context, provider, child) {
                return ListTile(
                  //  value:provider.currentTheme,
                  title: Row(
                    children: [
                      Icon(isSwitched
                          ? Icons.dark_mode_rounded
                          : Icons.light_mode_rounded),
                      const Padding(
                        padding: EdgeInsets.all(10),
                        child: Text(
                          'Dark Mode',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                  trailing: Switch(
                    value: isSwitched,
                    onChanged: (value) {
                      setState(() {
                        isSwitched = value;
                        provider.changeTheme(isSwitched);
                      });
                    },
                    activeTrackColor: Theme.of(context).primaryColorLight,
                    activeColor: Theme.of(context).primaryColor,
                  ),
                  //onTap: () {},
                );
              },
            ),
            const Divider(),
//Change Number
            // ListTile(
            //   title: Row(
            //     children: [
            //       Icon(Icons.phone_android_rounded),
            //       Padding(
            //         padding: EdgeInsets.all(10),
            //         child: Text(
            //           'Change Number',
            //           style: TextStyle(
            //             fontSize: 16,
            //           ),
            //         ),
            //       ),
            //     ],
            //   ),
            //   onTap: () {},
            //   trailing: const Icon(Icons.arrow_forward_ios),
            // ),
//Change Email Address
//             ListTile(
//               title: Row(
//                 children: [
//                   Icon(Icons.mail_rounded),
//                   Padding(
//                     padding: EdgeInsets.all(10),
//                     child: Text(
//                       'Change Email address',
//                       style: TextStyle(
//                         fontSize: 16,
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//               onTap: () {},
//               trailing: const Icon(Icons.arrow_forward_ios),
//             ),

// //Change Password
//             ListTile(
//               title: Row(
//                 children: [
//                   Icon(Icons.vpn_key_rounded),
//                   Padding(
//                     padding: EdgeInsets.all(10),
//                     child: Text(
//                       'Change Password',
//                       style: TextStyle(
//                         fontSize: 16,
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//               onTap: () {},
//               trailing: const Icon(Icons.arrow_forward_ios),
//             ),
//             const Divider(),
//             //Terms of services
//             ListTile(
//               title: Row(
//                 children: [
//                   Icon(Icons.subject_rounded),
//                   Padding(
//                     padding: EdgeInsets.all(10),
//                     child: Text(
//                       'Terms of services',
//                       style: TextStyle(
//                         fontSize: 16,
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//               onTap: () {},
//               trailing: const Icon(Icons.arrow_forward_ios),
//             ),
            //Privacy Policy
            ListTile(
              title: Row(
                children: [
                  Icon(Icons.lock_rounded),
                  Padding(
                    padding: EdgeInsets.all(10),
                    child: Text(
                      'Privacy Policy',
                      style: TextStyle(
                        fontSize: 16,
                      ),
                    ),
                  ),
                ],
              ),
              onTap: () {},
              trailing: const Icon(Icons.arrow_forward_ios),
            ),
            //Terms of services
            ListTile(
              title: Row(
                children: [
                  Icon(Icons.group_rounded),
                  Padding(
                    padding: EdgeInsets.all(10),
                    child: Text(
                      'About Us',
                      style: TextStyle(
                        fontSize: 16,
                      ),
                    ),
                  ),
                ],
              ),
              onTap: () {},
              trailing: const Icon(Icons.arrow_forward_ios),
            ),
            const Divider(),
          ],
        ),
      ),
      appBar: AppBar(
        elevation: 1,
        systemOverlayStyle: SystemUiOverlayStyle(
            statusBarColor: Theme.of(context).primaryColor),

        leading: Builder(
          builder: (BuildContext context) {
            return GestureDetector(
              onTap: () {
                Scaffold.of(context).openDrawer();
              },
              child: const Padding(
                padding: EdgeInsets.all(8.0),
                child: CircleAvatar(
                  child: Icon(Icons.person_rounded),
                ),
              ),
            );
          },
        ),
        title: Text(
          generateLimitedLengthText(
              _screens[_screenIndex]['title'] as String, 25),
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
        ),
        // titleSpacing: 0.0,
        actions: [
          if (_screenIndex == 0)
            IconButton(
              splashRadius: 24,
              onPressed: () {
                Navigator.of(context).pushNamed(AddDocuments.routeName);
              },
              icon: const Icon(
                Icons.add_rounded,
                size: 30,
              ),
            ),
          if (_screenIndex == 1 && isOnline)
            IconButton(
              splashRadius: 24,
              onPressed: () {
                Navigator.of(context).pushNamed(SelectDocument.routeName);
              },
              icon: const Icon(
                Icons.add_link_rounded,
                size: 30,
              ),
            ),
          IconButton(
            splashRadius: 24,
            onPressed: () {
              showSearch(
                context: context,
                delegate: DocumentSearchDelegate(),
              );
            },
            icon: const Icon(
              Icons.search,
              size: 30,
            ),
          ),
        ],
      ),
      body: _screens[_screenIndex]['screen'] as Widget,
      floatingActionButton: _getFAB(),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      bottomNavigationBar: BottomNavigationBar(
        // type: BottomNavigationBarType.fixed,

        // unselectedFontSize: 14,
        selectedFontSize: 12,
        // showUnselectedLabels: true,
        elevation: 5,
        iconSize: 20,
        unselectedItemColor: !isSwitched
            ? Theme.of(context).unselectedWidgetColor
            : Theme.of(context).unselectedWidgetColor.withOpacity(.2),
        selectedItemColor:
            !isSwitched ? Theme.of(context).primaryColor : Colors.white,
        currentIndex: _screenIndex,
        onTap: _selectScreen,
        items: const [
          // BottomNavigationBarItem(
          //   icon: Icon(
          //     Icons.home_rounded,
          //     size: 28,
          //   ),
          //   label: "Home",
          // ),
          BottomNavigationBarItem(
            icon: Icon(
              CustomIcons.files_folder_filled,
              // color: isSwitched?Colors.white,
            ),
            label: "My Docs",
          ),
          BottomNavigationBarItem(
            icon: Icon(CustomIcons.link_filled),
            label: "Shared",
          ),
          // BottomNavigationBarItem(
          //   icon: Icon(CustomIcons.inbox),
          //   label: "Received",
          // ),
          // BottomNavigationBarItem(
          //   icon: Icon(CustomIcons.menu_circle_filled),
          //   label: "Extras",
          // ),
        ],
      ),
    );
  }
}
