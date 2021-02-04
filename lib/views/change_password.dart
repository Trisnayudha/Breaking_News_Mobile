import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:project_uas/service/auth.dart';

class ChangePassword extends StatefulWidget {
  @override
  _ChangePasswordState createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {
  String email = '';
  final _formKey = GlobalKey<FormState>();
  final auth = FirebaseAuth.instance;
  final AuthService _auth = AuthService();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.only(top: 25),
        color: Colors.white,
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
                      'Change Password',
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
            Form(
              key: _formKey,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: TextFormField(
                      textAlignVertical: TextAlignVertical.center,
                      textAlign: TextAlign.left,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Masukan Email Anda',
                      ),
                      validator: (val) =>
                          val.isEmpty ? 'Enter an email ' : null,
                      onChanged: (val) {
                        setState(() => email = val);
                      },
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  FlatButton(
                      height: 45,
                      color: Colors.blue,
                      child: Text(
                        'Send Request',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                        ),
                      ),
                      onPressed: () async {
                        auth.sendPasswordResetEmail(email: email);
                        Navigator.of(context).pop(await _auth.signOut());
                      }),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
