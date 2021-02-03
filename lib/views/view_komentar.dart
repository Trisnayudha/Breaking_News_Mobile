import 'package:flutter/material.dart';
// import 'package:project_uas/models/item.dart';
// import 'package:provider/provider.dart';

class Komentar extends StatefulWidget {
  @override
  _KomentarState createState() => _KomentarState();
}

class _KomentarState extends State<Komentar> {
  @override
  Widget build(BuildContext context) {
    // List<Item> listItem = Provider.of<List<Item>>(context);
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            //baris pertama
            Padding(
              padding: const EdgeInsets.only(top: 18),
              child: Container(
                height: 70,
                padding: EdgeInsets.only(
                  left: 10,
                  right: 10,
                ),
                child: Stack(
                  children: [
                    Align(
                      alignment: Alignment.center,
                      child: Text(
                        "Komentar",
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
                          child: Icon(Icons.arrow_back_ios),
                        ),
                        onTap: () {
                          Navigator.pop(context);
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
            //Isi Komentar
            Divider(
              height: 5,
            ),
            Container(
              height: 580,
              width: 330,
              color: Colors.white,
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(25),
                            topRight: Radius.circular(25),
                            bottomLeft: Radius.circular(25),
                            bottomRight: Radius.circular(25),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(2, 5, 0, 0),
                            child: Image.asset(
                              'img/back1.png',
                              height: 35,
                              width: 40,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.fromLTRB(10, 0, 0, 5),
                              child: Text("Username"),
                            ),
                            Padding(
                              padding: const EdgeInsets.fromLTRB(8, 0, 0, 0),
                              child: Text("Komentar"),
                            ),
                          ],
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(50, 0, 0, 0),
                      child: Row(
                        children: [
                          Text(
                            "Baru Saja",
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.grey,
                            ),
                          ),
                          Padding(
                              padding: const EdgeInsets.fromLTRB(30, 0, 0, 0),
                              child: FlatButton(
                                child: Text("Balas Pesan"),
                                onPressed: () {},
                              )),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),

            //Komentar
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 0, 15, 15),
              child: TextFormField(
                decoration: InputDecoration(
                  prefixIcon: Image.asset(
                    'img/back1.png',
                    height: 15,
                    width: 20,
                    fit: BoxFit.cover,
                  ),
                  hintText: "Komentar",
                  suffixIcon: IconButton(
                    icon: Icon(Icons.send),
                    onPressed: () {
                      //isi text
                    },
                  ),
                  labelText: "Berikan komentar anda ",
                  labelStyle: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
