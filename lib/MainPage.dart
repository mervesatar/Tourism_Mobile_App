import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:project/Settings/settings.dart';
import 'package:project/TripPage.dart';
import 'package:project/recentTrips.dart';
import 'package:project/search_trips.dart';
import 'package:get/get.dart';
import 'QRPage.dart';

class MainPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
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
              child: Text(
                'hello_title'.tr,
                style: TextStyle(
                  fontFamily: 'Satisfy',
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(
              height: (MediaQuery.of(context).size.height) / 25,
            ),
            SizedBox(
              height: (MediaQuery.of(context).size.height) / 25,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  height: (MediaQuery.of(context).size.height) / 6,
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
                    child: Text(
                      'available_trips'.tr,
                      style: TextStyle(
                        color: Colors.black,
                        fontFamily: 'Satisfy',
                        fontWeight: FontWeight.bold,
                        fontSize: 24,
                      ),
                    ),
                    onPressed: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => TripPage()));
                    },
                  ),
                ),
                SizedBox(
                  width: (MediaQuery.of(context).size.width) / 25,
                ),
                Container(
                  height: (MediaQuery.of(context).size.height) / 6,
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
                    child: Text(
                      'recent_trips'.tr,
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
                              builder: (context) => RecentTrips()));
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
              children: <Widget>[
                Container(
                  height: (MediaQuery.of(context).size.height) / 6,
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
                    child: Text(
                      'search_trips'.tr,
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
                              builder: (context) => SearchTrips()));
                    },
                  ),
                ),
                SizedBox(
                  width: (MediaQuery.of(context).size.width) / 25,
                ),
                Container(
                  height: (MediaQuery.of(context).size.height) / 6,
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
                    child: Text(
                      'settings'.tr,
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
                              builder: (context) => SettingsOnePage()));
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
              children: <Widget>[
                Container(
                  height: (MediaQuery.of(context).size.height) / 6,
                  width: (MediaQuery.of(context).size.width) / 2.5,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    image: DecorationImage(
                      image: AssetImage('images/qr.jpg'),
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
                      'QR',
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
                              builder: (context) => QR()));
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
