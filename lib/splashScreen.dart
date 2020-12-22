import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'login.dart';

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
          return FormLogin();
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
                'Data',
                style: GoogleFonts.poppins(
                  textStyle: TextStyle(
                      letterSpacing: .4,
                      fontSize: 28.0,
                      color: Colors.deepOrangeAccent,
                      fontWeight: FontWeight.w600),
                ),
              ),
              Text(
                ' Ku',
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
          //Seharusnya ada dibawah
          // Stack(
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Align(
                alignment: Alignment.bottomCenter,
                child: Padding(
                  padding: const EdgeInsets.all(0),
                  child: Text(
                    "Copy Right",
                    style: GoogleFonts.poppins(
                      textStyle: TextStyle(
                          fontSize: 14.0,
                          color: Colors.green,
                          fontWeight: FontWeight.w600),
                    ),
                  ),
                ),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Padding(
                  padding: const EdgeInsets.all(0),
                  child: Text(
                    " Trisnayudha Bachtiar 2020",
                  ),
                ),
              ),
            ],
          ),
          // ),
        ],
      ),
    );
  }
}
// body: Padding(
//         padding: const EdgeInsets.all(16),
//         child: Stack(
//           children: <Widget>[
//             Align(
//               alignment: Alignment.bottomCenter,
//               child: Text(
//                 "Bottom Center",
//               ),
//             ),
//           ],
//         ),
//       ),
