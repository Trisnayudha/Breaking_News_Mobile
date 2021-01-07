import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:project_uas/models/item.dart';

class ViewPage extends StatefulWidget {
  final Item item;
  final String id;

  ViewPage({@required this.item, this.id});

  @override
  _ViewPageState createState() => _ViewPageState();
}

class _ViewPageState extends State<ViewPage> {
  TextEditingController judulController;
  TextEditingController descController;
  TextEditingController tgglController;

  @override
  void initState() {
    judulController = TextEditingController();
    descController = TextEditingController();
    tgglController = TextEditingController();
    // String tggls = tgglController.toString();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.only(top: 25),
        child: Column(
          children: <Widget>[
            Container(
              height: 50,
              padding: EdgeInsets.only(
                left: 10,
                right: 10,
              ),
              child: Stack(
                children: [
                  Align(
                    alignment: Alignment.center,
                    child: Text(
                      'Kategori',
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: InkWell(
                      child: Padding(
                        padding: EdgeInsets.all(5),
                        child: Icon(Icons.arrow_back_ios),
                      ),
                      onTap: () {
                        Navigator.pop(context);
                      },
                    ),
                  ),
                ],
              ),
            ),
            Divider(
              height: 1,
              color: Colors.black,
            ),
            Expanded(
              child: ListView(
                padding: EdgeInsets.only(
                  top: 10,
                  left: 10,
                  right: 10,
                ),
                children: [
                  Text(
                    widget.item.judul,
                    style: GoogleFonts.poppins(
                      textStyle: TextStyle(
                          letterSpacing: .4,
                          fontSize: 28.0,
                          color: Colors.black,
                          fontWeight: FontWeight.w600),
                    ),
                    textAlign: TextAlign.left,
                  ),
                  Image.asset(
                    'img/back1.png',
                    fit: BoxFit.cover,
                  ),
                  Container(
                    child: Row(
                      children: [
                        Text("Tanggal Publish: "),
                        Text(widget.item.tggl.toString()),
                        Text(" Penulis: "),
                        Text(widget.item.penulis),
                      ],
                    ),
                  ),
                  Divider(),
                  Text(widget.item.desc),
                  Divider(
                    height: 20,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
