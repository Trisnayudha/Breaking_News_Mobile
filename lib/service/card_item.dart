import 'package:flutter/material.dart';
import 'package:project_uas/models/favorites.dart';
import 'package:project_uas/models/item.dart';
import 'package:intl/intl.dart';

class CardItem extends StatefulWidget {
  final Item item;

  CardItem({@required this.item});

  @override
  _CardItemState createState() => _CardItemState();
}

class _CardItemState extends State<CardItem> {
  Favorites favorite = Favorites();
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 85,
      width: 160,
      margin: EdgeInsets.only(
        left: 5,
        bottom: 5,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(10)),
        // color: Colors.red,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(10),
              topRight: Radius.circular(10),
              bottomLeft: Radius.circular(10),
              bottomRight: Radius.circular(10),
            ),
            child: widget.item.image.isNotEmpty
                ? Image.network(
                    widget.item.image,
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
          Container(
            height: 85,
            width: 180,
            // color: Colors.blue,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  widget.item.judul.toUpperCase(),
                  style: TextStyle(
                      fontSize: 14,
                      color: Colors.black,
                      fontWeight: FontWeight.bold),
                  maxLines: 1,
                  textAlign: TextAlign.start,
                  overflow: TextOverflow.ellipsis,
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 25, 0, 0),
                  child: Text(
                      DateFormat.yMMMd().format(
                          DateTime.fromMicrosecondsSinceEpoch(
                              int.parse(widget.item.tggl.toString()))),
                      style: TextStyle(fontSize: 10, color: Colors.grey),
                      maxLines: 1,
                      textAlign: TextAlign.start,
                      overflow: TextOverflow.ellipsis),
                )
              ],
            ),
          ),
          Container(
            // color: Colors.red,
            width: 30,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                    icon: Icon(
                      Icons.add,
                      color: Colors.green,
                    ),
                    onPressed: () {
                      favorite.save(news: widget.item).then((value) {
                        Scaffold.of(context).showSnackBar(SnackBar(
                            duration: Duration(milliseconds: 500),
                            backgroundColor: Colors.green,
                            content: Text('News has been saved')));
                      });
                    }),
              ],
            ),
          )
        ],
      ),
    );
  }
}
