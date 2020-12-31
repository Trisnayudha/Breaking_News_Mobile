class Item {
  final String id;
  final String judul;
  final String penulis;
  final String desc;
  final int tggl;
  final String kategori;

  Item({
    this.id,
    this.judul,
    this.penulis,
    this.desc,
    this.tggl,
    this.kategori,
  });

  factory Item.fromJson(Map<String, dynamic> json) {
    return Item(
      id: json['id'],
      judul: json['judul'],
      penulis: json['penulis'],
      desc: json['desc'],
      tggl: json['tggl'],
      kategori: json['kategori'],
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'judul': judul,
        'penulis': penulis,
        'desc': desc,
        'tggl': tggl,
        'kategori': kategori,
      };
}
