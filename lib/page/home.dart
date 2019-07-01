import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/foundation.dart';
import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:tugasakhir/model/mod_card.dart';
import 'package:tugasakhir/page/detail.dart';

class Home extends StatelessWidget {
  final String title;

  Home({Key key, this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(58, 66, 86, 1.0),
      appBar: AppBar(
        title: Text(title),
        elevation: 0.1,
        backgroundColor: Color.fromRGBO(58, 66, 86, 1.0),
        leading: Icon(Icons.map),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.exit_to_app),
            onPressed: () {
              return showDialog(
                  context: context,
                  barrierDismissible: false,
                  builder: (context) {
                    return AlertDialog(
                      title: Text('Peringatan'),
                      content: Text('Apakah Yakin akan keluar?'),
                      actions: <Widget>[
                        FlatButton(
                          child: Text('TIDAK'),
                          onPressed: () {
                            Navigator.pop(context);
                          },
                        ),
                        FlatButton(
                          child: Text('YA'),
                          onPressed: () {
                            exit(0);
                          },
                        )
                      ],
                    );
                  });
            },
          )
        ],
      ),
      body: FutureBuilder<List<mod_card>>(
        future: fetchCards(http.Client()),
        builder: (context, snapshot) {
          if (snapshot.hasError) print(snapshot.error);

          return snapshot.hasData
              ? TitleList(cards: snapshot.data)
//              ? PhotosList(cards: snapshot.data)
              : Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}

List<mod_card> parseCards(String responseBody) {
  final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
  return parsed.map<mod_card>((json) => mod_card.fromJson(json)).toList();
}

Future<List<mod_card>> fetchCards(http.Client client) async {
  final response =
      await client.get('https://db.ygoprodeck.com/api/v5/cardinfo.php?num=100');

  return compute(parseCards, response.body);
}

class TitleList extends StatelessWidget {
  final List<mod_card> cards;

  TitleList({Key key, this.cards}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return new ListView.builder(
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        itemCount: cards.length,
        itemBuilder: (context, index) {
          return Card(
            elevation: 8.0,
            margin: new EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
            child: Container(
                decoration:
                    BoxDecoration(color: Color.fromRGBO(64, 75, 96, .9)),
                child: ListTile(
                    contentPadding:
                        EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
                    leading: Container(
                      padding: EdgeInsets.only(right: 12.0),
                      decoration: new BoxDecoration(
                          border: new Border(
                              right: new BorderSide(
                                  width: 1.0, color: Colors.white24))),
                      child: Image.network(
                          cards[index].cardImages[0].imageUrlSmall),
                    ),
                    title: Text(
                      cards[index].name,
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                    subtitle: Row(
                      children: <Widget>[
                        Icon(Icons.linear_scale, color: Colors.yellowAccent),
                        Text(cards[index].race,
                            style: TextStyle(color: Colors.white)),
                      ],
                    ),
                    onTap: () {
                      Scaffold.of(context).showSnackBar(SnackBar(
                        content: Text(cards[index].name),
                        duration: Duration(seconds: 1),
                      ));

                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => Detail(cards[index])),
                      );
                    },
                    trailing: Icon(Icons.keyboard_arrow_right,
                        color: Colors.white, size: 30.0))),
          );
        });
  }
}
