import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:geocoding/geocoding.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'dart:async';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:google_place/google_place.dart' as gp;
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'authentication.dart';
import 'login.dart';



class TripInfoPage extends StatefulWidget {
  final String tour_name;
  final double tour_rate;
  final double rate_number;

  TripInfoPage({@required this.tour_name, this.tour_rate, this.rate_number});
  AuthenticationService autService = new AuthenticationService();
  @override
  _TripInfoPageState createState() => _TripInfoPageState(tour_name,tour_rate,rate_number);
}

class _TripInfoPageState extends State<TripInfoPage> {
  final tour_name;
  final double tour_rate;
  final double rate_number;


  _TripInfoPageState(this.tour_name,this.tour_rate,this.rate_number);
  reviews temprev = new reviews();
  placeID tempid = new placeID();
  Location temploc = new Location();
  List<placeID> ffpID;
  List<reviews> ffr;
  List<Location> ffl;
  List<placeID> placeIDs = new List();
  Future<List<placeID>> getPlaceID(String query) async {
    String link =
        "https://maps.googleapis.com/maps/api/place/textsearch/json?query=$query&key=AIzaSyCA3b6uYvyVpMxZZiAnyvmebNA7tXcMXTs";
    var response = await http.get(Uri.parse(link));
    Map<String, dynamic> jsonData = jsonDecode(response.body);
    //print("this is json Data $jsonData");
    jsonData["results"].forEach((element) {
      // print(element.toString());
      placeID placeid = new placeID();
      placeid = placeID.fromMap(element);
      placeIDs.add(placeid);
    });
    return placeIDs;
  }

  List<reviews> reviewsList = new List();
  Future<List<reviews>> getReview(String query) async {
    String link =
        "https://maps.googleapis.com/maps/api/place/details/json?place_id=$query&key=AIzaSyCA3b6uYvyVpMxZZiAnyvmebNA7tXcMXTs";
    var response = await http.get(Uri.parse(link));
    Map<String, dynamic> jsonData = jsonDecode(response.body);
    jsonData["result"]["reviews"].forEach((element) {
      reviews review = new reviews();
      review = reviews.fromMap(element);

      reviewsList.add(review);


      print(review.author_name);
      print(review.text);
    });
    return reviewsList;
  }

  gp.GooglePlace googlePlace;
  List<Location> locations;
  Future<List<Location>> getList(String query) async {
    locations = await locationFromAddress(query);
    print(locations);
    return locations;
  }

  @override
  bool a;
  void initState() {
    a=true;
    String apiKey = DotEnv().env['AIzaSyCA3b6uYvyVpMxZZiAnyvmebNA7tXcMXTs'];
    googlePlace = gp.GooglePlace(apiKey);
    super.initState();
    getList(tour_name);
    ffpID = [tempid];
    ffr = [temprev];
    ffl = [temploc];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: <Widget>[
          FlatButton(
            textColor: Colors.white,
            onPressed: ()async {
              var temp = await FirebaseFirestore.instance
                  .collection('users').doc(Login.newUser.id).collection('recent_trips')
                  .get();

              temp.docs.forEach((doc) {
                if (doc["tour_name"] == tour_name) {
                  setState(() {
                    a=false;
                  });
                }
              });
              if(a){
                TripInfoPage()
                    .autService
                    .addtoRecentTours(
                    tour_name, tour_rate, rate_number
                )
                    .then((value) {
                }).catchError((Error) {
                  print(Error);
                });}
            },
            child: Text("Take the Tour"),
            shape: CircleBorder(side: BorderSide(color: Colors.transparent)),
          ),
        ],

        backgroundColor: Colors.blue,
        title: Text(
          "${tour_name}",
          style: new TextStyle(
            fontSize: 25,
            fontWeight: FontWeight.bold,
            fontFamily: 'Satisfy',
          ),
        ),
      ),

        body: StreamBuilder(
          stream: FirebaseFirestore.instance.collection('tours').doc(tour_name).collection('locations').snapshots(),
          builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (!snapshot.hasData) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }

            return ListView(

              children: snapshot.data.docs.map((document) {
                return Column(
                  children: [
                    ListTile(
                      title: Text(document['location_name']),
                      trailing: Row(mainAxisSize: MainAxisSize.min, children: [
                        ElevatedButton(
                          style: ButtonStyle(
                            backgroundColor:
                            MaterialStateProperty.all(Colors.lightBlue),
                          ),
                          child: Text('Go To Map'),
                          onPressed: () async {
                            if (ffl.isEmpty == false) {
                              ffl.clear();
                            } else {}
                            ffl = await getList(document['location_name']);

                            print(ffl[0].latitude);
                            print(ffl[0].longitude);
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => MapSample(
                                      long: ffl[0].longitude,
                                      lat: ffl[0].latitude,
                                    )));
                          },
                        ),
                        ElevatedButton(
                          style: ButtonStyle(
                            backgroundColor:
                            MaterialStateProperty.all(Colors.lightBlue),
                          ),
                          child: Text('Comments'),
                          onPressed: () async {
                            if (ffpID.isEmpty == false) {
                              ffpID.clear();
                            } else {}
                            if (ffr.isEmpty == false) {
                              ffr.clear();
                            } else {}
                            ffpID = await getPlaceID(document['location_name']);
                            print(ffpID[0].place_id);
                            ffr = await getReview(ffpID[0].place_id);
                            showModalBottomSheet<void>(
                              context: context,
                              builder: (BuildContext context) {
                                return SingleChildScrollView(
                                  physics: const NeverScrollableScrollPhysics(),
                                  child: Column(
                                    children: [
                                      new ListTile(
                                          leading: IconButton(
                                              icon: Icon(Icons.arrow_back,
                                                  color: Colors.lightBlue),
                                              onPressed: () {
                                                ffr.clear();
                                                ffpID.clear();
                                                Navigator.of(context).pop();
                                              }),
                                          title: Center(child: Text("Comments"))),
                                      Container(
                                        height: 250,
                                        width: 500,
                                        child: ListView.separated(
                                          padding: EdgeInsets.all(20.0),
                                          itemCount: ffr.length,
                                          separatorBuilder:
                                              (BuildContext context, int index) =>
                                              Divider(
                                                color: Colors.lightBlue,
                                                thickness: 3,
                                              ),
                                          itemBuilder:
                                              (BuildContext context, int ind) {
                                            return ListTile(
                                              title: Text(ffr[ind].author_name),
                                              subtitle: Text(ffr[ind].text),
                                            );
                                          },
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              },
                            );
                          },
                        ),
                      ]),
                      onTap: () {},
                    ),
                  ],
                );

              }).toList(),
            );
          },
        ),
    );
  }
}

class MapSample extends StatefulWidget {
  final double long, lat;
  MapSample({Key key, this.long, this.lat}) : super(key: key);

  @override
  State<MapSample> createState() => MapSampleState(long, lat);
}

class MapSampleState extends State<MapSample> {
  MapSampleState(this.long, this.lat);
  final double long, lat;

  Completer<GoogleMapController> _controller = Completer();

  double long2;
  double lat2;
  CameraPosition _kGooglePlex;
  CameraPosition _kLake;
  @override
  void initState() {
    long2 = long;
    lat2 = lat;
    _kGooglePlex = CameraPosition(
      target: LatLng(lat2, long2),
      zoom: 14.4746,
    );
    _kLake = CameraPosition(
        bearing: 192.8334901395799,
        target: LatLng(lat2, long2),
        tilt: 59.440717697143555,
        zoom: 19.151926040649414);
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: GoogleMap(
        mapType: MapType.hybrid,
        initialCameraPosition: _kGooglePlex,
        onMapCreated: (GoogleMapController controller) {
          _controller.complete(controller);
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _goToTheLake,
        label: Text('Zoom'),
        icon: Icon(Icons.zoom_in),
      ),
    );
  }

  Future<void> _goToTheLake() async {
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(_kLake));
  }

  Set<Marker> _createMarker(String marker, double lat, double long) {
    return {
      Marker(
        markerId: MarkerId(marker),
        position: LatLng(lat, long),
      ),
    };
  }
}

class placeID {
  String place_id;
  placeID({
    this.place_id,
  });
  factory placeID.fromMap(Map<String, dynamic> parsedJson) {
    return placeID(
      place_id: parsedJson["place_id"],
    );
  }
}

class reviews {
  String author_name;
  String text;
  reviews({this.author_name, this.text});
  factory reviews.fromMap(Map<String, dynamic> parsedJson) {
    return reviews(
      author_name: parsedJson["author_name"],
      text: parsedJson["text"],
    );
  }
}

