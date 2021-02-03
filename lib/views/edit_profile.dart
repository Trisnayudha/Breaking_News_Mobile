import 'dart:io';

import 'package:flutter/material.dart';
import 'package:project_uas/models/user.dart';
import 'package:project_uas/service/database.dart';
import 'package:provider/provider.dart';

class EditProfile extends StatefulWidget {
  EditProfile(String username);

  @override
  _EditProfileState createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  final _formKey = GlobalKey<FormState>();
  // final DatabaseService _auth = DatabaseService();
  File image;
  String usernamenotchange;
  String username;
  String email;
  String emailnotchange;
  bool loading = false;
  String error = '';
  @override
  Widget build(BuildContext context) {
    Users user = Provider.of<Users>(context);
    return StreamBuilder<UserData>(
        stream: DatabaseService(uid: user.uid).userData,
        builder: (context, snapshot) {
          // inspect(snapshot);
          UserData data = snapshot.data;
          if (snapshot.hasData) {
            usernamenotchange = data.username;
            emailnotchange = data.email;
            return Scaffold(
              body: Container(
                padding: EdgeInsets.only(top: 25),
                color: Colors.white,
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      Container(
                        height: 50,
                        padding: EdgeInsets.only(
                          left: 10,
                          right: 10,
                        ),
                        child: Stack(
                          children: [
                            Align(
                              alignment: Alignment.center,
                              child: Text(
                                'Edit Profile',
                                style: TextStyle(
                                  fontSize: 18,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                            Align(
                              alignment: Alignment.centerLeft,
                              child: InkWell(
                                child: Padding(
                                  padding: EdgeInsets.all(5),
                                  child: Icon(Icons.arrow_back),
                                ),
                                onTap: () {
                                  Navigator.pop(context);
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                      Divider(
                        height: 1,
                        color: Colors.black,
                      ),
                      Expanded(
                        child: ListView(
                          padding: EdgeInsets.only(
                            top: 10,
                            left: 10,
                            right: 10,
                          ),
                          children: [
                            Container(
                              height: 150,
                              child: Center(
                                child: InkWell(
                                  child: CircleAvatar(
                                    radius: 60,
                                    backgroundColor: Colors.grey,
                                    child: CircleAvatar(
                                      radius: 59,
                                      backgroundColor: Colors.white,
                                      backgroundImage:
                                          // image != null
                                          //     ? FileImage(image)
                                          //     : widget.item != null
                                          //         ? widget.item.image.isNotEmpty
                                          //             ? NetworkImage(widget.item.image)
                                          //             : AssetImage('asset/image/tshirt.jpg')
                                          // :
                                          AssetImage('img/back1.png'),
                                    ),
                                  ),
                                  // onTap: () {
                                  //   getImage(context);
                                  // },
                                ),
                              ),
                            ),
                            TextFormField(
                              // controller: username,

                              textAlignVertical: TextAlignVertical.center,
                              textAlign: TextAlign.left,
                              decoration: InputDecoration(
                                // hintText: data.username,
                                border: OutlineInputBorder(),
                                labelText: 'Username',
                              ),
                              onChanged: (val) {
                                setState(() => username = val);
                              },
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            TextFormField(
                              textAlignVertical: TextAlignVertical.center,
                              textAlign: TextAlign.left,
                              decoration: InputDecoration(
                                // hintText: data.email,
                                border: OutlineInputBorder(),
                                labelText: 'Email',
                              ),
                              onChanged: (val) {
                                setState(() => email = val);
                              },
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            FlatButton(
                                height: 45,
                                color: Colors.blue,
                                child: Text(
                                  'Submit',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 14,
                                  ),
                                ),
                                onPressed: () async {
                                  // dynamic result = username != null
                                  //     ? username
                                  //     : usernamenotchange;
                                  // print(result);
                                  // if (_formKey.currentState.validate()) {
                                  //   setState(() => loading = true);
                                  //   dynamic result = _auth.changeProfile(
                                  //       username != null
                                  //           ? username
                                  //           : usernamenotchange);
                                  //   if (result == null) {
                                  //     setState(() {
                                  //       error = "Please supply a valid email";
                                  //       loading = false;
                                  //     });
                                  //   }
                                  // }
                                  Navigator.pop(context);
                                }),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
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
