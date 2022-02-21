import 'package:flutter/material.dart';
import 'package:parichaya_frontend/utils/is_first_run.dart';

import 'onboarding_screen.dart';
import 'package:provider/provider.dart';
import '../providers/theme_provider.dart';
import 'buttom_navigation_base.dart';

class Splash extends StatefulWidget {
  const Splash({Key? key}) : super(key: key);

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  bool currentTheme = false;
  bool is_first_run = false;

  checkFirstRun() async {
    IsFirstRun.instance
        .getBooleanValue("isfirstRun")
        .then((value) => setState(() {
              is_first_run = value;
            }));
  }

  @override
  void initState() {
    super.initState();
    _navigatetohome();
    checkFirstRun();
  }

  _navigatetohome() async {
    await Future.delayed(const Duration(milliseconds: 1200), () {});

    !is_first_run
        ? Navigator.of(context).pushNamed(OnboardingScreen.routeName)
        : Navigator.of(context).pushNamed(ButtomNavigationBase.routeName);
  }

  Widget build(BuildContext context) {
    currentTheme =
        Provider.of<ThemeProvider>(context, listen: false).isDarkModeOn;
    return Scaffold(
        body: Center(
      child: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'PARICHAYA',
              style: TextStyle(
                fontSize: 40,
                fontWeight: FontWeight.bold,
                color: currentTheme
                    ? Colors.white
                    : Theme.of(context).primaryColor,
              ),
            ),
            const Text(
              'AN IDENTITY STORAGE AND SHARING APP',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w400,
              ),
            ),
          ],
        ),
      ),
    ));
  }
}
