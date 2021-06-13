import 'package:flutter/material.dart';
import 'tripInfoPage.dart';

class Homepage extends StatefulWidget {
  @override
  static String tour_name;
  static double tour_rate;
  static double rate_number;
  static List trip_locations;
  _HomepageState createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
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
          TripInfoPage(
            tour_name: Homepage.tour_name,
            tour_rate: Homepage.tour_rate,
            rate_number: Homepage.rate_number,
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
              icon: Icon(Icons.location_on), label: 'Trip Page'),
          BottomNavigationBarItem(icon: Icon(Icons.camera), label: 'AR Page'),
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
