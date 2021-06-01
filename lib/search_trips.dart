
import 'package:flutter/material.dart';
import 'package:project/search_detail.dart';

import 'MainPage.dart';

class SearchTrips extends StatelessWidget {
String category="";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => MainPage()),
            );
          }
      ),title: Text("Search Trips"),),

      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  height: (MediaQuery.of(context).size.height) / 4,
                  width: (MediaQuery.of(context).size.width) / 2.5,

                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(30)),
                    image: DecorationImage(
                      image: AssetImage('images/history.jpg'),
                      fit: BoxFit.cover,
                      colorFilter: ColorFilter.mode(
                          Colors.white.withOpacity(0.6), BlendMode.dstATop),
                    ),
                  ),
                  child: FlatButton(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Text(
                      'History',
                      style: TextStyle(
                        color: Colors.black,
                        fontFamily: 'Satisfy',
                        fontWeight: FontWeight.bold,
                        fontSize: 24,
                      ),
                    ),
                    onPressed: () {
                      category="history";
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => SearchDetail( category: 'history')));
                    },
                  ),
                ),
                SizedBox(
                  width: (MediaQuery.of(context).size.width) / 15,
                ),
                Container(
                  height: (MediaQuery.of(context).size.height) / 4,
                  width: (MediaQuery.of(context).size.width) / 2.5,
                 
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(30)),
                    image: DecorationImage(
                      image: AssetImage('images/fun.jpg'),
                      fit: BoxFit.cover,
                      colorFilter: ColorFilter.mode(
                          Colors.white.withOpacity(0.6), BlendMode.dstATop),
                    ),
                  ),
                  child: FlatButton(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: Text(
                      'Fun',
                      style: TextStyle(
                        color: Colors.black,
                        fontFamily: 'Satisfy',
                        fontWeight: FontWeight.bold,
                        fontSize: 24,
                      ),
                    ),
                    onPressed: () {
                      category="fun";
                       Navigator.push(
                      context,
                          MaterialPageRoute(
                              builder: (context) => SearchDetail( category: 'fun',)));
                              print(category);

                    },
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 10.0,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 23.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,

                children: <Widget>[
                  Container(
                    height: (MediaQuery.of(context).size.height) / 4,
                    width: (MediaQuery.of(context).size.width) / 2.5,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(30)),
                      image: DecorationImage(
                        image: AssetImage('images/food.jpg'),
                        fit: BoxFit.cover,
                        colorFilter: ColorFilter.mode(
                            Colors.white.withOpacity(0.6), BlendMode.dstATop),
                      ),
                    ),
                    child: FlatButton(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: Text(
                        'Food',
                        style: TextStyle(
                          color: Colors.black,
                          fontFamily: 'Satisfy',
                          fontWeight: FontWeight.bold,
                          fontSize: 24,
                        ),
                      ),
                      onPressed: () {
                        category="food";
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => SearchDetail( category: 'food',)));
                      },
                    ),
                  ),
                  SizedBox(
                    width: (MediaQuery.of(context).size.width) / 15,
                  ),
                  Container(
                    height: (MediaQuery.of(context).size.height) / 4,
                    width: (MediaQuery.of(context).size.width) / 2.5,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(30)),
                      image: DecorationImage(
                        image: AssetImage('images/art.jpeg'),
                        fit: BoxFit.cover,
                        colorFilter: ColorFilter.mode(
                            Colors.white.withOpacity(0.6), BlendMode.dstATop),
                      ),
                    ),
                    child: FlatButton(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: Text(
                        'Art',
                        style: TextStyle(
                          color: Colors.black,
                          fontFamily: 'Satisfy',
                          fontWeight: FontWeight.bold,
                          fontSize: 24,
                        ),
                      ),
                      onPressed: () {
                        category="art";
                       Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => SearchDetail(category: 'art',)));
                      },
                    ),
                  ),
                   SizedBox(
                    width: (MediaQuery.of(context).size.width) / 15,
                  ),
                  
                ],
              ),
            ),
            SizedBox(
              height: 10.0,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 23.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,

                children: <Widget>[
                  Container(
                    height: (MediaQuery.of(context).size.height) / 4,
                    width: (MediaQuery.of(context).size.width) / 2.5,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(30)),
                      image: DecorationImage(
                        image: AssetImage('images/five-stars.jpg'),
                        fit: BoxFit.cover,
                        colorFilter: ColorFilter.mode(
                            Colors.white.withOpacity(0.6), BlendMode.dstATop),
                      ),
                    ),
                    child: FlatButton(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: Text(
                        'Highly Rated Tours',
                        style: TextStyle(
                          color: Colors.black,
                          fontFamily: 'Satisfy',
                          fontWeight: FontWeight.bold,
                          fontSize: 24,
                        ),
                      ),
                      onPressed: () {
                        category="highly rated tours";
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => SearchDetail( category: 'Highly Rated Tours',)));
                      },
                    ),
                  ),
                  SizedBox(
                    width: (MediaQuery.of(context).size.width) / 15,
                  ),
                  Container(
                    height: (MediaQuery.of(context).size.height) / 4,
                    width: (MediaQuery.of(context).size.width) / 2.5,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(30)),
                      image: DecorationImage(
                        image: AssetImage('images/ratings.jpg'),
                        fit: BoxFit.cover,
                        colorFilter: ColorFilter.mode(
                            Colors.white.withOpacity(0.6), BlendMode.dstATop),
                      ),
                    ),
                    child: FlatButton(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: Text(
                        'Recommended',
                        style: TextStyle(
                          color: Colors.black,
                          fontFamily: 'Satisfy',
                          fontWeight: FontWeight.bold,
                          fontSize: 21,
                        ),
                      ),
                      onPressed: () {
                        category="recommended";
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => SearchDetail(category: 'Recommended',)));
                      },
                    ),
                  ),
                  SizedBox(
                    width: (MediaQuery.of(context).size.width) / 15,
                  ),

                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}