import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:project/recentTrips.dart';
import 'package:rating_dialog/rating_dialog.dart';
import 'login.dart';
import 'authentication.dart';


class Rating extends StatefulWidget {
  final String tour_name;
  final String tour_id;

  Rating({@required this.tour_name,this.tour_id});
  AuthenticationService autService = new AuthenticationService();
  @override
  _RatingState createState() => _RatingState(tour_name,tour_id);
}

class _RatingState extends State<Rating> {
  final String tour_name;
  final String tour_id;

  _RatingState(this.tour_name,this.tour_id);


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.teal[50],
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text('${tour_name} Rating'),
        automaticallyImplyLeading: false,
      ),
      body: Container(
        child: Center(
          child: MaterialButton(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0)),
            color: Colors.cyan,
            padding: EdgeInsets.only(left: 30,right: 30),
            child: Text('Rate ${tour_name}',style: TextStyle
              (color: Colors.white,fontSize: 15),
            ),
            onPressed: _showRatingAppDialog,
          ),
        ),
      ),
    );

  }


  void _showRatingAppDialog() {
    final _ratingDialog = RatingDialog(
      ratingColor: Colors.amber,
      title: '${tour_name} Rating',
      message: 'Rate this trip',
      image: Image.asset(
        'images/devs.jpg',
        height: 100,
      ),
      submitButton: 'Submit',
      onCancelled: () => print('cancelled'),
      onSubmitted: (response) async {
        double rate =response.rating.toDouble();

        double number;
        Rating()
            .autService
            .updateIsRated(
            tour_id,true
        )
            .then((value) {
        }).catchError((Error) {
          print(Error);
        });

        var temp = await FirebaseFirestore.instance
            .collection('tours')
            .get();
        temp.docs.forEach((element) {
          setState(() {
              if(element['tour_name']==tour_name){
                rate+=element['tour_rate'].toDouble();
                number=element['rate_number'].toDouble()+1;
              }
          });
        });
        Rating()
            .autService
            .updateRating(
            tour_name,rate,number
        )
            .then((value) {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => RecentTrips()));

        }).catchError((Error) {
          print(Error);
        });

      },
    );

    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (context) => _ratingDialog,
    );
  }

}