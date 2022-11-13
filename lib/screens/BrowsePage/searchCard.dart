import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:skilledge/screens/BrowsePage/Search.dart';
import 'package:skilledge/services/api_services.dart';
import 'package:skilledge/widgets/searchCourse.dart';

class SearchPageBrowse extends StatefulWidget {
  const SearchPageBrowse({super.key});

  @override
  State<SearchPageBrowse> createState() => _SearchPageBrowseState();
}

class _SearchPageBrowseState extends State<SearchPageBrowse> {
  TextEditingController _search = TextEditingController();
  List<dynamic> search_result = [];

  bool loading = false;

  var topic;

  var short_description;

  var thumbnail;

  var price;

  var rating;

  var eduname;

  var id;

  bool b1 = true;
  bool b2 = true;
  bool b3 = true;
  bool b4 = true;
  bool b5 = true;
  bool b6 = true;
  bool b7 = true;
  bool b8 = true;
  bool b9 = true;
  bool b10 = true;
  bool b11 = true;

  int filter = -1;

//  bool loading = false;
  Widget build(BuildContext context) {
    return ModalProgressHUD(
        child: _pagebuild(context), inAsyncCall: loading, blur: 0.5);
  }

  @override
  Widget _pagebuild(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(16.0),
        child: Padding(
          padding: const EdgeInsets.only(top: 32.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextFormField(
                controller: _search,
                onEditingComplete: () {
                  API api = new API();
                  setState(() {
                    loading = true;
                  });
                  api.getSearchresults(_search.text, filter).then((value) {
                    search_result = value;

                    setState(() {
                      loading = false;
                    });
                  });
                },
                decoration: InputDecoration(
                    prefixIcon: Icon(
                      Icons.search,
                      color: Colors.grey,
                    ),
                    suffixIcon: IconButton(
                      icon: Icon(Icons.menu),
                      onPressed: () {
                        showModalBottomSheet(
                          enableDrag: true,
                          context: context,
                          builder: (context) {
                            return StatefulBuilder(
                                builder: ((context, setState) {
                              return Container(
                                width: double.infinity,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(16.0),
                                      child: Text(
                                        'Catogories',
                                        style: TextStyle(fontSize: 24),
                                      ),
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        TextButton(
                                          onPressed: () {
                                            setState(() {
                                              b1 = !b1;
                                              b2 = true;
                                              b3 = true;
                                              b4 = true;
                                              b5 = true;
                                              b6 = true;
                                              b7 = true;
                                              b8 = true;
                                              b9 = true;
                                              b10 = true;
                                              b11 = true;
                                              if (b1 == false) {
                                                filter = 10;
                                              }
                                            });
                                          },
                                          child: Container(
                                            decoration: BoxDecoration(
                                                color: (!b1)
                                                    ? Colors.black
                                                    : Colors.white,
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(10)),
                                                border: Border.all(
                                                  color: Colors.black,
                                                )),
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Text(
                                                "Music",
                                                style: TextStyle(
                                                    color: (!b1)
                                                        ? Colors.white
                                                        : Colors.black),
                                              ),
                                            ),
                                          ),
                                        ),
                                        TextButton(
                                          onPressed: () {
                                            setState(() {
                                              b2 = !b2;

                                              b1 = true;
                                              b3 = true;
                                              b4 = true;
                                              b5 = true;
                                              b6 = true;
                                              b7 = true;
                                              b8 = true;
                                              b9 = true;
                                              b10 = true;
                                              b11 = true;
                                              if (b2 == false) {
                                                filter = 2;
                                              }
                                            });
                                          },
                                          child: Container(
                                            decoration: BoxDecoration(
                                                color: (!b2)
                                                    ? Colors.black
                                                    : Colors.white,
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(10)),
                                                border: Border.all(
                                                  color: Colors.black,
                                                )),
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Text(
                                                "Buisness",
                                                style: TextStyle(
                                                    color: (!b2)
                                                        ? Colors.white
                                                        : Colors.black),
                                              ),
                                            ),
                                          ),
                                        ),
                                        TextButton(
                                          onPressed: () {
                                            setState(() {
                                              b3 = !b3;

                                              b1 = true;
                                              b2 = true;
                                              b4 = true;
                                              b5 = true;
                                              b6 = true;
                                              b7 = true;
                                              b8 = true;
                                              b9 = true;
                                              b10 = true;
                                              b11 = true;
                                              if (b3 == false) {
                                                filter = 7;
                                              }
                                            });
                                          },
                                          child: Container(
                                            decoration: BoxDecoration(
                                                color: (!b3)
                                                    ? Colors.black
                                                    : Colors.white,
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(10)),
                                                border: Border.all(
                                                  color: Colors.black,
                                                )),
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Text(
                                                "Design",
                                                style: TextStyle(
                                                    color: (!b3)
                                                        ? Colors.white
                                                        : Colors.black),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        TextButton(
                                          onPressed: () {
                                            setState(() {
                                              b4 = !b4;
                                              b1 = true;
                                              b2 = true;
                                              b3 = true;
                                              b5 = true;
                                              b6 = true;
                                              b7 = true;
                                              b8 = true;
                                              b9 = true;
                                              b10 = true;
                                              b11 = true;
                                              if (b4 == false) {
                                                filter = 11;
                                              }
                                            });
                                          },
                                          child: Container(
                                            decoration: BoxDecoration(
                                                color: (!b4)
                                                    ? Colors.black
                                                    : Colors.white,
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(10)),
                                                border: Border.all(
                                                  color: Colors.black,
                                                )),
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Text(
                                                "Technical &  Academics",
                                                style: TextStyle(
                                                    color: (!b4)
                                                        ? Colors.white
                                                        : Colors.black),
                                              ),
                                            ),
                                          ),
                                        ),
                                        TextButton(
                                          onPressed: () {
                                            setState(() {
                                              b5 = !b5;
                                              b1 = true;
                                              b2 = true;
                                              b4 = true;
                                              b3 = true;
                                              b6 = true;
                                              b7 = true;
                                              b8 = true;
                                              b9 = true;
                                              b10 = true;
                                              b11 = true;
                                              if (b5 == false) {
                                                filter = 4;
                                              }
                                            });
                                          },
                                          child: Container(
                                            decoration: BoxDecoration(
                                                color: (!b5)
                                                    ? Colors.black
                                                    : Colors.white,
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(10)),
                                                border: Border.all(
                                                  color: Colors.black,
                                                )),
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Text(
                                                "IT & Software",
                                                style: TextStyle(
                                                    color: (!b5)
                                                        ? Colors.white
                                                        : Colors.black),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        TextButton(
                                          onPressed: () {
                                            setState(() {
                                              b6 = !b6;
                                              b1 = true;
                                              b2 = true;
                                              b4 = true;
                                              b5 = true;
                                              b3 = true;
                                              b7 = true;
                                              b8 = true;
                                              b9 = true;
                                              b10 = true;
                                              b11 = true;
                                              if (b6 == false) {
                                                filter = 5;
                                              }
                                            });
                                          },
                                          child: Container(
                                            decoration: BoxDecoration(
                                                color: (!b6)
                                                    ? Colors.black
                                                    : Colors.white,
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(10)),
                                                border: Border.all(
                                                  color: Colors.black,
                                                )),
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Text(
                                                "Office & Productivity",
                                                style: TextStyle(
                                                    color: (!b6)
                                                        ? Colors.white
                                                        : Colors.black),
                                              ),
                                            ),
                                          ),
                                        ),
                                        TextButton(
                                          onPressed: () {
                                            setState(() {
                                              b7 = !b7;
                                              b1 = true;
                                              b2 = true;
                                              b4 = true;
                                              b5 = true;
                                              b6 = true;
                                              b3 = true;
                                              b8 = true;
                                              b9 = true;
                                              b10 = true;
                                              b11 = true;
                                              if (b7 == false) {
                                                filter = 9;
                                              }
                                            });
                                          },
                                          child: Container(
                                            decoration: BoxDecoration(
                                                color: (!b7)
                                                    ? Colors.black
                                                    : Colors.white,
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(10)),
                                                border: Border.all(
                                                  color: Colors.black,
                                                )),
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Text(
                                                "Healthness and Fitness",
                                                style: TextStyle(
                                                    color: (!b7)
                                                        ? Colors.white
                                                        : Colors.black),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        TextButton(
                                          onPressed: () {
                                            setState(() {
                                              b8 = !b8;
                                              b1 = true;
                                              b2 = true;
                                              b4 = true;
                                              b5 = true;
                                              b6 = true;
                                              b7 = true;
                                              b3 = true;
                                              b9 = true;
                                              b10 = true;
                                              b11 = true;
                                              if (b8 == false) {
                                                filter = 3;
                                              }
                                            });
                                          },
                                          child: Container(
                                            decoration: BoxDecoration(
                                                color: (!b8)
                                                    ? Colors.black
                                                    : Colors.white,
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(10)),
                                                border: Border.all(
                                                  color: Colors.black,
                                                )),
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Text(
                                                "Finance",
                                                style: TextStyle(
                                                    color: (!b8)
                                                        ? Colors.white
                                                        : Colors.black),
                                              ),
                                            ),
                                          ),
                                        ),
                                        TextButton(
                                          onPressed: () {
                                            setState(() {
                                              b9 = !b9;
                                              b1 = true;
                                              b2 = true;
                                              b4 = true;
                                              b5 = true;
                                              b6 = true;
                                              b7 = true;
                                              b8 = true;
                                              b3 = true;
                                              b10 = true;
                                              b11 = true;
                                              if (b9 == false) {
                                                filter = 8;
                                              }
                                            });
                                          },
                                          child: Container(
                                            decoration: BoxDecoration(
                                                color: (!b9)
                                                    ? Colors.black
                                                    : Colors.white,
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(10)),
                                                border: Border.all(
                                                  color: Colors.black,
                                                )),
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Text(
                                                "Marketing",
                                                style: TextStyle(
                                                    color: (!b9)
                                                        ? Colors.white
                                                        : Colors.black),
                                              ),
                                            ),
                                          ),
                                        ),
                                        TextButton(
                                          onPressed: () {
                                            setState(() {
                                              b10 = !b10;
                                              b1 = true;
                                              b2 = true;
                                              b4 = true;
                                              b5 = true;
                                              b6 = true;
                                              b7 = true;
                                              b8 = true;
                                              b9 = true;
                                              b3 = true;
                                              b11 = true;
                                              if (b10 == false) {
                                                filter = 1;
                                              }
                                            });
                                          },
                                          child: Container(
                                            decoration: BoxDecoration(
                                                color: (!b10)
                                                    ? Colors.black
                                                    : Colors.white,
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(10)),
                                                border: Border.all(
                                                  color: Colors.black,
                                                )),
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Text(
                                                "Development",
                                                style: TextStyle(
                                                    color: (!b10)
                                                        ? Colors.white
                                                        : Colors.black),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        TextButton(
                                          onPressed: () {
                                            setState(() {
                                              b11 = !b11;
                                              b1 = true;
                                              b2 = true;
                                              b4 = true;
                                              b5 = true;
                                              b6 = true;
                                              b7 = true;
                                              b8 = true;
                                              b9 = true;
                                              b10 = true;
                                              b3 = true;
                                              if (b11 == false) {
                                                filter = 4;
                                              }
                                            });
                                          },
                                          child: Container(
                                            decoration: BoxDecoration(
                                                color: (!b11)
                                                    ? Colors.black
                                                    : Colors.white,
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(10)),
                                                border: Border.all(
                                                  color: Colors.black,
                                                )),
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Text(
                                                "Personal & Development",
                                                style: TextStyle(
                                                    color: (!b11)
                                                        ? Colors.white
                                                        : Colors.black),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              );
                            }));
                          },
                        );
                      },
                    ),
                    hintText: 'Search for Mentor or Courses',
                    border: OutlineInputBorder()),
              ),
              Expanded(
                child: (search_result.length > 0)
                    ? ListView.builder(
                        itemCount: search_result.length,
                        itemBuilder: ((context, index) {
                          if (search_result[index] == 'Nothing Found Here') {
                            return Center(
                                child: Container(
                                    child: Text(search_result[index])));
                          }
                          topic = search_result[index]['topic'];
                          id = search_result[index]['id'];
                          short_description =
                              search_result[index]['short_description'];
                          thumbnail = search_result[index]['thumbnail'];
                          price = search_result[index]['price'];
                          rating = search_result[index]['rating'];
                          eduname = search_result[index]['educator_name'];
                          return SearchCourseBrowse(
                              id: id,
                              rating: rating,
                              edu_name: eduname,
                              topic: topic,
                              desc: short_description,
                              thumbnail: thumbnail,
                              price: price);
                        }))
                    : Center(child: Text('No Courses to Display')),
              )
            ],
          ),
        ));
  }
}
