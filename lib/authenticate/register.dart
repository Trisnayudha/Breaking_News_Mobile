import 'package:flutter/material.dart';
import 'package:project_uas/service/auth.dart';
import 'package:project_uas/service/loading.dart';

class Register extends StatefulWidget {
  final Function toggleView;
  Register({this.toggleView});

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();
  final globalKey = GlobalKey<ScaffoldState>();
  //fitur
  bool _securText = true;
  bool loading = false;
  //Text Field
  String username;
  String email;
  String password;
  String error = '';
  @override
  Widget build(BuildContext context) {
    return loading
        ? Loading()
        : Scaffold(
            body: SingleChildScrollView(
              child: Form(
                key: _formKey,
                child: Column(
                  children: <Widget>[
                    Divider(),
                    Image.asset(
                      "img/back1.png",
                      width: 300.0,
                      height: 300.0,
                    ),
                    Divider(),
                    Text("Register"),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(20, 5, 20, 0),
                      child: TextFormField(
                        decoration: InputDecoration(
                          hintText: "Username",
                          suffixIcon: Icon(
                            Icons.person,
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
                        validator: (val) =>
                            val.isEmpty ? 'Enter an Username ' : null,
                        onChanged: (val) {
                          setState(() => username = val);
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(20, 5, 20, 0),
                      child: TextFormField(
                        decoration: InputDecoration(
                          hintText: "Email",
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
                          labelText: "Email: ",
                          labelStyle: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        validator: (val) =>
                            val.isEmpty ? 'Enter an email ' : null,
                        onChanged: (val) {
                          setState(() => email = val);
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(20, 5, 20, 0),
                      child: TextFormField(
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
                        validator: (val) =>
                            val.length < 8 ? 'Minimal 8 Karakter ' : null,
                        onChanged: (val) {
                          setState(() => password = val);
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: RaisedButton(
                        onPressed: () async {
                          if (_formKey.currentState.validate()) {
                            setState(() => loading = true);
                            dynamic result =
                                await _auth.registerWithEmailAndPassword(
                                    username, email, password);
                            if (result == null) {
                              setState(() {
                                error = "Please supply a valid email";
                                loading = false;
                              });
                            }
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
                              'Register',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Colors.blueAccent,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Container(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text("I have already Account"),
                          TextButton(
                            child: Text("Sign In"),
                            onPressed: () {
                              widget.toggleView();
                            },
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
  }
}
