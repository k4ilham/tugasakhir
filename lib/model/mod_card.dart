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