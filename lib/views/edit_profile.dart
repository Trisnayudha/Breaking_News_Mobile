import 'dart:developer';
import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:project_uas/models/user.dart';
import 'package:project_uas/service/database.dart';
import 'package:provider/provider.dart';

class EditProfile extends StatefulWidget {
  EditProfile(String username, this.user);
  final UserData user;

  @override
  _EditProfileState createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  final _formKey = GlobalKey<FormState>();
  // final DatabaseService _auth = DatabaseService();
  String photo;
  File image;
  String username;
  bool loading = false;
  String error = '';
  @override
  Widget build(BuildContext context) {
    Users user = Provider.of<Users>(context);
    return StreamBuilder<UserData>(
        stream: DatabaseService(uid: user.uid).userData,
        builder: (context, snapshot) {
          // inspect(snapshot);
          if (snapshot.hasData) {
            UserData userData = snapshot.data;
            // usernamenotchange = data.username;
            // image = data.photo;
            return Scaffold(
              body: Container(
                padding: EdgeInsets.only(top: 25),
                color: Colors.white,
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      Container(
                        height: 50,
                        padding: EdgeInsets.only(
                          left: 10,
                          right: 10,
                        ),
                        child: Stack(
                          children: [
                            Align(
                              alignment: Alignment.center,
                              child: Text(
                                'Edit Profile',
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
                                  child: Icon(Icons.arrow_back),
                                ),
                                onTap: () {
                                  Navigator.pop(context);
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                      Divider(
                        height: 1,
                        color: Colors.black,
                      ),
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
                                          : snapshot.data != null
                                              ? snapshot.data.photo.isNotEmpty
                                                  ? NetworkImage(
                                                      snapshot.data.photo)
                                                  : AssetImage(
                                                      'asset/image/tshirt.jpg')
                                              : AssetImage('img/back1.png'),
                                    ),
                                  ),
                                  onTap: () {
                                    getImage(context);
                                  },
                                ),
                              ),
                            ),
                            TextFormField(
                              initialValue: userData.username,
                              textAlignVertical: TextAlignVertical.center,
                              textAlign: TextAlign.left,
                              decoration: InputDecoration(
                                border: OutlineInputBorder(),
                                labelText: 'Username',
                              ),
                              onChanged: (val) {
                                setState(() => username = val);
                              },
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
                                    String randomMillis = DateTime.now()
                                        .microsecondsSinceEpoch
                                        .toString();
                                    await DatabaseService(uid: user.uid)
                                        .updateUserData(
                                      username ?? snapshot.data.username,
                                      photo ?? image != null
                                          ? snapshot.data != null
                                              ? await uploadFile(
                                                  image, randomMillis)
                                              : await uploadFile(
                                                  image, randomMillis)
                                          : '',
                                    );
                                  }
                                  inspect(snapshot.data.photo);
                                  Navigator.pop(context);
                                }),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        });
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
    Reference ref = storage.ref().child("profile/" + filename);
    UploadTask uploadTask = ref.putFile(image);
    return uploadTask.then((res) async {
      return await res.ref.getDownloadURL();
    });
  }
}
