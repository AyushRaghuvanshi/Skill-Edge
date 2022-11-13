import 'package:flutter/material.dart';
import 'package:skilledge/screens/BrowsePage/home.dart';
import 'package:skilledge/screens/BrowsePage/searchCard.dart';
import 'package:skilledge/screens/Screens/Search.dart';
import 'package:skilledge/screens/Screens/cart.dart';
import 'package:skilledge/screens/Screens/courses.dart';
import 'package:skilledge/screens/Screens/home.dart';
import 'package:skilledge/screens/Screens/profile.dart';

class BrowseDash extends StatefulWidget {
  const BrowseDash({super.key});

  @override
  State<BrowseDash> createState() => _BrowseDashState();
}

class _BrowseDashState extends State<BrowseDash> {
  int screen_index = 0;

  Widget switchPage() {
    switch (screen_index) {
      case 0:
        return HomeScreenBrowse(
          gotosearch: () {
            setState(() {
              screen_index = 1;
            });
          },
        );

      case 1:
        return SearchPageBrowse();

      default:
        HomeScreenBrowse(
          gotosearch: () {},
        );
        return HomeScreenBrowse(
          gotosearch: () {},
        );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: switchPage(),
      bottomNavigationBar: BottomNavigationBar(
          onTap: ((value) {
            setState(() {
              screen_index = value;
            });
          }),
          selectedItemColor: Color(0xFF01C5A6),
          showUnselectedLabels: true,
          unselectedItemColor: Colors.grey,
          currentIndex: screen_index,
          items: [
            BottomNavigationBarItem(label: 'Home', icon: Icon(Icons.home)),
            BottomNavigationBarItem(
                label: 'Search', icon: Icon(Icons.search_rounded)),
          ]),
    );
  }
}
