

import 'package:flutter/material.dart';
import 'package:project/TripPage.dart';

class MainPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children:<Widget>[
            Padding(
              padding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
              child: Container(
                height: (MediaQuery.of(context).size.height) / 7,
                width: (MediaQuery.of(context).size.width) / 1.2,
                child: Center(
                    child: Text(
                      'TourMe',
                      style: TextStyle(
                        fontFamily: 'Merienda',
                        fontSize: 70,
                        foreground: Paint()
                        //..style = PaintingStyle.stroke
                        //..strokeWidth = 3
                          ..color = Colors.lightBlue,
                      ),
                    )),
              ),
            ),
            Center(
              child: Text('Your Personal Tour Guide!', style: TextStyle(
                fontFamily: 'Satisfy',
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),),
            ),
            SizedBox(
              height: (MediaQuery.of(context).size.height) / 25,
            ),
            SizedBox(
              height: (MediaQuery.of(context).size.height) / 25,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children:<Widget> [
                Container(
                  height: (MediaQuery.of(context).size.height) / 4,
                  width: (MediaQuery.of(context).size.width) / 2.5,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    image: DecorationImage(
                      image: AssetImage('images/button1.jpg'),
                      fit: BoxFit.cover,
                      colorFilter: ColorFilter.mode(
                          Colors.white.withOpacity(0.6), BlendMode.dstATop),
                    ),
                  ),
                  child: FlatButton(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Text('Recommended Trips',
                      style: TextStyle(
                        color: Colors.black,
                        fontFamily: 'Satisfy',
                        fontWeight: FontWeight.bold,
                        fontSize: 24,
                      ),
                    ),
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => TripPage()));
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
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    image: DecorationImage(
                      image: AssetImage('images/button2.jpg'),
                      fit: BoxFit.cover,
                      colorFilter: ColorFilter.mode(
                          Colors.white.withOpacity(0.6), BlendMode.dstATop),
                    ),
                  ),
                  child: FlatButton(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Text('Recent Trips',
                      style: TextStyle(
                        color: Colors.black,
                        fontFamily: 'Satisfy',
                        fontWeight: FontWeight.bold,
                        fontSize: 24,
                      ),
                    ),
                    onPressed: () {
                      // Navigator.push(
                      //     context,
                      //     MaterialPageRoute(
                      //         builder: (context) => RecTrips()));
                    },
                  ),
                ),
              ],
            ),
            SizedBox(
              height: (MediaQuery.of(context).size.height) / 25,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children:<Widget> [
                Container(
                  height: (MediaQuery.of(context).size.height) / 4,
                  width: (MediaQuery.of(context).size.width) / 2.5,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    image: DecorationImage(
                      image: AssetImage('images/button3.jpg'),
                      fit: BoxFit.cover,
                      colorFilter: ColorFilter.mode(
                          Colors.white.withOpacity(0.6), BlendMode.dstATop),
                    ),
                  ),
                  child: FlatButton(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Text('Search Trips',
                      style: TextStyle(
                        color: Colors.black,
                        fontFamily: 'Satisfy',
                        fontWeight: FontWeight.bold,
                        fontSize: 24,
                      ),
                    ),
                    onPressed: () {
                      // Navigator.push(
                      //     context,
                      //     MaterialPageRoute(
                      //         builder: (context) => RecTrips()));
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
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    image: DecorationImage(
                      image: AssetImage('images/button4.jpg'),
                      fit: BoxFit.cover,
                      colorFilter: ColorFilter.mode(
                          Colors.white.withOpacity(0.6), BlendMode.dstATop),
                    ),
                  ),
                  child: FlatButton(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Text('Settings',
                      style: TextStyle(
                        color: Colors.black,
                        fontFamily: 'Satisfy',
                        fontWeight: FontWeight.bold,
                        fontSize: 24,
                      ),
                    ),
                    onPressed: () {
                      // Navigator.push(
                      //     context,
                      //     MaterialPageRoute(
                      //         builder: (context) => RecTrips()));
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
