import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:skilledge/EducatorScreens/home.dart';
import 'package:skilledge/screens/Screens/home.dart';

class HostedCourse extends StatefulWidget {
  const HostedCourse({super.key});

  @override
  State<HostedCourse> createState() => _HostedCourseState();
}

class _HostedCourseState extends State<HostedCourse> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                'Your Course is Hosted',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.w500),
              ),
              Text(
                'Thank you for Hosting the Course',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
              ),
              Image.asset('assets/jump.png'),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: ElevatedButton(
                    onPressed: () {
                      Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                              builder: ((context) => HomeScreenEdu())),
                          (route) => false);
                    },
                    child: Container(
                      margin: EdgeInsets.only(left: 16, right: 16),
                      width: double.infinity,
                      child: Center(
                        child: Text(
                          'HOME',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    )),
              )
            ]),
      ),
    );
  }
}
