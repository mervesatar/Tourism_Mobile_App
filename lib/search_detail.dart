import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class SearchDetail extends StatefulWidget {
  final String category;
  
 SearchDetail({@required this.category});



  @override
  _SearchDetailState createState() => _SearchDetailState(category);
}

class _SearchDetailState extends State<SearchDetail> {
  
   final String category;
     _SearchDetailState(this.category);


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("$category"),),
      
    );
  }
}