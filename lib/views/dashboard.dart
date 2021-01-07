import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:project_uas/models/item.dart';
import 'package:project_uas/service/card_item.dart';
import 'package:project_uas/views/view_page.dart';

class Dashboard extends StatefulWidget {
  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Column(
          children: [
            Container(
              height: 550,
              padding: EdgeInsets.all(15),
              color: Colors.blue,
              child: StreamBuilder(
                stream: Firestore.instance.collection('item').snapshots(),
                builder: (BuildContext context,
                    AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (!snapshot.hasData) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  return ListView(
                    scrollDirection: Axis.vertical,
                    children: snapshot.data.documents.map((document) {
                      Item item = Item(
                        id: document['id'],
                        judul: document['judul'],
                        image: document['image'],
                        penulis: document['penulis'],
                        desc: document['desc'],
                        tggl: document['tggl'],
                        kategori: document['kategori'],
                      );
                      return InkWell(
                        child: CardItem(item: item),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ViewPage(
                                item: item,
                                id: document.documentID,
                              ),
                            ),
                          );
                        },
                      );
                    }).toList(),
                  );
                },
              ),
            ),
            Divider(),
          ],
        ),
      ),
    );
  }
}
