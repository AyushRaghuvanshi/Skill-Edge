import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:skilledge/EducatorScreens/home.dart';
import 'package:skilledge/screens/Screens/home.dart';

class CourseBought extends StatefulWidget {
  const CourseBought({super.key});

  @override
  State<CourseBought> createState() => _CourseBoughtState();
}

class _CourseBoughtState extends State<CourseBought> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                'This Course is confirmed',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.w500),
              ),
              Text(
                'Thank you for purchasing the Course',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
              ),
              Image.asset('assets/jump.png'),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
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
