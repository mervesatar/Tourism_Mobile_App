import 'package:flutter/material.dart';
import 'package:project/RankingList/RecentLocations.dart';
import 'package:project/RankingList/ranking_list.dart';


class RankingHomepage extends StatefulWidget {
  @override

  _RankingHomepageState createState() => _RankingHomepageState();
}

class _RankingHomepageState extends State<RankingHomepage> {
  int _exactlyPageNum = 0;
  PageController pageControll;

  @override
  void initState() {
    super.initState();
    pageControll = PageController();
  }

  @override
  void dispose() {
    pageControll.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        physics: NeverScrollableScrollPhysics(),
        onPageChanged: (pageNo) {
          setState(() {
            _exactlyPageNum = pageNo;
          });
        },
        controller: pageControll,
        children: <Widget>[
          RankingLocations(),
          RankingList(

          ),
          /* ARPage(
            tour_name: Homepage.tour_name,
          ),*/
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _exactlyPageNum,
        selectedItemColor: Colors.green,
        unselectedItemColor: Colors.black,
        items: [
          BottomNavigationBarItem(
              icon: Icon(Icons.location_on_sharp), label: 'Recent Locations'),
          BottomNavigationBarItem(icon: Icon(Icons.star), label: 'Ranking List'),
        ],
        onTap: (currentPageNumber) {
          setState(() {
            pageControll.jumpToPage(currentPageNumber);
          });
        },
      ),
    );
  }
}
