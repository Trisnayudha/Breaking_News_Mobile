// import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:project_uas/authenticate/sign_in.dart';
import 'package:project_uas/models/user.dart';
import 'package:project_uas/service/auth.dart';
import 'package:project_uas/service/database.dart';
import 'package:project_uas/views/change_password.dart';
import 'package:project_uas/views/edit_profile.dart';
import 'package:provider/provider.dart';

class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  final AuthService _auth = AuthService();
  @override
  Widget build(BuildContext context) {
    Users user = Provider.of<Users>(context);
    return StreamBuilder<UserData>(
        stream: DatabaseService(uid: user.uid).userData,
        builder: (context, snapshot) {
          // inspect(snapshot);
          UserData data = snapshot.data;
          if (snapshot.hasData) {
            // inspect(data.photo);
            return SafeArea(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 20,
                  ),
                  Center(
                    child: ClipRRect(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(25),
                        topRight: Radius.circular(25),
                        bottomLeft: Radius.circular(25),
                        bottomRight: Radius.circular(25),
                      ),
                      child: (data.photo != '')
                          ? Image.network(
                              data.photo,
                              height: 90,
                              width: 90,
                              fit: BoxFit.cover,
                            )
                          : Image.asset(
                              'img/back1.png',
                              height: 90,
                              width: 90,
                              fit: BoxFit.cover,
                            ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: Center(child: Text(data.username)),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: Center(child: Text(data.email)),
                  ),
                  Divider(),
                  Container(
                    child: Column(
                      children: [
                        FlatButton.icon(
                          icon: Icon(Icons.person),
                          label: Text('Edit Profile'),
                          onPressed: () async {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    EditProfile(data.username, user = null),
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                  Container(
                    child: Column(
                      children: [
                        FlatButton.icon(
                          icon: Icon(Icons.vpn_key),
                          label: Text('Change Password'),
                          onPressed: () async {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => ChangePassword()),
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                  Container(
                    child: Column(
                      children: [
                        FlatButton.icon(
                          icon: Icon(Icons.logout),
                          label: Text('Log Out'),
                          onPressed: () async {
                            await _auth.signOut();
                            // Navigator.pushAndRemoveUntil(
                            //   context,
                            //   MaterialPageRoute(
                            //       builder: (BuildContext context) => SignIn()),
                            //   (route) => false,
                            // );
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        });
  }
}
