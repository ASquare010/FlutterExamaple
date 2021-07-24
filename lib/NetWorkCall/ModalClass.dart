import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:http/http.dart' as http;
import '../AppTheme.dart';

//For one
class ModalClass {
  int id;
  String title;
  String url;

  ModalClass(this.id, this.title, this.url);

  ModalClass.fromJson({Map<String, dynamic> map}) {
    this.id = map['id'];
    this.title = map['title'];
    this.url = map['url'];
  }
}

//  for receiving data form server in form of json

//        web/Api    url           ==>              json                  ==>        Map Or List<Map>       ==>                                             ModalClass                                              ==>            Connection
//   "https://json.com/photos/"           get(Uri.parse('$url$count'))            json.decode(res.body)              Class Modal{ Modal(Map){ this.id = Map["id"] ; this.price = Map["price"] };int id ,price;}            200 == response.statusCode

// can not use [var] have to define data type properly  /// like this {List<JsonApi> data;} because of the async and future dart cant guess what will return;

//For two

///Download data
List<JsonApi> jsonApiFromJson(String str) => List<JsonApi>.from(json.decode(str).map((x) => JsonApi.fromJson(x)));

///upload data
String jsonApiToJson(List<JsonApi> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

///Main ModalClass
class JsonApi {
  JsonApi({
    this.albumId,
    this.id,
    this.title,
    this.url,
    this.thumbnailUrl,
  });

  int albumId;
  int id;
  String title;
  String url;
  String thumbnailUrl;

  factory JsonApi.fromJson(Map<String, dynamic> json) => JsonApi(
        albumId: json["albumId"],
        id: json["id"],
        title: json["title"],
        url: json["url"],
        thumbnailUrl: json["thumbnailUrl"],
      );

  Map<String, dynamic> toJson() => {
        "albumId": albumId,
        "id": id,
        "title": title,
        "url": url,
        "thumbnailUrl": thumbnailUrl,
      };
}

/// parsing json to get the body(list) and checking connection;
class Connection {
  //
  static const String url = 'https://jsonplaceholder.typicode.com/photos';

  static Future<List<JsonApi>> getData() async {
    try {
      final response = await http.get(Uri.parse(url));
      if (200 == response.statusCode) {
        return jsonApiFromJson(response.body);
      } else {
        return [];
      }
    } catch (e) {
      return [];
    }
  }
//
}

class ListViewCard extends StatefulWidget {
  final String imageLink, title, description;
  final num price;
  final Function onTap;

  ListViewCard(
      {this.imageLink = 'https://www.hp.com/us-en/shop/app/assets/images/uploads/prod/25-best-hd-wallpapers-laptops159561982840438.jpg',
      this.price = 0,
      this.title = "Ice Zoo",
      this.description = "50-Min Cables Aqua Park",
      this.onTap});

  @override
  _ListViewCardState createState() => _ListViewCardState();
}

class _ListViewCardState extends State<ListViewCard> {
  double _locationRating = 3.5;
  int _amountOfRatings = 53,_afterDiscountPrice = 2;
  bool _isTrending = true, _isDiscount = true;
  String _location = "Location of the Place";

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: InkWell(
        borderRadius: BorderRadius.circular(20),
        splashColor: white,
        onTap: widget.onTap,
        child: Ink(
          padding: EdgeInsets.all(8),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: white,
          ),
          child: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Ink(
                    width: MediaQuery.of(context).size.width * 0.95,
                    height: MediaQuery.of(context).size.width * 0.55,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        image: DecorationImage(image: NetworkImage(widget.imageLink), fit: BoxFit.cover)),
                  ),
                ),
                _isTrending
                    ? Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 2),
                        child: Row(
                          children: [
                            Icon(
                              Icons.trending_up,
                              color: blue,
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 3),
                              child: Text(
                                "Trending",
                                style: TextStyle(color: blue, fontWeight: FontWeight.bold),
                              ),
                            )
                          ],
                        ),
                      )
                    : Container(),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 2),
                  child: Text(
                    widget.title,
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22, color: purple),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 2),
                  child: Text(_location, style: TextStyle(color: darkGrey)),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 2),
                  child: Row(
                    children: [
                      Text(
                        "$_locationRating",
                        style: TextStyle(color: darkGrey),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                        child: RateBar(_locationRating),
                      ),
                      Text(
                        "$_amountOfRatings People Rated",
                        style: TextStyle(color: purple.withOpacity(0.5)),
                      ),
                    ],
                  ),
                ),
                _isDiscount
                    ? Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 2),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              "\$${widget.price} ",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20,
                                  color: grey,
                                  decoration: TextDecoration.lineThrough),
                            ),
                            Text(
                              "\$$_afterDiscountPrice",
                              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20, color: green),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 8),
                              child: Container(
                                padding: EdgeInsets.all(2),
                                decoration: BoxDecoration(
                                    color: green.withOpacity(0.15), borderRadius: BorderRadius.circular(4)),
                                child: Text("\%${((_afterDiscountPrice / widget.price) * 100).toInt()} OFF",
                                    style: TextStyle(fontWeight: FontWeight.bold, color: green, fontSize: 11)),
                              ),
                            )
                          ],
                        ),
                      )
                    : Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 2),
                        child: Text(
                          "\$$_afterDiscountPrice",
                          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20, color: green),
                        ),
                      ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 2),
                  child: Text(widget.description, style: TextStyle(color: darkGrey)),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class RateBar extends StatelessWidget {
  final double _rating;

  const RateBar(this._rating);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: RatingBarIndicator(
        rating: _rating,
        unratedColor: grey.withOpacity(0.4),
        itemBuilder: (context, index) => Icon(
          Icons.star,
          color: yellow,
        ),
        itemCount: 5,
        itemSize: 14.0,
        direction: Axis.horizontal,
      ),
    );
  }
}
