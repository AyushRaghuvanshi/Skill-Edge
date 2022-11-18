import 'package:dotted_border/dotted_border.dart';

import 'package:flutter/material.dart';

import 'package:skilledge/EducatorScreens/HostCoursePage.dart';

class HostCourse extends StatefulWidget {
  const HostCourse({super.key});

  @override
  State<HostCourse> createState() => _HostCourseState();
}

class _HostCourseState extends State<HostCourse> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Container(
            child: Container(
          decoration: BoxDecoration(border: Border.all()),
          padding: EdgeInsets.all(4),
          child: DottedBorder(
            strokeWidth: 2,
            dashPattern: [10, 10],
            color: Color(0xFF01C5A6),
            child: Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              child: Center(
                  child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Upload and Publish your Course',
                    style: TextStyle(fontSize: 16),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: ((context) => HostCoursePage())));
                        },
                        child: Container(
                            color: Color(0xFF01C5A6),
                            width: double.infinity,
                            height: 46,
                            child: Center(
                                child: Text(
                              'Host Course',
                              style: TextStyle(color: Colors.white),
                            )))),
                  )
                ],
              )),
            ),
          ),
        )),
      ),
    );
  }
}
