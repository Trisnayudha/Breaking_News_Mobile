import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:project_uas/models/item.dart';
import 'package:intl/intl.dart';
import 'package:project_uas/views/view_komentar.dart';

class ViewPage extends StatefulWidget {
  final Item item;
  final String id;

  ViewPage({
    @required this.item,
    this.id,
  });

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
                      widget.item.kategori,
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
                    widget.item.judul.toUpperCase(),
                    style: GoogleFonts.poppins(
                      textStyle: TextStyle(
                          letterSpacing: .4,
                          fontSize: 28.0,
                          color: Colors.black,
                          fontWeight: FontWeight.w600),
                    ),
                    textAlign: TextAlign.left,
                  ),
                  Divider(),
                  widget.item.image.isNotEmpty
                      ? Image.network(
                          widget.item.image,
                          height: 250,
                          fit: BoxFit.cover,
                        )
                      : Image.asset(
                          'img/back1.png',
                          fit: BoxFit.cover,
                        ),
                  Divider(),
                  Container(
                    child: Row(
                      children: [
                        Text("Tanggal Publish: "),
                        Text(DateFormat.yMMMd().format(
                            DateTime.fromMicrosecondsSinceEpoch(
                                int.parse(widget.item.tggl.toString())))),
                      ],
                    ),
                  ),
                  Divider(),
                  Container(
                    child: Row(
                      children: [
                        Text("Penulis: "),
                        Text(widget.item.penulis),
                      ],
                    ),
                  ),
                  Divider(),
                  Text(widget.item.desc),
                  Divider(
                    height: 20,
                  ),
                  Container(
                    color: Colors.red,
                    width: 180,
                    height: 50,
                    child: SizedBox(
                      width: 0,
                      child: RaisedButton(
                        child: Center(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Center(child: Icon(Icons.comment_rounded)),
                              Center(child: Text("Berikan Komentar")),
                            ],
                          ),
                        ),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => Komentar(
                                  //
                                  ),
                            ),
                          );
                        },
                        color: Colors.white,
                        textColor: Colors.black,
                      ),
                    ),
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
