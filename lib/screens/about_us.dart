import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:parichaya_frontend/screens/bottom_navigation_base.dart';
import 'package:provider/provider.dart';

import '../providers/theme_provider.dart';
import '../utils/name_provider.dart';

class AboutUs extends StatefulWidget {
  const AboutUs({Key? key}) : super(key: key);

  @override
  _AboutUsState createState() => _AboutUsState();
}

class _AboutUsState extends State<AboutUs> {
  bool isSwitched = false;
  @override
  Widget build(BuildContext context) {
    isSwitched =
        Provider.of<ThemeProvider>(context, listen: false).isDarkModeOn;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: !isSwitched ? Theme.of(context).primaryColor : Colors.white,
          ),
          onPressed: () {
            //passing this to our root
            Navigator.of(context)
                .popAndPushNamed(BottomNavigationBase.routeName);
          },
        ),
      ),
      body: Center(
        child: Container(
          margin: EdgeInsets.all(10),
          child: const Card(
            elevation: 5,
            child: Padding(
              padding: EdgeInsets.all(15),
              child: SingleChildScrollView(
                child: Text(
                  'We are just a group of tech enthusiast trying to solve the daily life problems through technology. Our first app "Parichaya" aims to solve the problem of carrying the documents everywhere we go just to identify us. ',
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 15,
                  ),
                  textAlign: TextAlign.justify,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
