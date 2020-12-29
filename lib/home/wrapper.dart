import 'package:flutter/material.dart';
import 'package:project_uas/authenticate/authenticate.dart';
import 'package:provider/provider.dart';
import 'package:project_uas/models/user.dart';

import 'home.dart';


class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);
   
    //return either home or authenticate widget
    if (user == null){
      return Authenticate();
    }else{
      return Home();
    }
  }
}
