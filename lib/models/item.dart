class Item {
  final String id;
  final String judul;
  final String penulis;
  final String image;
  final String desc;
  final String tggl;
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
}
