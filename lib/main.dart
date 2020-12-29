import 'package:flutter/material.dart';
import 'package:project_uas/service/auth.dart';
import 'package:provider/provider.dart';
import 'package:project_uas/models/user.dart';
import 'home/wrapper.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamProvider<User>.value(
      value: AuthService().user,
      child: MaterialApp(
        home: Wrapper(),
      ),
    );
  }
}
