import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:project_uas/service/news.dart';
import 'package:project_uas/service/globalnews.dart';
import 'package:url_launcher/url_launcher.dart';

enum Condition { initial, processing, result }

class Search extends StatefulWidget {
  @override
  _SearchState createState() => _SearchState();
}

class _SearchState extends State<Search> {
  TextEditingController keyword = TextEditingController();
  GlobalNews service = GlobalNews();
  List<News> listNews = List<News>();
  Condition condition = Condition.initial;
  bool isProcess = false;
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
                    : BodySection(
                        listNews: listNews,
                      )
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
      height: 120,
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
                      service.getNews(keyword: keyword.text).then((value) {
                        setState(() {
                          listNews = value;
                          condition = Condition.result;
                        });
                      });
                      clearText();
                    }),
              ],
            ),
          )
        ],
      ),
    );
  }
}

class BodySection extends StatefulWidget {
  final List<News> listNews;
  BodySection({this.listNews});

  @override
  _BodySectionState createState() => _BodySectionState();
}

class _BodySectionState extends State<BodySection> {
  _launchURL({BuildContext context, String url}) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      Scaffold.of(context)
          .showSnackBar(SnackBar(content: Text('Sorry, Url is not valid')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        padding: EdgeInsets.all(5),
        child: Column(
          children: widget.listNews.map((element) {
            return ListTile(
              onTap: () {
                _launchURL(context: context, url: element.newsUrl);
              },
              leading: ClipRRect(
                borderRadius: BorderRadius.circular(5),
                child: Container(
                  width: 100,
                  height: 75,
                  child: CachedNetworkImage(
                    imageUrl: element.imgUrl == null
                        ? 'https://bodybigsize.com/wp-content/uploads/2020/02/noimage-7.png'
                        : element.imgUrl,
                    placeholder: (context, url) =>
                        Center(child: CircularProgressIndicator()),
                    errorWidget: (context, url, error) => Icon(Icons.error),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              title: Text(
                element.title,
                style: TextStyle(color: Colors.blue),
                overflow: TextOverflow.ellipsis,
              ),
              subtitle: Text(
                element.source,
                style: TextStyle(fontSize: 12),
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}
