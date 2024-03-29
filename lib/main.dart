import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:project_uas/service/auth.dart';
import 'package:project_uas/splashscreen/splashScreen.dart';
import 'package:provider/provider.dart';
import 'package:project_uas/models/user.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamProvider<Users>.value(
      value: AuthService().user,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: SplashScreen(),
      ),
    );
  }
}
