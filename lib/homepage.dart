import 'package:flutter/material.dart';
import 'package:project/FirstPage.dart';
import 'ARPage.dart';
import 'TripPage.dart';

class Homepage extends StatefulWidget {
  @override
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
          FirstPage(),
          TripPage(),
          ARPage(),



        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _exactlyPageNum,
        selectedItemColor: Colors.green,
        unselectedItemColor: Colors.black,
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home Page'),
          BottomNavigationBarItem(icon: Icon(Icons.location_on), label: 'Trip Page'),
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