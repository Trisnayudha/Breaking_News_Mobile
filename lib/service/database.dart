import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:project_uas/models/user.dart';

class DatabaseService {
  final String uid;
  DatabaseService({this.uid});

  final FirebaseAuth _auth = FirebaseAuth.instance;
  Users _userFromFirebaseUser(User user) {
    return user != null ? Users(uid: user.uid) : null;
  }

  //Collection
  final CollectionReference userCollection =
      FirebaseFirestore.instance.collection('item');

  Future<void> createUserData(
      String username, String email, String photo) async {
    return await userCollection
        .doc(uid)
        .collection('profile')
        .doc(uid)
        .set({'username': username, 'email': email, 'photo': photo});
  }

  UserData _userDataFromSnapshot(DocumentSnapshot data) {
    return UserData(
        uid: uid,
        username: data.data()['username'],
        email: data.data()['email'],
        photo: data.data()['photo']);
  }

  Stream<UserData> get userData {
    return userCollection
        .doc(uid)
        .collection('profile')
        .doc(uid)
        .snapshots()
        .map(_userDataFromSnapshot);
  }

  // Future<void> changeProfile(String username) async {
  //   return await userCollection
  //       .doc(uid)
  //       .collection('profile')
  //       .doc(uid)
  //       .set({'username': username});
  // }

  //buat Masukin data ke database
  Future createBerita(String judul, String penulis, String kategori,
      String tggl, String desc, String image) async {
    try {
      User user = _auth.currentUser;
      await DatabaseService(uid: user.uid)
          .createDataBerita(judul, penulis, kategori, tggl, desc, image);
      return _userFromFirebaseUser(user);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  Future<void> createDataBerita(String judul, String penulis, String kategori,
      String tggl, String desc, String image) async {
    return await userCollection.doc(uid).collection('Berita').add({
      'judul': judul,
      'penulis': penulis,
      'kategori': kategori,
      'tggl': tggl,
      'desc': desc,
      'image': image,
    });
  }

  // BeritaData _userDataFromSnapShot(DocumentSnapshot data) {
  //   return BeritaData(
  //     judul: data.data()['judul'],
  //     penulis: data.data()['penulis'],
  //     kategori: data.data()['kategori'],
  //     tggl: data.data()['tggl'],
  //     desc: data.data()['desc'],
  //   );
  // }

  // List<BeritaData> _beritaListFromSnapshot(QuerySnapshot snapshot) {
  //   return snapshot.docs.map((doc) {
  //     return BeritaData(
  //         judul: doc.data()['judul'],
  //         penulis: doc.data()['penulis'],
  //         kategori: doc.data()['kategori'],
  //         tggl: doc.data()['tggl'],
  //         desc: doc.data()['desc']);
  //   }).toList();
  // }

  // Stream<List<BeritaData>> get beritaData {
  //   return userCollection
  //       .doc()
  //       .collection('Berita')
  //       .snapshots()
  //       .map(_beritaListFromSnapshot);
  // }
}
