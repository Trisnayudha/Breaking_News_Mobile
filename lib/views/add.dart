import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:project_uas/home/home.dart';
import 'package:project_uas/models/item.dart';
import 'package:image_picker/image_picker.dart';

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
                          backgroundColor: Colors.grey,
                          child: CircleAvatar(
                            radius: 59,
                            backgroundColor: Colors.white,
                            backgroundImage: image != null
                                ? FileImage(image)
                                : widget.item != null
                                    ? widget.item.image.isNotEmpty
                                        ? NetworkImage(widget.item.image)
                                        : AssetImage('img/back1.png')
                                    : AssetImage('img/back1.png'),
                          ),
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
                    controller: tgglController,
                    keyboardType: TextInputType.number,
                    textAlignVertical: TextAlignVertical.center,
                    textAlign: TextAlign.left,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Tanggal',
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
                            penulis: penulisController.text,
                            image: image != null
                                ? uploadFile(image, widget.id)
                                : '',
                            desc: descController.text,
                            tggl: int.parse(tgglController.text),
                            kategori: kategoriController.text);

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
    StorageReference ref = storage.ref().child("item/" + filename);
    StorageUploadTask uploadTask = ref.putFile(image);
    StorageTaskSnapshot snapshot = await uploadTask.onComplete;
    return await snapshot.ref.getDownloadURL();
  }
}
