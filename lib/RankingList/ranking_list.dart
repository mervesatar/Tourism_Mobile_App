import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'block.dart';

class RankingList extends StatefulWidget {
  @override
  _RankingListState createState() => _RankingListState();
}

class _RankingListState extends State<RankingList> {
  MovieListBloc movieListBloc;

  ScrollController controller = ScrollController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    movieListBloc = MovieListBloc();
    movieListBloc.fetchFirstList();
    controller.addListener(_scrollListener);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("The Winners of The Week"),),
      body: StreamBuilder<List<DocumentSnapshot>>(
        stream: movieListBloc.movieStream,
        builder: (context, snapshot) {
          if (snapshot.data != null) {
            return ListView.builder(
              itemCount: snapshot.data.length,
              shrinkWrap: true,
              controller: controller,
              itemBuilder: (context, index) {
                return Card(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ListTile(
                      leading: CircleAvatar(
                          child: Text(snapshot.data[index]["point"].toString())),
                      title: Text(snapshot.data[index]["name"]+" "+snapshot.data[index]["surname"]),
                    ),
                  ),
                );
              },
            );
          } else {
            return CircularProgressIndicator();
          }
        },
      ),
    );
  }

  void _scrollListener() {
    if (controller.offset >= controller.position.maxScrollExtent &&
        !controller.position.outOfRange) {
      print("at the end of list");
      movieListBloc.fetchNextMovies();
    }
  }
}
