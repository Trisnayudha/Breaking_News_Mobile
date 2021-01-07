import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:project_uas/home/home.dart';
import 'package:project_uas/models/item.dart';

class Add extends StatefulWidget {
  final Item item;
  final String id;

  Add({@required this.item, this.id});

  @override
  _AddState createState() => _AddState();
}

class _AddState extends State<Add> {
  TextEditingController judulController;
  TextEditingController descController;
  TextEditingController tgglController;

  @override
  void initState() {
    judulController = TextEditingController();
    descController = TextEditingController();
    tgglController = TextEditingController();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.item != null) {
      judulController.text = widget.item.judul;
      descController.text = widget.item.desc;
      tgglController.text = widget.item.tggl.toString();
    }

    return Scaffold(
      body: Container(
        padding: EdgeInsets.only(top: 25),
        color: Colors.white,
        child: Column(
          children: [
            Expanded(
              child: ListView(
                padding: EdgeInsets.only(
                  top: 10,
                  left: 10,
                  right: 10,
                ),
                children: [
                  TextField(
                    controller: judulController,
                    textAlignVertical: TextAlignVertical.center,
                    textAlign: TextAlign.left,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Name',
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  TextField(
                    controller: descController,
                    textAlignVertical: TextAlignVertical.center,
                    textAlign: TextAlign.left,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Desc',
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  TextField(
                    controller: tgglController,
                    keyboardType: TextInputType.number,
                    textAlignVertical: TextAlignVertical.center,
                    textAlign: TextAlign.left,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Qty',
                    ),
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
                      onPressed: () {
                        Item item = Item(
                          id: 'CH-09',
                          judul: judulController.text,
                          penulis: '',
                          desc: descController.text,
                          tggl: int.parse(tgglController.text),
                          kategori: '',
                        );

                        Firestore.instance
                            .collection('item')
                            .add(item.toJson());

                        Navigator.of(context).pushReplacement(
                            new MaterialPageRoute(
                                builder: (BuildContext context) {
                          return new Home();
                        }));
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
