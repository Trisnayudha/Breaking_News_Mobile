import 'package:flutter/material.dart';
import 'package:project_uas/service/auth.dart';

class Register extends StatefulWidget {
  final Function toggleView;
  Register({this.toggleView});
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  bool _securText = true;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final globalKey = GlobalKey<ScaffoldState>();
  final AuthService _auth = AuthService();
  String username = '';
  String password = '';

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
              Text("Register"),
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
                  onChanged: (val) {
                    setState(() => username = val);
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 5, 20, 0),
                child: TextFormField(
                  decoration: InputDecoration(
                    hintText: "Password",
                    suffixIcon: IconButton(
                      icon: Icon(
                          _securText ? Icons.remove_red_eye : Icons.security),
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
                  onChanged: (val) {
                    setState(() => password = val);
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: RaisedButton(
                  onPressed: () async {
                    print(username);
                    print(password);
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
              Text("I have already Account"),
              FlatButton(
                child: Text("Sign In"),
                onPressed: () {
                  widget.toggleView();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
