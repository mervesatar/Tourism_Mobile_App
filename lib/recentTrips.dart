import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:project/MainPage.dart';
import 'package:project/login.dart';
import 'package:project/rating.dart';
import 'authentication.dart';
import 'package:get/get.dart';

class RecentTrips extends StatefulWidget {
  AuthenticationService autService = new AuthenticationService();
  @override
  _RecentTripsState createState() => _RecentTripsState();
}

class _RecentTripsState extends State<RecentTrips> {
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
        leading: Builder(
          builder: (BuildContext context) {
            return IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => MainPage()));
              },
            );
          },
        ),
        backgroundColor: Colors.blue,
        title: Text(
          'recent_trips'.tr,
          style: new TextStyle(
            fontSize: 25,
            fontWeight: FontWeight.bold,
            fontFamily: 'Satisfy',
          ),
        ),
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('users')
            .doc(Login.newUser.id)
            .collection('recent_trips')
            .snapshots(),
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
                          ],
                        )))
                      ],
                    ),
                    elevation: 2.0,
                    margin: EdgeInsets.all(5.0),
                  ),
                  onTap: () {
                    if (!document['is_rated']) {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => Rating(
                                    tour_name: document['tour_name'],
                                    tour_id: document['tour_id'],
                                  )));
                    }
                  },
                ),
              );
            }).toList(),
          );
        },
      ),
    );
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
      onRatingUpdate: (docRate) {
        setState(() {
          _rating = docRate;
        });
      },
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
