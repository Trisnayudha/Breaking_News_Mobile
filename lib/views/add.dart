import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:project_uas/home/home.dart';
import 'package:project_uas/models/item.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

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
  TextEditingController imageController;
  TextEditingController kategoriController;
  TextEditingController penulisController;
  File image;
  DateTime newDateTime;
  @override
  void initState() {
    judulController = TextEditingController();
    descController = TextEditingController();
    tgglController = TextEditingController();
    imageController = TextEditingController();
    kategoriController = TextEditingController();
    penulisController = TextEditingController();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.only(top: 50),
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
                  Container(
                    height: 150,
                    child: Center(
                      child: InkWell(
                        child: CircleAvatar(
                          radius: 60,
                          backgroundImage: image != null
                              ? FileImage(image)
                              : widget.item != null
                                  ? widget.item.image.isNotEmpty
                                      ? NetworkImage(widget.item.image)
                                      : AssetImage('img/back1.png')
                                  : AssetImage('img/back1.png'),
                        ),
                        onTap: () {
                          getImage(context);
                        },
                      ),
                    ),
                  ),
                  TextField(
                    controller: judulController,
                    textAlignVertical: TextAlignVertical.center,
                    textAlign: TextAlign.left,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Judul Berita',
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  TextField(
                    controller: penulisController,
                    textAlignVertical: TextAlignVertical.center,
                    textAlign: TextAlign.left,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Penulis',
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  TextField(
                    controller: kategoriController,
                    textAlignVertical: TextAlignVertical.center,
                    textAlign: TextAlign.left,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Kategori',
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
                      labelText: 'Deskripsi Berita',
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  FlatButton(
                      height: 45,
                      color: Colors.blue,
                      child: Text(
                        "date",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                        ),
                      ),
                      onPressed: () async {
                        String randomtggl =
                            DateTime.now().microsecondsSinceEpoch.toString();

                        print(randomtggl);
                        var tgglfix = DateFormat.yMMMd().format(
                            DateTime.fromMicrosecondsSinceEpoch(
                                int.parse(randomtggl)));
                        print(tgglfix);
                      }),
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
                        String randomMillis =
                            DateTime.now().microsecondsSinceEpoch.toString();

                        Item item = Item(
                            id: widget.item != null
                                ? widget.item.id
                                : randomMillis,
                            judul: judulController.text,
                            penulis: penulisController.text,
                            image: image != null
                                ? widget.item != null
                                    ? await uploadFile(image, widget.id)
                                    : await uploadFile(image, randomMillis)
                                : '',
                            desc: descController.text,
                            tggl: int.parse(randomMillis),
                            kategori: kategoriController.text);
                        if (widget.item == null) {
                          FirebaseFirestore.instance
                              .collection('item')
                              .add(item.toJson());
                        } else {
                          FirebaseFirestore.instance
                              .collection('item')
                              .doc(widget.id)
                              .update(item.toJson());
                        }
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

  imgFromCamera() async {
    PickedFile imgCamera = await ImagePicker()
        .getImage(source: ImageSource.camera, imageQuality: 50);
    setState(() {
      image = File(imgCamera.path);
    });
  }

  imgFromGallery() async {
    PickedFile imgGallery = await ImagePicker()
        .getImage(source: ImageSource.gallery, imageQuality: 50);
    setState(() {
      image = File(imgGallery.path);
    });
  }

  getImage(context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext bc) {
        return SafeArea(
          child: Container(
            child: Wrap(
              children: <Widget>[
                ListTile(
                    leading: Icon(Icons.photo_library),
                    title: Text('Gallery'),
                    onTap: () {
                      imgFromGallery();
                      Navigator.of(context).pop();
                    }),
                ListTile(
                  leading: Icon(Icons.photo_camera),
                  title: Text('Camera'),
                  onTap: () {
                    imgFromCamera();
                    Navigator.of(context).pop();
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Future<String> uploadFile(File image, String filename) async {
    FirebaseStorage storage = FirebaseStorage.instance;
    Reference ref = storage.ref().child("item/" + filename);
    UploadTask uploadTask = ref.putFile(image);
    return uploadTask.then((res) async {
      return await res.ref.getDownloadURL();
    });
  }
}
