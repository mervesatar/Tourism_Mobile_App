import 'dart:async';
import 'package:barcode_scan_fix/barcode_scan.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:url_launcher/url_launcher.dart';

import 'MainPage.dart';
import 'authentication.dart';
import 'login.dart';

void main() {
  runApp(new QR());
}

class QR extends StatefulWidget {
  AuthenticationService autService = new AuthenticationService();
  @override
  _QRState createState() => new _QRState();
}

class _QRState extends State<QR> {
  String barcode = "";

  @override
  initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return
      new Scaffold(
          appBar: new AppBar(
            leading: IconButton(
                icon: Icon(Icons.arrow_back),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => MainPage()),
                  );
                }),
            title: new Text('QR Page'),
          ),
          body: Center(
            child: InkWell(
              child: new Container(
                child: new MaterialButton(
                    onPressed: scan, child: new Text("Scan")),
                padding: const EdgeInsets.all(8.0),
              ),
            ),
          ));

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
    temp2.docs.forEach((doc) {
      if (doc["url"] == barcode) {
        setState(() {
          name=doc["name"];
          category=doc["category"];
          point =doc["point"];
        });
      }
    });

    print("name: $name");
    print("category: $category");
    print ("point: $point");
    QR()
        .autService
        .addToQR(category, name, point,barcode)
        .then((value) {print("firebase5");})
        .catchError((Error) {
      print(Error);
    });
    QR().autService.updateUserInfo2(point).then((value) {print("firebase6");})
        .catchError((Error) {
      print(Error);
    });
  }
}