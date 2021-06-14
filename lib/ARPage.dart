import 'dart:typed_data';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:arcore_flutter_plugin/arcore_flutter_plugin.dart';
import 'package:flutter/services.dart';
import 'package:vector_math/vector_math_64.dart' as vector;
import 'package:geolocator/geolocator.dart';

class ARPage extends StatefulWidget {
  final String tour_name;
  ARPage({@required this.tour_name});
  @override
  _ARPageState createState() => _ARPageState(tour_name);
}

class _ARPageState extends State<ARPage> {
  final tour_name;
  List <double> latitude=[];
  List <double> longitude=[];
  List<String> names=[];
  ArCoreController arCoreController;
  _ARPageState(this.tour_name);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blue,
          title: Center(
            child: Text(
              "${tour_name}",
              style: new TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.bold,
                fontFamily: 'Satisfy',
              ),
            ),
          ),
        ),
        body: ArCoreView(
          onArCoreViewCreated: _onArCoreViewCreated,
        ),
      ),
    );
  }

  void _onArCoreViewCreated(ArCoreController controller) {
    arCoreController = controller;

    //_addCylindre1(arCoreController);
    _addCube(arCoreController);
    _addCube2(arCoreController, 0);
    _addCube2(arCoreController, 1);
    _addCube2(arCoreController, 2);
    _addCube2(arCoreController, 3);
  }

  void _addCylindre1(ArCoreController controller) {
    final material = ArCoreMaterial(
      color: Colors.green,
      reflectance: 1.0,
    );
    final cylindre = ArCoreCylinder(
      materials: [material],
      radius: 0.5,
      height: 0.3,
    );
    final node = ArCoreNode(
      shape: cylindre,
      position: vector.Vector3(0.0, -0.5, -2.0),
    );
    controller.addArCoreNode(node);
  }


  void _addCube(ArCoreController controller) async {
    final ByteData textureBytes = await rootBundle.load('images/Anıtkabir.jpg');
    var position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    var lat = position.latitude;
    var long = position.longitude;
    double distanceInMeterslat =
        Geolocator.distanceBetween(lat, 1, 40.9845773, 1);
    double distanceInMeterslong =
        Geolocator.distanceBetween(1, long, 1, 39.7287334);
    if (lat > 40.9845773) {
      double temp = distanceInMeterslat;
      distanceInMeterslat = -temp;
    }
    if (long > 39.7287334) {
      double temp = distanceInMeterslong;
      distanceInMeterslong = -temp;
    }
    final material = ArCoreMaterial(
      color: Color.fromARGB(120, 66, 134, 244),
      metallic: 3.0,
      textureBytes: textureBytes.buffer.asUint8List(),
    );
    final cube = ArCoreCube(
      materials: [material],
      size: vector.Vector3(0.5, 0.5, 0.5),
    );
    final node = await ArCoreNode(
      shape: cube,
      position: vector.Vector3(distanceInMeterslong, 0.5, -distanceInMeterslat),
    );
    controller.addArCoreNode(node);
  }

  void _addCube2(ArCoreController controller,int i) async {
    final ByteData textureBytes = await rootBundle.load('images/$names[i].jpg');
    var position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    var lat = position.latitude;
    var long = position.longitude;
    double distanceInMeterslat =
    Geolocator.distanceBetween(lat, 1, latitude[i], 1);
    double distanceInMeterslong =
    Geolocator.distanceBetween(1, long, 1, longitude[i]);
    if (lat > latitude[i]) {
      double temp = distanceInMeterslat;
      distanceInMeterslat = -temp;
    }
    if (long > longitude[i]) {
      double temp = distanceInMeterslong;
      distanceInMeterslong = -temp;
    }
    final material = ArCoreMaterial(
      color: Color.fromARGB(120, 66, 134, 244),
      metallic: 3.0,
      textureBytes: textureBytes.buffer.asUint8List(),
    );
    final cube = ArCoreCube(
      materials: [material],
      size: vector.Vector3(0.5, 0.5, 0.5),
    );
    final node = await ArCoreNode(
      shape: cube,
      position: vector.Vector3(distanceInMeterslong, 4, -distanceInMeterslat),
    );
    controller.addArCoreNode(node);
  }

  @override
  void dispose() {
    arCoreController.dispose();
    super.dispose();
  }

  void getList() async{

    var temp =
    await FirebaseFirestore.instance.collection('tours').doc(tour_name).collection("locations").get();
      temp.docs.forEach((doc) {
        latitude.add(doc["latitude"]);
        longitude.add(doc["longitude"]);
        names.add(doc["location_name"]);
      });

  }
}
