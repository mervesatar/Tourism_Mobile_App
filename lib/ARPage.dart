import 'dart:typed_data';
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
    _addCylindre(arCoreController);
    _addCylindre1(arCoreController);
    //_addSphere(arCoreController);
    _addCube(arCoreController);
  }

  void _addCylindre(ArCoreController controller) async {
    var position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    var lat = position.latitude;
    var long = position.longitude;
    double distanceInMeterslat =
        Geolocator.distanceBetween(lat, 1, 36.609567, 1);
    double distanceInMeterslong =
        Geolocator.distanceBetween(1, long, 1, 34.314801);
    if (lat > 36.609567) {
      double temp = distanceInMeterslat;
      distanceInMeterslat = -temp;
    }
    if (long > 34.314801) {
      double temp = distanceInMeterslong;
      distanceInMeterslong = -temp;
    }
    final material = ArCoreMaterial(
      color: Colors.red,
      reflectance: 1.0,
    );
    final cylindre = ArCoreCylinder(
      materials: [material],
      radius: 0.5,
      height: 0.3,
    );
    final node = await ArCoreNode(
      shape: cylindre,
      position: vector.Vector3(distanceInMeterslong, 1.5, -distanceInMeterslat),
    );
    controller.addArCoreNode(node);
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

/*
  void _addSphere(ArCoreController controller) {
    final material = ArCoreMaterial(
        color: Color.fromARGB(120, 66, 134, 244));
    final sphere = ArCoreSphere(
      materials: [material],
      radius: 0.1,
    );
    final node = ArCoreNode(
      shape: sphere,
      position: vector.Vector3(0, 0, -1.5),
    );
    controller.addArCoreNode(node);
  }
*/
  void _addCube(ArCoreController controller) async {
    final ByteData textureBytes = await rootBundle.load('images/Anıtkabir.jpg');
    var position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    var lat = position.latitude;
    var long = position.longitude;
    double distanceInMeterslat =
        Geolocator.distanceBetween(lat, 1, 38.6555274, 1);
    double distanceInMeterslong =
        Geolocator.distanceBetween(1, long, 1, 35.4911245);
    if (lat > 38.6555274) {
      double temp = distanceInMeterslat;
      distanceInMeterslat = -temp;
    }
    if (long > 35.4911245) {
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
      position: vector.Vector3(-0.5, 0.5, -3.5),
    );
    controller.addArCoreNode(node);
  }

  @override
  void dispose() {
    arCoreController.dispose();
    super.dispose();
  }
}
