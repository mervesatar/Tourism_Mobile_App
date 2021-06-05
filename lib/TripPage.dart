import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

import 'homepage.dart';
import 'package:get/get.dart';

class TripPage extends StatefulWidget {
  @override
  List b;
  _TripPageState createState() => _TripPageState();
}

class _TripPageState extends State<TripPage> {
  double _rating;

  double _initialRating = 3;

  @override
  void initState() {
    super.initState();

    _rating = _initialRating;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Text(
          'hello_title'.tr,
          style: new TextStyle(
            fontSize: 25,
            fontWeight: FontWeight.bold,
            fontFamily: 'Satisfy',
          ),
        ),
        //automaticallyImplyLeading: false,
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection('tours').snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }

          return ListView(
            children: snapshot.data.docs.map((document) {
              return Container(
                height: 170.0,
                child: InkWell(
                  child: Card(
                    child: new Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        new Image.asset(
                          'images/${document['tour_name']}.jpg',
                          fit: BoxFit.fill,
                          width: 200,
                          height: 300,
                        ),
                        new Expanded(
                            child: new Center(
                                child: new Column(
                          children: <Widget>[
                            new SizedBox(height: 15.0),
                            Center(
                              child: new Text(
                                "${document['tour_name']}\n",
                                style: new TextStyle(
                                  fontSize: 20.0,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            new Text('tour_date'.tr +
                                " : " +
                                "${document['tour_date']}\n"),
                            new Container(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisSize: MainAxisSize.min,
                                children: <Widget>[
                                  document['rate_number'] == 0
                                      ? _ratingBar(
                                          document['tour_rate'].toDouble(), 1)
                                      : _ratingBar(
                                          document['tour_rate'].toDouble(),
                                          document['rate_number'].toDouble())
                                ],
                              ),
                            ),
                          ],
                        )))
                      ],
                    ),
                    elevation: 2.0,
                    margin: EdgeInsets.all(5.0),
                  ),
                  onTap: () {
                    Homepage.tour_name = document['tour_name'];
                    Homepage.tour_rate = document['tour_rate'].toDouble();
                    Homepage.rate_number = document['rate_number'].toDouble();

                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => Homepage()));
                  },
                ),
              );
            }).toList(),
          );
        },
      ),
    );
  }

  Widget _ratingBar(double totalrate, double number) {
    return RatingBar.builder(
      initialRating: totalrate / number,
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

  Widget _heading(String text) => Column(
        children: [
          Text(
            text,
            style: TextStyle(
              fontWeight: FontWeight.w300,
              fontSize: 16.0,
            ),
          ),
          SizedBox(
            height: 16.0,
          ),
        ],
      );
}
