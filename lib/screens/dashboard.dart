import 'package:flutter/material.dart';
import 'package:skilledge/screens/Screens/Search.dart';
import 'package:skilledge/screens/Screens/cart.dart';
import 'package:skilledge/screens/Screens/courses.dart';
import 'package:skilledge/screens/Screens/home.dart';
import 'package:skilledge/screens/Screens/profile.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

bool screentouch = false;

class _DashboardState extends State<Dashboard> {
  int screen_index = 0;

  Widget switchPage() {
    switch (screen_index) {
      case 0:
        return HomeScreen(gotosearch: () {
          setState(() {
            screen_index = 1;
          });
        }, gotoprofile: () {
          setState(() {
            screen_index = 4;
          });
        });

      case 1:
        return SearchPage();

      case 2:
        return CoursesPage();

      case 3:
        return CartPage();

      case 4:
        return ProfilePage();
    }
    return HomeScreen(
      gotosearch: () {},
      gotoprofile: (() {}),
    );
  }

  List<Widget> screen = [
    HomeScreen(
      gotoprofile: () {},
      gotosearch: () {},
    ),
    SearchPage(),
    CoursesPage(),
    CartPage(),
    ProfilePage()
  ];

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
            BottomNavigationBarItem(
                label: 'Courses', icon: Icon(Icons.shopping_bag)),
            BottomNavigationBarItem(
                label: 'Cart', icon: Icon(Icons.shopping_cart_rounded)),
            BottomNavigationBarItem(
                label: 'Profile', icon: Icon(Icons.account_circle_outlined))
          ]),
    );
  }
}
