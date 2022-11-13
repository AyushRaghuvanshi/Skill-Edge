import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/widgets.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:skilledge/services/api_services.dart';

import 'package:skilledge/screens/dashboard.dart';
import 'package:skilledge/widgets/courseCard.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key, required this.gotosearch});
  final void Function() gotosearch;
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int id = 0;
  RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  void _onRefresh() async {
    // monitor network fetch
    print(courses);
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
    courses = await snapshot.getStringList("Courses");
    // print('here');
    if (this.mounted) {
      setState(() {});
      firsttime = false;
    }
  }

  bool? isedu;
  List<String>? courses;
  List<dynamic> courses_map = [];

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        builder: (context, snapshot) {
          if (courses != null) {
            courses_map.clear();
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
                    child: SingleChildScrollView(
                      child: Container(
                        height: MediaQuery.of(context).size.height * 0.9,
                        width: MediaQuery.of(context).size.width,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(top: 52.0),
                              child: SingleChildScrollView(
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    SingleChildScrollView(
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
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
                                                "Let's, Find Your",
                                                textAlign: TextAlign.left,
                                                style: TextStyle(
                                                    fontSize: 14,
                                                    fontWeight:
                                                        FontWeight.w500),
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
                                    ),
                                    Padding(
                                      padding:
                                          const EdgeInsets.only(right: 35.0),
                                      child: Container(
                                        padding: EdgeInsets.all(4),
                                        decoration: BoxDecoration(
                                            color: Color(0xFF01C5A6),
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(100))),
                                        child: CircleAvatar(
                                          foregroundImage: NetworkImage((pic !=
                                                  null)
                                              ? pic!
                                              : 'https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_640.png'),
                                          radius: 24,
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 24.0),
                              child: GestureDetector(
                                onTap: (() {
                                  print("tap");
                                  widget.gotosearch();
                                }),
                                child: Container(
                                  decoration: BoxDecoration(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(10)),
                                      color:
                                          Color.fromARGB(255, 221, 249, 249)),
                                  width: double.infinity,
                                  height: 56,
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      Icon(
                                        Icons.search,
                                        color: Colors.grey,
                                      ),
                                      Text(
                                        'Search Course or Mentor',
                                        style: TextStyle(color: Colors.grey),
                                      ),
                                      Icon(
                                        Icons.menu_outlined,
                                        color: Colors.grey,
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 32.0),
                              child: SingleChildScrollView(
                                child: Stack(children: [
                                  Container(
                                    decoration: BoxDecoration(
                                        gradient: LinearGradient(
                                            begin: Alignment.topLeft,
                                            end: Alignment.bottomRight,
                                            colors: [
                                              Color(0xFF03D976),
                                              Color(0xFF00B6CE)
                                            ]),
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(10))),
                                    width: double.infinity,
                                    height: 128,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 8.0, right: 24),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.all(24.0),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Text(
                                                '40% off',
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 14),
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    top: 4.0, bottom: 2),
                                                child: Text('Today Special',
                                                    style: TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 24)),
                                              ),
                                              Text(
                                                  'Get Discout For Every Course',
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 10))
                                            ],
                                          ),
                                        ),
                                        Text('40%',
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 48)),
                                      ],
                                    ),
                                  )
                                ]),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 32.0),
                              child: Text(
                                'Most Popular Course',
                                textAlign: TextAlign.start,
                                style: TextStyle(fontSize: 20),
                              ),
                            ),
                            Expanded(
                              child: ListView.builder(
                                  scrollDirection: Axis.horizontal,
                                  itemCount: courses_map.length,
                                  itemBuilder: ((context, index) {
                                    int id = courses_map[index]['id'];
                                    int catog = courses_map[index]['category'];
                                    String topic = courses_map[index]['topic'];
                                    int edu_mail =
                                        courses_map[index]['educator_mail'];
                                    String desc =
                                        courses_map[index]['short_description'];
                                    String thumbnail =
                                        courses_map[index]['thumbnail'];
                                    int price = courses_map[index]['price'];
                                    double rating =
                                        courses_map[index]["rating"];
                                    String edu_name =
                                        courses_map[index]["educator_name"];
                                    return CourseCard(
                                        id: id,
                                        rating: rating,
                                        edu_name: edu_name,
                                        catog: catog,
                                        edu: edu_mail,
                                        topic: topic,
                                        desc: desc,
                                        thumbnail: thumbnail,
                                        price: price);
                                  })),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ));
          }
          return CircularProgressIndicator();
        },
        future: getdata());
  }
}
