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
  DateTime newDateTime;
  bool loading = false;
  final _formKey = GlobalKey<FormState>();
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
        child: Form(
          key: _formKey,
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
                    TextFormField(
                      controller: judulController,
                      textAlignVertical: TextAlignVertical.center,
                      textAlign: TextAlign.left,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Judul Berita',
                      ),
                      validator: (val) => val.isEmpty ? 'Isi Judul!!' : null,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                      controller: penulisController,
                      textAlignVertical: TextAlignVertical.center,
                      textAlign: TextAlign.left,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Penulis',
                      ),
                      validator: (val) => val.isEmpty ? 'Isi Penulis!!' : null,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                      controller: kategoriController,
                      textAlignVertical: TextAlignVertical.center,
                      textAlign: TextAlign.left,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Kategori',
                      ),
                      validator: (val) => val.isEmpty ? 'Isi Kategori!!' : null,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                      controller: descController,
                      minLines:
                          4, // any number you need (It works as the rows for the textarea)
                      keyboardType: TextInputType.multiline,
                      maxLines: null,
                      textAlignVertical: TextAlignVertical.center,
                      textAlign: TextAlign.left,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Deskripsi Berita',
                      ),
                      validator: (val) =>
                          val.isEmpty ? 'Isi Deskripsi Berita!!' : null,
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
                        onPressed: () async {
                          if (_formKey.currentState.validate()) {
                            setState(() => loading = true);
                            String randomMillis = DateTime.now()
                                .microsecondsSinceEpoch
                                .toString();

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
                          }
                        }),
                  ],
                ),
              ),
            ],
          ),
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
