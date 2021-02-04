import 'package:cloud_firestore/cloud_firestore.dart';

class Item {
  final String id;
  final String judul;
  final String penulis;
  final String image;
  final String desc;
  final int tggl;
  final String kategori;

  Item({
    this.id,
    this.judul,
    this.penulis,
    this.image,
    this.desc,
    this.tggl,
    this.kategori,
  });

  factory Item.fromJson(Map<String, dynamic> json) {
    return Item(
      id: json['id'],
      judul: json['judul'],
      penulis: json['penulis'],
      image: json['image'],
      desc: json['desc'],
      tggl: json['tggl'],
      kategori: json['kategori'],
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'judul': judul,
        'penulis': penulis,
        'image': image,
        'desc': desc,
        'tggl': tggl,
        'kategori': kategori,
      };

  factory Item.fromFireStore(DocumentSnapshot doc) {
    return Item(
      id: doc['id'],
      judul: doc['judul'],
      penulis: doc['penulis'],
      image: doc['image'],
      desc: doc['desc'],
      tggl: doc['tggl'],
      kategori: doc['kategori'],
    );
  }
}
class ItemProvider {
  static Stream<List<Item>> fetchAll() {
    return FirebaseFirestore.instance.collection('item').snapshots().map(
        (list) => list.docs.map((doc) => Item.fromFireStore(doc)).toList());
  }
}