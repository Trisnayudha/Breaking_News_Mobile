import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../home/wrapper.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    startSplashScreen();
  }

  startSplashScreen() async {
    var duration = const Duration(seconds: 5);
    return Timer(duration, () {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (_) {
          return Wrapper();
        }),
      );
    });
  }

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(
            child: Center(
              child: Image.asset(
                "img/logo.jpg",
                width: 200.0,
                height: 150.0,
              ),
            ),
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Breaking',
                style: GoogleFonts.poppins(
                  textStyle: TextStyle(
                      letterSpacing: .4,
                      fontSize: 28.0,
                      color: Colors.deepOrangeAccent,
                      fontWeight: FontWeight.w600),
                ),
              ),
              Text(
                'News',
                style: GoogleFonts.poppins(
                  textStyle: TextStyle(
                      letterSpacing: .4,
                      fontSize: 28.0,
                      color: Colors.lightBlueAccent,
                      fontWeight: FontWeight.w600),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
