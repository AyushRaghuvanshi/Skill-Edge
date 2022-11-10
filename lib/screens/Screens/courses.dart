import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:skilledge/services/api_services.dart';
import 'package:skilledge/widgets/courseCard.dart';
import 'package:skilledge/widgets/mycourses.dart';
import 'package:skilledge/widgets/searchCourse.dart';

class CoursesPage extends StatefulWidget {
  const CoursesPage({super.key});

  @override
  State<CoursesPage> createState() => _CoursesPageState();
}

class _CoursesPageState extends State<CoursesPage> {
  List<dynamic> mycourses = [];

  Future<void> getMyCourses() async {
    API api = API();
    await api.getpurchasedcourses().then((value) {
      setState(() {
        mycourses = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: getMyCourses(),
      builder: ((context, snapshot) {
        // if (mycourses.length > 0) {
        return Padding(
          padding: const EdgeInsets.only(left: 16.0, top: 64),
          child: Column(
            children: [
              Text(
                'My Courses',
                style: TextStyle(fontSize: 24),
              ),
              Container(
                child: (mycourses.length == 0)
                    ? Center(
                        child: Text('No Courses Here'),
                      )
                    : null,
              ),
              Expanded(
                  child: ListView.builder(
                      itemCount: mycourses.length,
                      itemBuilder: ((context, index) {
                        return MyCourse(
                          topic: mycourses[index]['topic'],
                          id: mycourses[index]['id'],
                          // catog: mycourses[index]['category'],
                          desc: mycourses[index]['short_description'],
                          // edu: mycourses[index]['educator_mail'],
                          edu_name: mycourses[index]['educator_name'],
                          price: mycourses[index]['price'],
                          rating: mycourses[index]['rating'],
                          thumbnail: mycourses[index]['thumbnail'],
                        );
                      })))
            ],
          ),
        );
        // }
        // return Center(child: CircularProgressIndicator());
      }),
    );
  }
}
