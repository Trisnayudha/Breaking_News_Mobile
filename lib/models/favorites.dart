import 'package:project_uas/models/item.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Favorites {
  Future save({Item news}) async {
    final pref = await SharedPreferences.getInstance();

    pref.setStringList(news.judul,
        [news.judul, news.tggl.toString(), news.image]).then((value) {
      value ? print('Berhasil Disimpan') : print('Gagal Disimpan');
    });
  }

  Future<List<Item>> getAllSavedData() async {
    final pref = await SharedPreferences.getInstance();

    var favs = pref.getKeys();
    List<String> keys = [];
    List<Item> listItem = [];

    favs.forEach((element) {
      keys.add(element);
    });

    keys.forEach((element) {
      List<String> content = pref.getStringList(element);
      Item news = Item(
        judul: content[0],
        tggl: int.parse(content[1]),
        image: content[2],
      );
      listItem.add(news);
    });
    print(listItem);
    return (listItem);
  }

  Future clearAllfav() async {
    final pref = await SharedPreferences.getInstance();

    pref.clear().then((value) {
      print('Semua data dihapus');
    });
  }

  Future clearPerItem({String judul}) async {
    final pref = await SharedPreferences.getInstance();

    pref.remove(judul);
  }
}
