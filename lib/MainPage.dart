  import 'dart:math';

import 'package:barcode_scan_fix/barcode_scan.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geocoding/geocoding.dart';
import 'package:project/RankingList/rankingHomepage.dart';
import 'package:project/RankingList/ranking_list.dart';
import 'package:project/Settings/settings.dart';
import 'package:project/TripPage.dart';
import 'package:project/recentTrips.dart';
import 'package:project/search_trips.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

import 'authentication.dart';
import 'login.dart';
class MainPage extends StatefulWidget {

  AuthenticationService autService = new AuthenticationService();
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  List<Location> locations;
  List<String> inDistance=[];
  String barcode = "";
  @override

  void initState() {
    //getList();
    super.initState();
  }
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
                  width: (MediaQuery.of(context).size.width) / 2.2,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    image: DecorationImage(
                      image: AssetImage('images/qr.jpg'),
                      fit: BoxFit.cover,
                      colorFilter: ColorFilter.mode(
                          Colors.white.withOpacity(0.6), BlendMode.dstATop),
                    ),
                  ),
                  child: MaterialButton(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    onPressed: scan,
                    child: Text(
                      'QR',
                      style: TextStyle(
                        color: Colors.black,
                        fontFamily: 'Satisfy',
                        fontWeight: FontWeight.bold,
                        fontSize: 24,
                      ),
                    ),
                  ),
                ),
                Container(
                  height: (MediaQuery.of(context).size.height) / 6,
                  width: (MediaQuery.of(context).size.width) / 2.5,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    image: DecorationImage(
                      image: AssetImage('images/VisitedLocations.jpg'),
                      fit: BoxFit.cover,
                      colorFilter: ColorFilter.mode(
                          Colors.white.withOpacity(0.6), BlendMode.dstATop),
                    ),
                  ),
                  child: MaterialButton(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    onPressed: (){
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => RankingHomepage()));

                    },
                    child: Text(
                      'Visited Locations',
                      style: TextStyle(
                        color: Colors.black,
                        fontFamily: 'Satisfy',
                        fontWeight: FontWeight.bold,
                        fontSize: 24,
                      ),
                    ),
                  ),
                ),

              ],
            ),
          ],
        ),
      ),
      /*floatingActionButton: FloatingActionButton(
        child:Icon(Icons.star) ,
        backgroundColor: Colors.lightBlue,
        onPressed: (){
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => RankingList()));

        },
      ),*/
    );
  }


  Future scan() async{

    try {
      String barcode = await BarcodeScanner.scan();
      setState(() {
        this.barcode = barcode;
        print(this.barcode);
        firebase(barcode);

        _launchURL(barcode);
      });
    } on PlatformException catch (e) {
      if (e.code == BarcodeScanner.CameraAccessDenied) {
        setState(() {
          this.barcode = 'The user did not grant the camera permission!';
        });
      } else {
        setState(() => this.barcode = 'Unknown error: $e');
      }
    } on FormatException{
      setState(() => this.barcode = 'null (User returned using the "back"-button before scanning anything. Result)');
    } catch (e) {
      setState(() => this.barcode = 'Unknown error: $e');
    }
  }


  void _launchURL(_url) async =>
      await canLaunch(_url) ? await launch(_url) : throw 'Could not launch $_url';

  void firebase(String barcode) async {
    print(barcode);
    print("firebase");
    bool a=true;

    var temp = await FirebaseFirestore.instance
        .collection('users')
        .doc(Login.newUser.id)
        .collection('QR')
        .get();
    print("firebase2");

    temp.docs.forEach((doc) {
      if (doc["url"] == barcode) {
        setState(() {
          a = false;
          print("firebase3");
        });
      }
    });

    if (a) {
      print("firebase4");

      firebase2(barcode);

    }
  }

  void firebase2(String barcode) async{
    String name="";
    String category="";
    int point=0;
    var temp2 = await FirebaseFirestore.instance.collection('point_of_interests').get();
    Login lg = new Login();
    lg.getLocation();
    double longitude =current_.longitude;
    double latitude =current_.latitude;
    temp2.docs.forEach((doc) async {


      if (doc["url"] == barcode) {
        setState(() {
          name=doc["name"];
          category=doc["category"];
          point =doc["point"];
        });
      }
    });
    await getList(name);

    print("name: $name");
    print("category: $category");
    print ("point: $point");


    if(distance(longitude,latitude,locations[0].longitude,locations[0].latitude)<0.5){
      MainPage()
          .autService
          .addToQR(category, name, point,barcode)
          .then((value) {print("firebase5");})
          .catchError((Error) {
        print(Error);
      });
      MainPage().autService.updateUserInfo2(point).then((value) {print("firebase6");})
          .catchError((Error) {
        print(Error);
      });
   }
    else{
      print("Your not in the locations");
    }
  }
  Future<List<Location>> getList(String query) async {
    locations = await locationFromAddress(query);
    print(locations);
    return locations;
  }
  double distance(double a1, double a2, double b1, double b2){
    double d1 = (a1-b1)*(a1-b1);
    double d2 = (a2-b2)*(a2-b2);
    double dis = sqrt(d1+d2);
    return dis;
  }





}