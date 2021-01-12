import 'package:flutter/material.dart';

class Search extends StatefulWidget {
  @override
  _SearchState createState() => _SearchState();
}

class _SearchState extends State<Search> {
  bool _search = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(5, 20, 5, 5),
            child: TextFormField(
                decoration: InputDecoration(
              hintText: "Search",
              suffixIcon: IconButton(
                icon: Icon(_search ? Icons.search : Icons.cancel),
                color: Colors.blueAccent,
                onPressed: () {
                  setState(() {                    
                    _search = !_search;
                  });
                },
              ),
              focusedBorder: UnderlineInputBorder(
                
                borderSide: BorderSide(
                  color: Colors.blueAccent,
                ),
              ),
              labelText: "Search",
              labelStyle: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            )),
          ),
          Divider(height: 20,),
          //Page buat menampilkan hasil search

          
        ],
      ),
    );
  }
}
