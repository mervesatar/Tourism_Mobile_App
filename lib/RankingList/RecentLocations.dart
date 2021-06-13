import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:project/login.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

class RankingLocations extends StatefulWidget {
  @override
  List b;
  _RankingLocationsState createState() => _RankingLocationsState();
}

class _RankingLocationsState extends State<RankingLocations> {


  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Text(
          'Recent Locations'.tr,
          style: new TextStyle(
            fontSize: 25,
            fontWeight: FontWeight.bold,
            fontFamily: 'Satisfy',
          ),
        ),
        //automaticallyImplyLeading: false,
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection('users').doc(
            Login.newUser.id).collection("QR").snapshots(),
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
                          'images/${document['name']}.jpg',
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
                                        "${document['name']}\n",
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
                  _launchURL(document["url"]);
                  },
                ),
              );
            }).toList(),
          );
        },
      ),
    );
  }
  void _launchURL(_url) async =>
      await canLaunch(_url) ? await launch(_url) : throw 'Could not launch $_url';
}
