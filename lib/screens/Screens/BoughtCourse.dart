import 'package:flutter/material.dart';

import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:skilledge/screens/Screens/Video.dart';
import 'package:skilledge/services/api_services.dart';

class BoughtCourse extends StatefulWidget {
  const BoughtCourse(
      {super.key,
      this.reviews,
      this.id,
      this.lessons,
      this.topic,
      this.desc,
      this.educator,
      this.price,
      this.rating,
      this.thumbnail});
  final topic;
  final id;
  final lessons;
  final reviews;
  final desc;
  final educator;
  final price;
  final rating;
  final thumbnail;
  @override
  State<BoughtCourse> createState() => _BoughtCourseState();
}

class _BoughtCourseState extends State<BoughtCourse> {
  bool info = true;
  int tab_index = 0;
  List<Widget> tabs = [];

  int star = 0;

  String comment = "";

  bool loading = false;
  Widget build(BuildContext context) {
    return ModalProgressHUD(
        child: _pagebuild(context), inAsyncCall: loading, blur: 0.5);
  }

  Widget _pagebuild(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        child: Padding(
          padding: EdgeInsets.only(top: MediaQuery.of(context).viewPadding.top),
          child: Container(
            height: MediaQuery.of(context).size.height,
            child: SingleChildScrollView(
              child: Container(
                height: MediaQuery.of(context).size.height,
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Image.network(
                        widget.thumbnail,
                        fit: BoxFit.fill,
                      ),
                      Container(
                        padding: EdgeInsets.only(left: 16, top: 12),
                        width: MediaQuery.of(context).size.width,
                        child: Text(
                          widget.topic,
                          textAlign: TextAlign.left,
                          style: TextStyle(fontSize: 24),
                        ),
                      ),
                      Container(
                          padding: EdgeInsets.only(left: 16, top: 8),
                          width: MediaQuery.of(context).size.width,
                          child: Text(
                            'Created By: ${widget.educator}',
                            style: TextStyle(fontSize: 16),
                          )),
                      Container(
                        padding: EdgeInsets.only(left: 16, top: 8),
                        width: MediaQuery.of(context).size.width,
                        child: Row(
                          children: [
                            Icon(
                              Icons.star_rate,
                              color: Color(0xFFF48C06),
                            ),
                            Text(
                              // '4.0',
                              (widget.rating.toString().length > 4)
                                  ? "  " +
                                      widget.rating.toString().substring(0, 3)
                                  : "  " + widget.rating.toString(),
                              style: TextStyle(
                                fontSize: 16,
                              ),
                              overflow: TextOverflow.fade,
                            ),
                          ],
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          TextButton(
                              onPressed: () {
                                setState(() {
                                  tab_index = 0;
                                });
                              },
                              child: Container(
                                // padding: EdgeInsets.all(13),
                                width: 96,
                                height: 39,
                                decoration: (tab_index == 0)
                                    ? BoxDecoration(
                                        border: Border(
                                            bottom: BorderSide(
                                                width: (info) ? 3 : 0,
                                                color: Color(
                                                  0xFF01C5A6,
                                                ))))
                                    : null,
                                child: Center(
                                  child: Text(
                                    'Info',
                                    style: TextStyle(
                                        color: Color(0xFF01C5A6), fontSize: 20),
                                  ),
                                ),
                              )),
                          TextButton(
                              onPressed: () {
                                setState(() {
                                  tab_index = 1;
                                });
                              },
                              child: Container(
                                width: 96,
                                height: 39,
                                // padding: EdgeInsets.all(13),
                                decoration: (tab_index == 1)
                                    ? BoxDecoration(
                                        border: Border(
                                            bottom: BorderSide(
                                                width: (tab_index == 1) ? 3 : 0,
                                                color: Color(
                                                  0xFF01C5A6,
                                                ))))
                                    : null,
                                child: Center(
                                  child: Text(
                                    'Catalog',
                                    style: TextStyle(
                                        color: Color(0xFF01C5A6), fontSize: 20),
                                  ),
                                ),
                              )),
                        ],
                      ),
                      Container(
                        child: (tab_index == 1)
                            ? Expanded(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Container(
                                      width: double.infinity,
                                      padding: const EdgeInsets.only(
                                          top: 16.0, left: 24),
                                      child: Text(
                                        "Lessons",
                                        style: TextStyle(fontSize: 20),
                                      ),
                                    ),
                                    Expanded(
                                      child: Container(
                                        padding:
                                            const EdgeInsets.only(left: 16.0),
                                        child: ListView.builder(
                                          itemCount: widget.lessons.length,
                                          itemBuilder: (context, index) {
                                            print(widget.lessons);
                                            return Padding(
                                              padding:
                                                  const EdgeInsets.all(12.0),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Text(widget.lessons[index]
                                                      ["lessonName"]),
                                                  TextButton(
                                                      onPressed: (() {
                                                        Navigator.push(
                                                            context,
                                                            MaterialPageRoute(
                                                              builder: (context) =>
                                                                  VideoPlayerPage(
                                                                      file: widget
                                                                              .lessons[index]
                                                                          [
                                                                          'file']),
                                                            ));
                                                      }),
                                                      child: Text('Watch'))
                                                ],
                                              ),
                                            );
                                          },
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              )
                            : null,
                      ),
                      Container(
                        width: double.infinity,
                        child: (tab_index == 0)
                            ? SingleChildScrollView(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          top: 16.0, left: 24),
                                      child: Text(
                                        "Description",
                                        style: TextStyle(fontSize: 20),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          top: 16.0, left: 16, right: 16),
                                      child: Text(
                                        widget.desc,
                                        style: TextStyle(fontSize: 20),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(24.0),
                                      child: SingleChildScrollView(
                                        child: Column(
                                          children: [
                                            Row(
                                              children: [
                                                Text('Rate ',
                                                    style: TextStyle(
                                                        fontSize: 20,
                                                        color:
                                                            Color(0xFF01C5A6))),
                                                IconButton(
                                                  icon: (star >= 1)
                                                      ? Icon(
                                                          Icons.star,
                                                          color:
                                                              Color(0xFFF48C06),
                                                        )
                                                      : Icon(Icons.star_border),
                                                  onPressed: () {
                                                    setState(() {
                                                      star = 1;
                                                    });
                                                  },
                                                ),
                                                IconButton(
                                                  icon: (star >= 2)
                                                      ? Icon(
                                                          Icons.star,
                                                          color:
                                                              Color(0xFFF48C06),
                                                        )
                                                      : Icon(Icons.star_border),
                                                  onPressed: () {
                                                    setState(() {
                                                      star = 2;
                                                    });
                                                  },
                                                ),
                                                IconButton(
                                                  icon: (star >= 3)
                                                      ? Icon(
                                                          Icons.star,
                                                          color:
                                                              Color(0xFFF48C06),
                                                        )
                                                      : Icon(Icons.star_border),
                                                  onPressed: () {
                                                    setState(() {
                                                      star = 3;
                                                    });
                                                  },
                                                ),
                                                IconButton(
                                                  icon: (star >= 4)
                                                      ? Icon(
                                                          Icons.star,
                                                          color:
                                                              Color(0xFFF48C06),
                                                        )
                                                      : Icon(Icons.star_border),
                                                  onPressed: () {
                                                    setState(() {
                                                      star = 4;
                                                    });
                                                  },
                                                ),
                                                IconButton(
                                                  icon: (star >= 5)
                                                      ? Icon(
                                                          Icons.star,
                                                          color:
                                                              Color(0xFFF48C06),
                                                        )
                                                      : Icon(Icons.star_border),
                                                  onPressed: () {
                                                    setState(() {
                                                      star = 5;
                                                    });
                                                  },
                                                ),
                                              ],
                                            ),
                                            Container(
                                              width: double.infinity,
                                              child: SingleChildScrollView(
                                                child: Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  children: [
                                                    Container(
                                                        width: double.infinity,
                                                        child: Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(8.0),
                                                          child: Text(
                                                            'Comments',
                                                            style: TextStyle(
                                                                fontSize: 20),
                                                          ),
                                                        )),
                                                    TextFormField(
                                                      onChanged: ((value) {
                                                        comment = value;
                                                      }),
                                                      decoration: InputDecoration(
                                                          border:
                                                              OutlineInputBorder()),
                                                    ),
                                                    TextButton(
                                                        onPressed: () {
                                                          setState(() {
                                                            loading = true;
                                                          });
                                                          API api = API();
                                                          api
                                                              .addReview(
                                                                  widget.id,
                                                                  comment,
                                                                  star)
                                                              .then((value) {
                                                            setState(() {
                                                              loading = false;
                                                            });
                                                            ScaffoldMessenger
                                                                    .of(context)
                                                                .showSnackBar(
                                                                    SnackBar(
                                                                        content:
                                                                            Text(value)));
                                                          });
                                                        },
                                                        child: Text(
                                                          'Post',
                                                          style: TextStyle(
                                                              color: Color(
                                                                  0xFF01C5A6)),
                                                        ))
                                                  ],
                                                ),
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              )
                            : null,
                      ),
                    ]),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
