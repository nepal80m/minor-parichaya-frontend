import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:parichaya_frontend/screens/about_us.dart';
import 'package:parichaya_frontend/screens/update_name.dart';
import 'package:parichaya_frontend/utils/name_provider.dart';
import 'package:parichaya_frontend/providers/theme_provider.dart';
import 'package:provider/provider.dart';
import '../utils/string.dart';

import '../widgets/custom_icons_icons.dart';
import './add_document.dart';
import 'search_documents.dart';

// import './homepage.dart';
import './document_list.dart';
import './shared_list.dart';
import 'select_document.dart';

class BottomNavigationBase extends StatefulWidget {
  //const BottomNavigationBase({Key? key}) : super(key: key);

  BottomNavigationBase();
  static const routeName = '/bottom_navigation_base';

  @override
  State<BottomNavigationBase> createState() => _BottomNavigationBaseState();
}

class _BottomNavigationBaseState extends State<BottomNavigationBase> {
  int _screenIndex = 0;
  // Future<String> name = NameProvider.getStringValue(nameKey);
  String name = 'key_name';
  //final number = " 988434633";
  bool isSwitched = false;

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

  Widget _getFAB() {
    if (_screenIndex == 0) {
      return FloatingActionButton(
          onPressed: () {
            Navigator.of(context).pushNamed(AddDocuments.routeName);
          },
          tooltip: 'Add New Doc',
          elevation: 2,
          child: const Icon(Icons.add_rounded));
    } else {
      return FloatingActionButton(
        onPressed: () {
          Navigator.of(context).pushNamed(SelectDocument.routeName);
        },
        tooltip: 'Add Shared Doc',
        elevation: 2,
        child: const Icon(Icons.add_link_rounded),
      );
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadName();
  }

  loadName() async {
    NameProvider.instance
        .getStringValue("nameKey")
        .then((value) => setState(() {
              name = value;
            }));
  }

  @override
  Widget build(BuildContext context) {
    isSwitched =
        Provider.of<ThemeProvider>(context, listen: false).isDarkModeOn;

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
                    CircleAvatar(
                      backgroundColor: Colors.white,
                      // radius: 50,
                      child: name.isNotEmpty
                          ? Text(
                              name[0].toUpperCase(),
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Theme.of(context).primaryColor,
                                  fontSize: 20),
                            )
                          : Icon(Icons.person_rounded),
                    ),
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
                    value: provider.isDarkModeOn,
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
//Change Name
            ListTile(
              title: Row(
                children: [
                  Icon(Icons.cast_for_education_sharp),
                  Padding(
                    padding: EdgeInsets.all(10),
                    child: Text(
                      'Update Name',
                      style: TextStyle(
                        fontSize: 16,
                      ),
                    ),
                  ),
                ],
              ),
              onTap: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => UpdateName(),
                  ),
                );
              },
              trailing: const Icon(Icons.arrow_forward_ios),
            ),
            const Divider(),

            //About us
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
              onTap: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => AboutUs(),
                  ),
                );
              },
              trailing: const Icon(Icons.arrow_forward_ios),
            ),
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
          if (_screenIndex == 1)
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
