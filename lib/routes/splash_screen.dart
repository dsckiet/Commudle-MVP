import 'package:commudle/routes/auth_screen.dart';
import 'package:commudle/routes/intro_screen.dart';
import 'package:flutter/material.dart';
import 'dart:async';

import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => new _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  double _opacity = 1.0;

  startTime() async {
    var _duration = new Duration(milliseconds: 2500);
    return new Timer(_duration, checkFirstSeen);
  }

  void navigationPage() {
    Navigator.of(context).pushReplacementNamed('/AuthScreen');
  }

  Future checkFirstSeen() async {
    SharedPreferences prefsintro = await SharedPreferences.getInstance();
    bool _seen = (prefsintro.getBool('seen') ?? false);

    if (_seen) {
      Navigator.of(context).pushReplacement(
          new MaterialPageRoute(builder: (context) => AuthScreen()));
    } else {
      prefsintro.setBool('seen', true);
      Navigator.of(context).pushReplacement(
          new MaterialPageRoute(builder: (context) => IntroScreen()));
    }
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => animation());
  }

  animation() {
    setState(() => this._opacity = 1.0 - this._opacity);
    startTime();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.all(120),
            child: Image(
              image: AssetImage('assets/images/commudle-logo.png'),
            ),
          ),
          Container(
            child: GestureDetector(
              child: AnimatedOpacity(
                duration: Duration(milliseconds: 2300),
                opacity: this._opacity,
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        const Color(0xFF4F73FF),
                        const Color(0xFF28A6FF)
                      ],
                    ),
                  ),
                ),
              ),
              // onTap: () {
              //   setState(() => this._opacity = 1.0 - this._opacity);
              //   startTime();
              // },
            ),
          ),
        ],
      ),
    );
  }
}
