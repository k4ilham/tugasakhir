import 'package:flutter/material.dart';
import 'package:tugasakhir/model/mod_card.dart';
import 'package:tugasakhir/page/detailimage.dart';

class Detail extends StatefulWidget {
  final mod_card detailCard;
  Detail(this.detailCard);
  @override
  _DetailState createState() => _DetailState(detailCard);
}

class _DetailState extends State<Detail> {
  final mod_card detailCard;
  _DetailState(this.detailCard);
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
          detailCard.name,
          style: TextStyle(color: Colors.white, fontSize: 20.0),
        ),
        SizedBox(height: 30.0),
      ],
    );

    final topContent = Stack(
      children: <Widget>[
        Container(
            padding: EdgeInsets.only(left: 10.0,top: 50.0, right: 10.0, bottom: 10.0 ),
            height: MediaQuery.of(context).size.height * 0.5,
            child: new Image.network(detailCard.cardImages[0].imageUrl),
            ),
        Container(
          height: MediaQuery.of(context).size.height * 0.5,
          padding: EdgeInsets.all(40.0),
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(color: Color.fromRGBO(58, 66, 86, .9)),
          child: Center(
            child: topContentText,
          ),
        ),
        Positioned(
          left: 8.0,
          top: 60.0,
          child: InkWell(
            onTap: () {
              Navigator.pop(context);
            },
            child: Icon(Icons.arrow_back, color: Colors.white),
          ),
        )
      ],
    );

    final bottomContentText = Text(
      detailCard.desc.substring(0,50),
      style: TextStyle(fontSize: 18.0),
    );
    final readButton = Container(
        padding: EdgeInsets.symmetric(vertical: 16.0),
        width: MediaQuery.of(context).size.width,
        child: RaisedButton(
          onPressed: () => {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => Detailimage(detailCard)),
            )
          },
          color: Color.fromRGBO(58, 66, 86, 1.0),
          child:
              Text("VIEW CARD", style: TextStyle(color: Colors.white)),
        ));
    final bottomContent = Container(
      width: MediaQuery.of(context).size.width,
      padding: EdgeInsets.all(40.0),
      child: Center(
        child: Column(
          children: <Widget>[bottomContentText, readButton],
        ),
      ),
    );

    return Scaffold(
      body: Column(
        children: <Widget>[topContent, bottomContent],
      ),
    );
  }
}
