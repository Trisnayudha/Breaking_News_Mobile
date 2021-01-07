import 'package:flutter/material.dart';
import 'package:project_uas/models/item.dart';

class CardItem extends StatefulWidget {
  final Item item;

  CardItem({@required this.item});

  @override
  _CardItemState createState() => _CardItemState();
}

class _CardItemState extends State<CardItem> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      width: 150,
      margin: EdgeInsets.only(
        right: 5,
        left: 5,
        bottom: 5,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(10)),
        color: Colors.red,
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
                bottomRight: Radius.circular(10)),
            child:
                // widget.item.image.isNotEmpty
                //     ? Image.network(
                //         widget.item.image,
                //         height: 100,
                //         width: 90,
                //         fit: BoxFit.cover,
                //       )
                //     :
                Image.asset(
              'img/back1.png',
              height: 100,
              width: 90,
              fit: BoxFit.cover,
            ),
          ),
          Container(
            height: 150,
            width: 200,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Center(
                  child: Text(
                    widget.item.judul,
                    style: TextStyle(fontSize: 12, color: Colors.black),
                    maxLines: 1,
                    textAlign: TextAlign.start,
                    overflow: TextOverflow.clip,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
