import 'dart:async';

import 'package:customerservice/screens/getstarted.dart';
import 'package:customerservice/screens/home_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  @override
  SplashScreenState createState() => new SplashScreenState();
}

class SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  var _visible = true;
  bool isSigned = false;
  AnimationController animationController;
  Animation<double> animation;

  startTime() async {
    var _duration = new Duration(seconds: 3);
    return new Timer(_duration, navigationPage);
  }

  void navigationPage() {
    isSigned
        ? Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (BuildContext context) => HomeScreen(),
            ),
          )
        : Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (BuildContext context) => Getstarted(),
            ),
          );
  }

  @override
  void initState() {
    super.initState();
    animationController = new AnimationController(
        vsync: this, duration: new Duration(seconds: 3));
    animation =
        new CurvedAnimation(parent: animationController, curve: Curves.easeOut);
    animation.addListener(() => this.setState(() {}));
    animationController.forward();
    setState(() {
      _visible = !_visible;
    });
    startTime();

    FirebaseAuth.instance.authStateChanges().listen((useraccount) {
      if (useraccount != null) {
        if (this.mounted) {
          setState(() {
            isSigned = true;
          });
        }
      } else {
        if (this.mounted) {
          setState(() {
            isSigned = false;
          });
        }
      }
    });
  }

  @override
  void dispose() {
    animationController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF000a32),
      body: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          new Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              new Image.asset(
                'assets/images/logo.png',
                width: animation.value * 600,
                height: animation.value * 600,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
