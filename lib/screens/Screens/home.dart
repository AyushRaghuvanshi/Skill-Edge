import 'dart:convert';

import 'package:flutter/material.dart';

import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

import 'package:shared_preferences/shared_preferences.dart';

import 'package:skilledge/widgets/courseCard.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen(
      {super.key, required this.gotosearch, required this.gotoprofile});
  final void Function() gotosearch;
  final void Function() gotoprofile;
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int id = 0;

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
  bool loading = false;
  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
        child: _pagebuild(context), inAsyncCall: loading, blur: 0.5);
  }

  void setloading() {
    setState(() {
      loading = !loading;
    });
  }

  Widget _pagebuild(BuildContext context) {
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
              child: SingleChildScrollView(
                child: Container(
                  height: MediaQuery.of(context).size.height * 0.9,
                  width: MediaQuery.of(context).size.width,
                  child: SingleChildScrollView(
                    child: Container(
                      height: MediaQuery.of(context).size.height * 0.9,
                      width: MediaQuery.of(context).size.width,
                      child: SingleChildScrollView(
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
                                            'Hi, ${name.toString().split(' ')[0]}',
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
                                        child: GestureDetector(
                                          onTap: widget.gotoprofile,
                                          child: CircleAvatar(
                                            foregroundImage: NetworkImage((pic !=
                                                    null)
                                                ? pic!
                                                : 'https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_640.png'),
                                            radius: 24,
                                          ),
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
                                  child: Center(
                                      child:
                                          Image.asset('assets/welcome.png'))),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 32.0),
                              child: Text(
                                'Most Popular Course',
                                textAlign: TextAlign.start,
                                style: TextStyle(fontSize: 20),
                              ),
                            ),
                            Container(
                              height: 260,
                              child: ListView.builder(
                                  scrollDirection: Axis.horizontal,
                                  itemCount: courses_map.length,
                                  itemBuilder: ((context, index) {
                                    // print(courses_map[index]);/
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
                                        loading: setloading,
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
          return Center(child: CircularProgressIndicator());
        },
        future: getdata());
  }
}
