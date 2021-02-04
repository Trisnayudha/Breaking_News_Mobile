import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';
import 'package:project_uas/models/favorites.dart';
import 'package:project_uas/models/item.dart';
import 'package:project_uas/views/view_page.dart';
// import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
// import 'package:cached_network_image/cached_network_image.dart';

class Favorite extends StatefulWidget {
  @override
  _FavoriteState createState() => _FavoriteState();
}

class _FavoriteState extends State<Favorite> {
  Favorites favorite = Favorites();
  @override
  Widget build(BuildContext context) {
    // List<Item> listItem = Provider.of<List<Item>>(context);
    return Scaffold(
      appBar: AppBar(
        actions: <Widget>[
          IconButton(
              icon: Icon(LineIcons.trash_o),
              onPressed: () {
                favorite.clearAllfav();
                Scaffold.of(context).showSnackBar(SnackBar(
                    backgroundColor: Colors.redAccent,
                    content: Text('All Data have been deleted')));
                setState(() {});
              })
        ],
        centerTitle: true,
        title: Text(
          'Favourites',
          style: TextStyle(fontSize: 20),
        ),
      ),
      body: FutureBuilder<List<Item>>(
          future: favorite.getAllSavedData(),
          builder: (context, data) {
            if (data.hasData) {
              return ListView.builder(
                  itemCount: data.data.length,
                  itemBuilder: (BuildContext buildcontext, int index) {
                    return ListTile(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ViewPage(
                              item: data.data[index],
                              id: data.data[index].id,
                            ),
                          ),
                        );
                      },
                      leading: ClipRRect(
                        borderRadius: BorderRadius.circular(5),
                        child: Container(
                          width: 100,
                          height: 60,
                          child: ClipRRect(
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(10),
                              topRight: Radius.circular(10),
                              bottomLeft: Radius.circular(10),
                              bottomRight: Radius.circular(10),
                            ),
                            child: data.data[index].image.isNotEmpty
                                ? Image.network(
                                    data.data[index].image,
                                    height: 85,
                                    width: 85,
                                    fit: BoxFit.cover,
                                  )
                                : Image.asset(
                                    'img/back1.png',
                                    height: 85,
                                    width: 85,
                                    fit: BoxFit.cover,
                                  ),
                          ),
                        ),
                      ),
                      title: Text(
                        data.data[index].judul,
                        style: TextStyle(color: Colors.blue),
                        overflow: TextOverflow.ellipsis,
                      ),
                      subtitle: Text(
                        DateFormat.yMMMd().format(
                            DateTime.fromMicrosecondsSinceEpoch(
                                int.parse(data.data[index].tggl.toString()))),
                        style: TextStyle(fontSize: 12),
                      ),
                      trailing: IconButton(
                        onPressed: () {
                          favorite.clearPerItem(judul: data.data[index].judul);
                          Scaffold.of(context).showSnackBar(SnackBar(
                              duration: Duration(milliseconds: 500),
                              backgroundColor: Colors.red,
                              content: Text('Deleted News Succedd')));
                          setState(() {});
                        },
                        icon: Icon(
                          LineIcons.trash_o,
                          color: Colors.redAccent,
                        ),
                      ),
                    );
                  });
            } else {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
          }),
    );
  }
}
