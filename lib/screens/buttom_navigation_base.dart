import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../utils/string.dart';

import '../widgets/custom_icons_icons.dart';
import 'add_document.dart';

// import './homepage.dart';
import './document_list.dart';
// import './extras.dart';
import './received_list.dart';
import './shared_list.dart';

class ButtomNavigationBase extends StatefulWidget {
  const ButtomNavigationBase({Key? key}) : super(key: key);

  @override
  State<ButtomNavigationBase> createState() => _ButtomNavigationBaseState();
}

class _ButtomNavigationBaseState extends State<ButtomNavigationBase> {
  int _screenIndex = 0;

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
      'screen': DocumentList(),
      'title': 'My Identity Docs',
    },
    {
      'screen': const SharedList(),
      'title': 'Shared Docs',
    },
    {
      'screen': const ReceivedList(),
      'title': 'Received Docs',
    },
    // {
    //   'screen': const Extras(),
    //   'title': 'Extra',
    // },
  ];

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
            const DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
              child: Text('Asim Nepal'),
            ),
            ListTile(
              title: const Text('Menu 1'),
              onTap: () {},
            ),
            ListTile(
              title: const Text('Menu 2'),
              onTap: () {
                // Update the state of the app.
                // ...
              },
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
              onPressed: () {},
              icon: const Icon(
                Icons.add_link_rounded,
                size: 30,
              ),
            ),
          IconButton(
            splashRadius: 24,
            onPressed: () {},
            icon: const Icon(
              Icons.search,
              size: 30,
            ),
          ),
        ],
      ),
      body: _screens[_screenIndex]['screen'] as Widget,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).pushNamed(AddDocuments.routeName);
        },
        tooltip: 'Add New Doc',
        elevation: 2,
        child: const Icon(Icons.add_a_photo),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      bottomNavigationBar: BottomNavigationBar(
        // type: BottomNavigationBarType.fixed,

        // unselectedFontSize: 14,
        selectedFontSize: 12,
        // showUnselectedLabels: true,
        elevation: 5,
        iconSize: 20,
        unselectedItemColor: Theme.of(context).unselectedWidgetColor,
        selectedItemColor: Theme.of(context).primaryColor,
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
            icon: Icon(CustomIcons.files_folder_filled),
            label: "My Docs",
          ),
          BottomNavigationBarItem(
            icon: Icon(CustomIcons.link_filled),
            label: "Shared",
          ),
          BottomNavigationBarItem(
            icon: Icon(CustomIcons.inbox),
            label: "Received",
          ),
          // BottomNavigationBarItem(
          //   icon: Icon(CustomIcons.menu_circle_filled),
          //   label: "Extras",
          // ),
        ],
      ),
    );
  }
}
