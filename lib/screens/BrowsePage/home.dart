

import 'package:flutter/material.dart';

import 'package:pull_to_refresh/pull_to_refresh.dart';

import 'package:skilledge/screens/AuthScreens/Login.dart';
import 'package:skilledge/screens/AuthScreens/Register.dart';


class HomeScreenBrowse extends StatefulWidget {
  const HomeScreenBrowse({super.key, required this.gotosearch});
  final void Function() gotosearch;
  @override
  State<HomeScreenBrowse> createState() => _HomeScreenBrowseState();
}

class _HomeScreenBrowseState extends State<HomeScreenBrowse> {
  int id = 0;
  RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  void _onRefresh() async {
    // monitor network fetch

    _refreshController.refreshCompleted();
  }

  String? name;

  String? username;

  String? pic;

  String? dob;

  int? mobile;
  bool firsttime = true;

  bool? isedu;
  List<String>? courses;
  List<dynamic> courses_map = [];

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      builder: (context, snapshot) {
        if (true) {
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
                            padding: const EdgeInsets.all(24.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: TextButton(
                                      style: TextButton.styleFrom(
                                          backgroundColor: Color(0xFF01C5A6)),
                                      onPressed: () {
                                        Navigator.pushAndRemoveUntil(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) => Login(),
                                            ),
                                            (route) => false);
                                      },
                                      child: Text(
                                        'Log in',
                                        style: TextStyle(color: Colors.white),
                                      )),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: TextButton(
                                      onPressed: () {
                                        Navigator.pushAndRemoveUntil(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) => Register(),
                                            ),
                                            (route) => false);
                                      },
                                      child: Text(
                                        'Sign up',
                                        style: TextStyle(color: Colors.black),
                                      )),
                                )
                              ],
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
                                    color: Color.fromARGB(255, 221, 249, 249)),
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
                                            Text('Get Discout For Every Course',
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
                              child: Center(
                            child: Text('Sign in to View Courses'),
                          ))
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ));
        }
        
      },
    );
  }
}
