# Tugas Akhir OSG 4
Eudeka OSG4 - TUGAS AKHIR

# Page Home
<img src="http://kailham.com/android/eudeka/A.png">

# Page Detail
<img src="http://kailham.com/android/eudeka/B.png">

# Page Image Detail
<img src="http://kailham.com/android/eudeka/C.png">

# Notifikasi
<img src="http://kailham.com/android/eudeka/D.png">


# mod_card.dart

<pre><code class="dart">

class mod_card {
  String id;
  String name;
  String type;
  String desc;
  String race;
  String archetype;
  List<CardSets> cardSets;
  List<CardImages> cardImages;
  CardPrices cardPrices;

  mod_card(
      {this.id,
        this.name,
        this.type,
        this.desc,
        this.race,
        this.archetype,
        this.cardSets,
        this.cardImages,
        this.cardPrices});

  mod_card.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    type = json['type'];
    desc = json['desc'];
    race = json['race'];
    archetype = json['archetype'];
    if (json['card_sets'] != null) {
      cardSets = new List<CardSets>();
      json['card_sets'].forEach((v) {
        cardSets.add(new CardSets.fromJson(v));
      });
    }
    if (json['card_images'] != null) {
      cardImages = new List<CardImages>();
      json['card_images'].forEach((v) {
        cardImages.add(new CardImages.fromJson(v));
      });
    }
    cardPrices = json['card_prices'] != null
        ? new CardPrices.fromJson(json['card_prices'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['type'] = this.type;
    data['desc'] = this.desc;
    data['race'] = this.race;
    data['archetype'] = this.archetype;
    if (this.cardSets != null) {
      data['card_sets'] = this.cardSets.map((v) => v.toJson()).toList();
    }
    if (this.cardImages != null) {
      data['card_images'] = this.cardImages.map((v) => v.toJson()).toList();
    }
    if (this.cardPrices != null) {
      data['card_prices'] = this.cardPrices.toJson();
    }
    return data;
  }
}

class CardSets {
  String setName;
  String setCode;
  String setRarity;
  String setPrice;

  CardSets({this.setName, this.setCode, this.setRarity, this.setPrice});

  CardSets.fromJson(Map<String, dynamic> json) {
    setName = json['set_name'];
    setCode = json['set_code'];
    setRarity = json['set_rarity'];
    setPrice = json['set_price'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['set_name'] = this.setName;
    data['set_code'] = this.setCode;
    data['set_rarity'] = this.setRarity;
    data['set_price'] = this.setPrice;
    return data;
  }
}

class CardImages {
  String id;
  String imageUrl;
  String imageUrlSmall;

  CardImages({this.id, this.imageUrl, this.imageUrlSmall});

  CardImages.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    imageUrl = json['image_url'];
    imageUrlSmall = json['image_url_small'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['image_url'] = this.imageUrl;
    data['image_url_small'] = this.imageUrlSmall;
    return data;
  }
}

class CardPrices {
  String cardmarketPrice;
  String tcgplayerPrice;
  String ebayPrice;
  String amazonPrice;

  CardPrices(
      {this.cardmarketPrice,
        this.tcgplayerPrice,
        this.ebayPrice,
        this.amazonPrice});

  CardPrices.fromJson(Map<String, dynamic> json) {
    cardmarketPrice = json['cardmarket_price'];
    tcgplayerPrice = json['tcgplayer_price'];
    ebayPrice = json['ebay_price'];
    amazonPrice = json['amazon_price'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['cardmarket_price'] = this.cardmarketPrice;
    data['tcgplayer_price'] = this.tcgplayerPrice;
    data['ebay_price'] = this.ebayPrice;
    data['amazon_price'] = this.amazonPrice;
    return data;
  }
}

</code></pre>

# main.dart

<pre><code class="dart">

import 'package:flutter/material.dart';
import 'package:tugasakhir/page/home.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final appTitle = 'List Card';

    return MaterialApp(
      title: appTitle,
      theme: new ThemeData(primaryColor: Color.fromRGBO(58, 66, 86, 1.0)),
      home: Home(title: appTitle),
    );
  }
}


</code></pre>

# home.dart

<pre><code class="dart">

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


</code></pre>

# detail.dart

<pre><code class="dart">

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



</code></pre>

# detailimage.dart

<pre><code class="dart">

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


</code></pre>



</code></pre>
# Terima Kasih

Kode : OSG04010
Nama : Ilham Maulana
Email: k4ilham@gmail.com



