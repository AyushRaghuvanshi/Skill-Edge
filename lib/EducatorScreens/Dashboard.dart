import 'package:flutter/material.dart';
import 'package:skilledge/EducatorScreens/home.dart';
import 'package:skilledge/EducatorScreens/host.dart';
import 'package:skilledge/EducatorScreens/profile.dart';
import 'package:skilledge/screens/Screens/Search.dart';
import 'package:skilledge/screens/Screens/cart.dart';
import 'package:skilledge/screens/Screens/courses.dart';
import 'package:skilledge/screens/Screens/home.dart';
import 'package:skilledge/screens/Screens/profile.dart';

class DashBoardEdu extends StatefulWidget {
  const DashBoardEdu({super.key});

  @override
  State<DashBoardEdu> createState() => _DashBoardEduState();
}

class _DashBoardEduState extends State<DashBoardEdu> {
  int screen_index = 0;

  List<Widget> screen = [HomeScreenEdu(), HostCourse(), ProfilePageEdu()];

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
            BottomNavigationBarItem(label: 'Host', icon: Icon(Icons.push_pin)),
            BottomNavigationBarItem(
                label: 'Profile', icon: Icon(Icons.account_circle_outlined))
          ]),
    );
  }
}
