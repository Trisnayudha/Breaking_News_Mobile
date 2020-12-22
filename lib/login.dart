import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'dashboard.dart';

class FormLogin extends StatefulWidget {
  @override
  _FormLoginState createState() => _FormLoginState();
}

class _FormLoginState extends State<FormLogin> {
  bool _securText = true;
  TextEditingController userController = new TextEditingController();
  TextEditingController passController = new TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final globalKey = GlobalKey<ScaffoldState>();

  String user = '';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
            key: _formKey,
            child: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  Image.asset(
                    "img/logo.jpg",
                    width: 300.0,
                    height: 300.0,
                  ),
                  Divider(),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(20, 5, 20, 0),
                    child: TextFormField(
                      controller: userController,
                      decoration: InputDecoration(
                        hintText: "Username",
                        suffixIcon: Icon(
                          Icons.account_box,
                          color: Colors.blueAccent,
                        ),
                        focusedBorder: UnderlineInputBorder(
                          //DENGAN BORDER BERWARNA PINK
                          borderSide: BorderSide(
                            color: Colors.blueAccent,
                          ),
                        ),
                        labelText: "Username: ",
                        labelStyle: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      validator: (String value) {
                        if (value.isEmpty) {
                          return "Email diperlukan";
                        } else {
                          return null;
                        }
                      },
                      onChanged: (String value) {
                        user = value;
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(20, 5, 20, 0),
                    child: TextFormField(
                      controller: passController,
                      decoration: InputDecoration(
                        hintText: "Password",
                        suffixIcon: IconButton(
                          icon: Icon(_securText
                              ? Icons.remove_red_eye
                              : Icons.security),
                          onPressed: () {
                            setState(() {
                              _securText = !_securText;
                            });
                          },
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.blueAccent,
                          ),
                        ),
                        labelText: "Password: ",
                        labelStyle: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      obscureText: _securText,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: RaisedButton(
                      onPressed: () {
                        if (userController.text == 'trisnayudha' &&
                            passController.text == 'yudha ganteng') {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => Dashboard(),
                            ),
                          );
                        } else {
                          showAlertDialogCupertino('Input!!!');
                        }
                      },
                      color: Colors.blue[100],
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(80.0),
                      ),
                      padding: const EdgeInsets.all(0.0),
                      child: Ink(
                        child: Container(
                          constraints: const BoxConstraints(
                            minWidth: 36.0,
                            minHeight: 36.0,
                          ),
                          alignment: Alignment.center,
                          child: const Text(
                            'Login',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.blueAccent,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            )));
  }

  showAlertDialogCupertino(text) {
    showDialog(
      context: context,
      builder: (context) {
        return CupertinoAlertDialog(
          title: Text('Informasi'),
          content: Text('Username atau Password Salah'),
          actions: [
            CupertinoDialogAction(
              child: Text('OK'),
              onPressed: () {
                Navigator.pop(context);
                print('Clicked No!');
              },
            ),
          ],
        );
      },
      barrierColor: Colors.black.withOpacity(0.5),
      barrierDismissible: false,
    );
  }
}
