import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AboutUs extends StatefulWidget {
  const AboutUs({Key? key}) : super(key: key);

  @override
  _AboutUsState createState() => _AboutUsState();
}

class _AboutUsState extends State<AboutUs> {
  bool isSwitched = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Theme.of(context).brightness == Brightness.light
                ? Theme.of(context).primaryColor
                : Colors.white,
          ),
          onPressed: () {
            //passing this to our root
            Navigator.of(context)
              ..pop()
              ..pop();
          },
        ),
      ),
      body: Container(
        margin: const EdgeInsets.all(10),
        child: Card(
          // elevation: 5,
          child: Padding(
            padding: const EdgeInsets.all(15),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Text('Our Parichaya',
                      style: Theme.of(context).textTheme.headline5),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    'We are just a group of tech enthusiast trying to solve the daily life problems through technology. Our first app "Parichaya" aims to solve the problem of carrying the documents everywhere we go just to identify us. ',
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 15,
                    ),
                    textAlign: TextAlign.justify,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
