import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:project/login.dart';
import 'package:project/search_trips.dart';
import 'package:get/get.dart';

import 'homepage.dart';
import 'dart:math';
import 'package:geocoding/geocoding.dart';
import 'login.dart';
class SearchDetail extends StatefulWidget {
  final String category;
  static List<String> tours = [];
  static List<double> rates = [];
  static List<double> rate_number = [];
  static int length = 0;
  static bool ready = false;

  SearchDetail({@required this.category});

  @override
  _SearchDetailState createState() => _SearchDetailState(category);
}

class _SearchDetailState extends State<SearchDetail> {
  final String category;

  _SearchDetailState(this.category);
  List<Location> locations;
  List<String> inDistance=[];
  @override
  void initState() {
    getList();
    if(category=="Recommended"){
     // getList2();
    }

    super.initState();
  }

  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: () {
                SearchDetail.ready = false;
                SearchDetail.length = 0;
                SearchDetail.rates = [];
                SearchDetail.tours = [];
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => SearchTrips()),
                );
              }),
          title: Text("$category".tr.toUpperCase()),
        ),
        body: SearchDetail.ready
            ? ListView.builder(
                itemCount: SearchDetail.length,
                itemBuilder: (context, index) => InkWell(
                      child: Card(
                        child: new Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            new Image.asset(
                              'images/${SearchDetail.tours[index]}.jpg',
                              fit: BoxFit.fill,
                              width: 150,
                              height: 150,
                            ),
                            new Expanded(
                                child: SearchDetail.tours[index]
                                        .contains("Tour")
                                    ? new Column(
                                        children: <Widget>[
                                          new Text(
                                            "${SearchDetail.tours[index]}\n",
                                            style: new TextStyle(
                                              fontSize: 20.0,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          _ratingBar(SearchDetail.rates[index]),
                                        ],
                                      )
                                    : new Center(
                                        child: Center(
                                          child: new Text(
                                            "${SearchDetail.tours[index]}\n",
                                            style: new TextStyle(
                                              fontSize: 22.0,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                      ))
                          ],
                        ),
                        elevation: 2.0,
                        margin: EdgeInsets.all(5.0),
                      ),
                      onTap: () {
                        if (SearchDetail.tours[index].contains("Tour")) {
                          Homepage.tour_name = SearchDetail.tours[index];
                          double rate = SearchDetail.rate_number[index] *
                              SearchDetail.rates[index];
                          Homepage.tour_rate = rate;
                          Homepage.rate_number =
                              SearchDetail.rate_number[index];
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => Homepage()));
                        }
                        ;
                      },
                    ))
            : Center(child: CircularProgressIndicator()));
  }
  double distance(double a1, double a2, double b1, double b2){
    double d1 = (a1-b1)*(a1-b1);
    double d2 = (a2-b2)*(a2-b2);
    double dis = sqrt(d1+d2);
    return dis;
  }

  Future<List<Location>> getList2(String query) async {
    locations = await locationFromAddress(query);
    print(locations);
    return locations;
  }
  Future<List> getList() async {
    var temp = await FirebaseFirestore.instance.collection('tours').get();

    var temp2 =
        await FirebaseFirestore.instance.collection('point_of_interests').get();

    List<String> tours = [];
    if (category == "Highly Rated Tours") {
      temp.docs.forEach((doc) {
        double ratings = doc["tour_rate"].toDouble();
        double rate_number = doc["rate_number"].toDouble();
        double rate = ratings / rate_number;
        if (rate >= 4) {
          setState(() {
            SearchDetail.tours.add(doc["tour_name"]);
            SearchDetail.rates.add(rate);
            SearchDetail.rate_number.add(rate_number);
            SearchDetail.length++;
            tours.add(doc["tour_name"]);
          });
        }
      });
    } else if (category == "Recommended") {
      temp.docs.forEach((doc) async {

        if (doc["tour_category"] == Login.newUser.interest) {
          double ratings = doc["tour_rate"].toDouble();
          double rate_number = doc["rate_number"].toDouble();
          double rate = ratings / rate_number;
          if (rate >= 2) {
            setState(() {
              SearchDetail.tours.add(doc["tour_name"]);
              SearchDetail.rates.add(rate);
              SearchDetail.rate_number.add(rate_number);
              SearchDetail.length++;
              tours.add(doc["tour_name"]);
            });
          }
        }
      });
      List<String> list =[];
      double longitude = current_.longitude;
      double latitude = current_.latitude;
      temp2.docs.forEach((doc) async{
        if (doc["category"] == Login.newUser.interest) {
          double placeLongitude = doc["longitude"];
          print(placeLongitude);
          double placeLatitude = doc["latitude"];
          print(placeLatitude);
          if(distance(longitude, latitude, placeLongitude, placeLatitude)<3){
            setState(() async{
              SearchDetail.tours.add(doc["name"]);
              SearchDetail.length++;
              tours.add(doc["name"]);
            });
          }
        }
      });





      print("Done");
    }

    else {
      temp.docs.forEach((doc) {
        if (doc["tour_category"] == category) {
          double ratings = doc["tour_rate"].toDouble();
          double rate_number = doc["rate_number"].toDouble();
          double rate = ratings / rate_number;
          setState(() {
            SearchDetail.tours.add(doc["tour_name"]);
            SearchDetail.rates.add(rate);
            SearchDetail.rate_number.add(rate_number);
            SearchDetail.length++;
            tours.add(doc["tour_name"]);
          });
        }
      });

      temp2.docs.forEach((doc) {
        if (doc["category"] == category) {
          setState(() {
            SearchDetail.tours.add(doc["name"]);
            SearchDetail.length++;
            tours.add(doc["name"]);
          });
        }
      });
    }
    SearchDetail.ready = true;
    return tours;
  }
}

Widget _ratingBar(double rate) {
  return RatingBar.builder(
    initialRating: rate,
    minRating: 1,
    allowHalfRating: true,
    unratedColor: Colors.amber.withAlpha(50),
    itemCount: 5,
    itemSize: 20.0,
    itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
    itemBuilder: (context, _) => Icon(
      Icons.star,
      color: Colors.amber,
    ),
    /*onRatingUpdate: (docRate) {
        setState(() {
          _rating = docRate;
        });
      },*/
    updateOnDrag: true,
  );
}

