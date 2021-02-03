import 'package:flutter/material.dart';
import 'package:project_uas/service/auth.dart';

class Favorite extends StatefulWidget {
  @override
  _FavoriteState createState() => _FavoriteState();
}

class _FavoriteState extends State<Favorite> {
  @override
  Widget build(BuildContext context) {
    final AuthService _auth = AuthService();
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text("Favorite")),
        elevation: 0.0,
      ),
      body: Column(
        children: [
          Container(
            child: Column(
              children: [
                FlatButton.icon(
                  icon: Icon(Icons.logout),
                  label: Text('Log Out'),
                  onPressed: () async {
                    await _auth.signOut();
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
