import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class TripPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Center(child: Text("Tours", style:new TextStyle(
          fontSize: 30.0,
          fontWeight: FontWeight.bold,
        ),)),
        automaticallyImplyLeading: false,
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
                height: 140.0,

                child: InkWell(
                  child: Card(
                    child: new Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        new Image.asset(
                          'images/${document['tour_name']}.jpg',
                          fit: BoxFit.fill, width: 200,height: 300,),

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
                                    new Text("Tour Rate: ${document['tour_rate']}\n"),
                                    new Text("Tour Date: ${document['tour_date']}")
                                  ],
                                )))
                      ],
                    ),
                    elevation: 2.0,
                    margin: EdgeInsets.all(5.0),


                  ),
                  onTap: (){

                  },
                ),
              );


            }).toList(),
          );
        },
      ),
    );
  }
}