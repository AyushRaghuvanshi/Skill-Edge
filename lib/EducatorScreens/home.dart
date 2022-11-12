import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/widgets.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:skilledge/EducatorScreens/course.dart';
import 'package:skilledge/services/api_services.dart';

import 'package:skilledge/screens/dashboard.dart';
import 'package:skilledge/widgets/courseCard.dart';
import 'package:skilledge/widgets/searchCourse.dart';

class HomeScreenEdu extends StatefulWidget {
  const HomeScreenEdu({super.key});

  @override
  State<HomeScreenEdu> createState() => _HomeScreenEduState();
}

class _HomeScreenEduState extends State<HomeScreenEdu> {
  int id = 0;
  RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  void _onRefresh() async {
    // monitor network fetch
    API api = new API();
    await api.getprofile();
    await getdata();
    setState(() {});
    _refreshController.refreshCompleted();
  }

  String? name;

  String? username;

  String? pic;

  String? dob;

  int? mobile;
  bool firsttime = true;
  Future<dynamic> getdata() async {
    var snapshot = await SharedPreferences.getInstance();
    name = await snapshot.getString("Name");
    username = await snapshot.getString("Username");
    pic = await snapshot.getString("picture");
    dob = await snapshot.getString("dateOfBirth");
    mobile = await snapshot.getInt("mobile");
    isedu = await snapshot.getBool("is_educator");

    courses = await snapshot.getStringList("hostedCourses");
    // print('here');
    Future.delayed(const Duration(milliseconds: 10000), () {
      setState(() {});
    });
  }

  bool? isedu;
  List<String>? courses;
  List<dynamic> courses_map = [];

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        builder: (context, snapshot) {
          if (true) {
            courses_map.clear();
            if (courses != null)
              for (int i = 0; i < courses!.length; i++) {
                courses_map.add(json.decode(courses![i]));
              }
            return Center(
                child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: SmartRefresher(
                controller: _refreshController,
                onRefresh: _onRefresh,
                child: SingleChildScrollView(
                  child: Container(
                    height: MediaQuery.of(context).size.height * 0.9,
                    width: MediaQuery.of(context).size.width,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 52.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Hi, $name',
                                    textAlign: TextAlign.left,
                                    style: TextStyle(
                                        fontSize: 24,
                                        fontWeight: FontWeight.w500),
                                  ),
                                  Row(
                                    children: [
                                      Text(
                                        "Let's, Publish Your",
                                        textAlign: TextAlign.left,
                                        style: TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w500),
                                      ),
                                      Text(
                                        " Course!",
                                        textAlign: TextAlign.left,
                                        style: TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w500,
                                            color: Color(0xFF01C5A6)),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                              Padding(
                                padding: const EdgeInsets.only(right: 35.0),
                                child: Container(
                                  padding: EdgeInsets.all(4),
                                  decoration: BoxDecoration(
                                      color: Color(0xFF01C5A6),
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(100))),
                                  child: CircleAvatar(
                                    foregroundImage: NetworkImage((pic != null)
                                        ? pic!
                                        : 'https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_640.png'),
                                    radius: 24,
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                        Container(
                          height: MediaQuery.of(context).size.height * 0.7,
                          child: (courses != null)
                              ? ListView.builder(
                                  itemCount: courses!.length,
                                  itemBuilder: ((context, index) {
                                    var temp = courses![index];
                                    var temp2 = json.decode(temp);
                                    print(temp);
                                    return EduCourses(
                                      rating: temp2['rating'],
                                      short_description:
                                          temp2['short_description'],
                                      edu_name: temp2['educator_name'],
                                      id: temp2['id'],
                                      price: temp2['price'],
                                      thumbnail: temp2['thumbnail'],
                                      topic: temp2['topic'],
                                    );
                                  }))
                              : Text('Host A course to see something here'),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ));
          }
          return Center(child: CircularProgressIndicator());
        },
        future: getdata());
  }
}
