import 'package:flutter/material.dart';
import 'package:tugasakhir/model/mod_card.dart';

class Detailimage extends StatefulWidget {
  final mod_card dimage;
  Detailimage(this.dimage);
  @override
  _DetailimageState createState() => _DetailimageState(dimage);
}

class _DetailimageState extends State<Detailimage> {
  final mod_card dimage;
  _DetailimageState(this.dimage);
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final topContentText = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        SizedBox(height: 20.0),
        Text(
          dimage.name,
          style: TextStyle(color: Colors.white, fontSize: 20.0),
        ),
        SizedBox(height: 30.0),
      ],
    );

    final topContent = Stack(
      children: <Widget>[
        Center(
          child: Container(
            padding: EdgeInsets.only(
                left: 10.0, top: 10.0, right: 10.0, bottom: 10.0),
            height: MediaQuery.of(context).size.height * 0.7,
            child: new Image.network(dimage.cardImages[0].imageUrl),
          ),
        ),
      ],
    );

    return Scaffold(
        body: Column(
          children: <Widget>[topContent],
        ),
        appBar: AppBar(
          title: Text(dimage.name),
          elevation: 0.1,
          backgroundColor: Color.fromRGBO(58, 66, 86, 1.0),
          leading: InkWell(
            onTap: () {
              Navigator.pop(context);
            },
            child: Icon(Icons.arrow_back, color: Colors.white),
          ),
        ));
  }
}
