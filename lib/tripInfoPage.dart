import 'dart:ffi';
import 'dart:typed_data';
import 'package:geocoding/geocoding.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'dart:async';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:google_place/google_place.dart' as gp;
import 'package:http/http.dart' as http;
import 'dart:convert';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await DotEnv().load('.env');
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MyHomePage(),
      theme: new ThemeData(scaffoldBackgroundColor: Colors.orange[50]),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  /*gp.GooglePlace googlePlace;
  Future getList() async {
    List<Location> locations = await locationFromAddress("Ankara");
    print(locations);
  }*/
  List<String> tripCities = ["Ankara", "Istanbul", "Kayseri"];
  List<String> tripDestinations = [
    "Anıtkabir,Medeniyetler Müzesi, Kale, Ankamall",
    "Ayasofya Camii,Kapalı Çarşı,Topkapı Palace,Dolmabahçe Palace",
    "Erciyes Dağı,Kayseri Kalesi,Mazakaland,Mimar Sinan Evi"
  ];

  @override
  void initState() {
    /*String apiKey = DotEnv().env['AIzaSyCA3b6uYvyVpMxZZiAnyvmebNA7tXcMXTs'];
    googlePlace = gp.GooglePlace(apiKey);*/
    super.initState();
    /*getList();*/
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          iconTheme: new IconThemeData(color: Color(0xfffcff3d)),
          backgroundColor: Colors.orange[600],
          title: Text(
            "Tourism Mobile APP",
            style: TextStyle(
                color: Colors.orange[50], fontFamily: 'Courier', fontSize: 26),
          ),
        ),
        body: Container(
          decoration: new BoxDecoration(color: Colors.orange[50]),
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Padding(
            padding: EdgeInsets.all(10),
            child: ListView.separated(
              shrinkWrap: true,
              itemCount: tripCities.length,
              separatorBuilder: (BuildContext context, int index) => Divider(
                color: Colors.orange[600],
                thickness: 3,
              ),
              itemBuilder: (BuildContext context, int index) {
                return ListTile(
                    title: Text(tripCities[index] + " Trip"),

                    onTap: () {
                      /* Navigator.push(
                context,
                MaterialPageRoute(
                builder: (context) => DetailsPage(
                placeId: predictions[index].placeId,
                googlePlace: googlePlace,
                ),
                ),
                );*/

                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => TripPage(
                                cityName: tripCities[index],
                              )));
                    });
              },
            ),
          ),
        ));
  }
}

class TripPage extends StatefulWidget {
  final String cityName;
  TripPage({@required this.cityName});

  @override
  _TripPageState createState() => _TripPageState(cityName);
}

class _TripPageState extends State<TripPage> {
  final cityName;

  _TripPageState(this.cityName);
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

      // getRecipePage(recipeModel.id);

      // print(placeid.place_id);
    });
    return placeIDs;
  }

  List<reviews> reviewsList = new List();
  Future<List<reviews>> getReview(String query) async {
    String link =
        "https://maps.googleapis.com/maps/api/place/details/json?place_id=$query&key=AIzaSyCA3b6uYvyVpMxZZiAnyvmebNA7tXcMXTs";
    var response = await http.get(Uri.parse(link));
    Map<String, dynamic> jsonData = jsonDecode(response.body);
    //print("this is json Data $jsonData");
    jsonData["result"]["reviews"].forEach((element) {
      // print(element.toString());
      reviews review = new reviews();
      review = reviews.fromMap(element);

      reviewsList.add(review);

      // getRecipePage(recipeModel.id);

      print(review.author_name);
      print(review.text);
    });
    return reviewsList;
  }

  List<String> result;
  String tripPoints;

  gp.GooglePlace googlePlace;
  List<Location> locations;
  Future<List<Location>> getList(String query) async {
    locations = await locationFromAddress(query);
    print(locations);
    return locations;
  }

  @override
  void initState() {
    String apiKey = DotEnv().env['AIzaSyCA3b6uYvyVpMxZZiAnyvmebNA7tXcMXTs'];
    googlePlace = gp.GooglePlace(apiKey);
    super.initState();
    getList(cityName);
    ffpID = [tempid];
    ffr = [temprev];
    ffl = [temploc];
    if (cityName == "Ankara") {
      tripPoints =
      "Anıtkabir,Medeniyetler Müzesi,Kurtuluş Savaşı Müzesi,Kuğulu Park";
    } else if (cityName == "Istanbul") {
      tripPoints =
      "Ayasofya Camii,Kapalı Çarşı,Topkapı Palace,Dolmabahçe Palace";
    } else if (cityName == "Kayseri") {
      tripPoints = "Erciyes Dağı,Kayseri Kalesi,Mazakaland,Mimar Sinan Evi";
    }
    result = tripPoints.split(',');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: [
              new Container(
                width: 500,
                height: 250,
                child: ClipRRect(
                    borderRadius: BorderRadius.circular(20.0),
                    child: Image(
                        image: new AssetImage('images/$cityName' + 'Tour.jpg'),
                        fit: BoxFit.cover)),
              ),
              new SizedBox(
                height: 20,
              ),
              new Column(children: <Widget>[
                Text(
                  "$cityName Trip",
                  style: TextStyle(fontSize: 25, color: Colors.orange[600]),
                ),
                Text(
                  "Turkey",
                  style: TextStyle(fontSize: 10, color: Colors.orange[600]),
                ),
                Icon(Icons.location_on, color: Colors.orange[600], size: 10),
              ]),
              new SizedBox(
                width: 20,
              ),
              Divider(
                color: Colors.orange[600],
                thickness: 1,
              ),
              new Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      "Destinations:",
                      style: TextStyle(fontSize: 25, color: Colors.orange[600]),
                    ),
                  ]),
              new Container(
                child: ListView.separated(
                  shrinkWrap: true,
                  itemCount: result.length,
                  separatorBuilder: (BuildContext context, int index) => Divider(
                    color: Colors.orange[600],
                    thickness: 3,
                  ),
                  itemBuilder: (BuildContext context, int index) {
                    return ListTile(
                      title: Text(result[index]),
                      trailing: Row(mainAxisSize: MainAxisSize.min, children: [
                        ElevatedButton(
                          style: ButtonStyle(
                            backgroundColor:
                            MaterialStateProperty.all(Colors.orange[600]),
                          ),
                          child: Text('Go To Map'),
                          onPressed: () async {
                            if (ffl.isEmpty == false) {
                              ffl.clear();
                            } else {}
                            ffl = await getList(result[index]);

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
                            MaterialStateProperty.all(Colors.orange[600]),
                          ),
                          child: Text('Comments'),
                          onPressed: () async {
                            if (ffpID.isEmpty == false) {
                              ffpID.clear();
                            } else {}
                            if (ffr.isEmpty == false) {
                              ffr.clear();
                            } else {}
                            ffpID = await getPlaceID(result[index]);
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
                                                  color: Colors.orange[600]),
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
                                                color: Colors.orange[600],
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
                                  /*child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              mainAxisSize: MainAxisSize.min,
                              children: <Widget>[
                                const Text('Modal BottomSheet'),
                                ElevatedButton(
                                  child: const Text('Close BottomSheet'),
                                  onPressed: () => Navigator.pop(context),
                                )
                              ],
                            ),*/
                                );
                              },
                            );
                          },
                        ),
                      ]),
                      onTap: () {},
                    );
                  },
                ), /*ListTile(
                        title: Text("Kızılay"),
                        onTap: () {
                          print(locations[0].latitude);
                          print(locations[0].longitude);
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => MapSample(
                                        long: locations[0].longitude,
                                        lat: locations[0].latitude,
                                      )));
                        }),*/
              ),
              /*Container(
            child: FutureBuilder(
              future: locationss,
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return Center(
                    child: Icon(
                      Icons.error_outline_sharp,
                      size: 180,
                    ),
                  );
                } else if (snapshot.hasData) {
                  return
                } else
                  return Center(child: CircularProgressIndicator());
              },
            ),
          ),*/
            ],
          ),
        ));
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
