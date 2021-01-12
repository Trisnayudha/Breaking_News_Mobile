import 'package:flutter/material.dart';

enum Condition { initial, processing, result }

class Search extends StatefulWidget {
  @override
  _SearchState createState() => _SearchState();
}

class _SearchState extends State<Search> {
  
  TextEditingController keyword = TextEditingController();
  // List<News> listNews = List<News>();
  Condition condition = Condition.initial;
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        height: size.height,
        width: size.width,
        child: Column(
          children: <Widget>[
            headSection(size: size.width),
            condition == Condition.initial
                ? Container()
                : condition == Condition.processing
                    ? Expanded(
                        child: Center(
                          child: Text(
                            'Please wait...',
                            style: TextStyle(fontSize: 12),
                          ),
                        ),
                      )
                    : null
                    // BodySection(
                    //listNews: listNews,
                    // )
          ],
        ),
      ),
    );
  }

  void clearText() {
    setState(() {
      keyword.clear();
    });
  }

  Widget headSection({double size}) {
    return Container(
      padding: EdgeInsets.only(top: 40, left: 10, right: 10),
      height: 180,
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.lightBlue[300],
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(45),
          bottomRight: Radius.circular(45),
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Text(
            'Breaking News',
            style: TextStyle(
                fontSize: 28,
                color: Colors.black54,
                fontWeight: FontWeight.bold),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 5),
            width: size * 0.9,
            height: 50,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(45), color: Colors.white),
            child: Row(
              children: <Widget>[
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.only(left: 10),
                    child: TextField(
                      style: TextStyle(color: Colors.black87),
                      cursorColor: Colors.black54,
                      controller: keyword,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: "Search",
                      ),
                    ),
                  ),
                ),
                IconButton(
                    icon: Icon(
                      Icons.search,
                      color: Colors.blue,
                    ),
                    onPressed: () {
                      setState(() {
                        condition = Condition.processing;
                      });
                      // service.getNews(keyword: keyword.text).then((value) {
                      //   setState(() {
                      //     listNews = value;
                      //     condition = Condition.result;
                      //   });
                      // });
                      clearText();
                    })
              ],
            ),
          )
        ],
      ),
    );
  }
}
