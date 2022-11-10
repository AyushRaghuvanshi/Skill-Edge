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

class _DashboardState extends State<Dashboard> {
  int screen_index = 0;

  List<Widget> screen = [
    HomeScreen(),
    SearchPage(),
    CoursesPage(),
    CartPage(),
    ProfilePage()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: screen[screen_index],
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
