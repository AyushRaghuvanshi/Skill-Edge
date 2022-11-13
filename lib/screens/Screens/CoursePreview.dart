import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:skilledge/screens/PaymentScreens/check.dart';
import 'package:skilledge/services/api_services.dart';

class CoursePreview extends StatefulWidget {
  const CoursePreview(
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
  State<CoursePreview> createState() => _CoursePreviewState();
}

class _CoursePreviewState extends State<CoursePreview> {
  bool info = true;
  int tab_index = 0;
  List<Widget> tabs = [];
  bool loading = false;
  Widget build(BuildContext context) {
    return  ModalProgressHUD(
          child: _pagebuild(context), inAsyncCall: loading, blur: 0.5);
  }

  Widget _pagebuild(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.only(top: MediaQuery.of(context).viewPadding.top),
        child: Column(mainAxisAlignment: MainAxisAlignment.start, children: [
          Container(
            height: MediaQuery.of(context).size.height * 0.4,
            child: Image.network(
              widget.thumbnail,
              fit: BoxFit.fill,
            ),
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
                      ? "  " + widget.rating.toString().substring(0, 3)
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
                        style:
                            TextStyle(color: Color(0xFF01C5A6), fontSize: 20),
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
                        style:
                            TextStyle(color: Color(0xFF01C5A6), fontSize: 20),
                      ),
                    ),
                  )),
              TextButton(
                  onPressed: () {
                    setState(() {
                      tab_index = 2;
                    });
                  },
                  child: Container(
                    width: 96,
                    height: 39,
                    // padding: EdgeInsets.all(13),
                    decoration: (tab_index == 2)
                        ? BoxDecoration(
                            border: Border(
                                bottom: BorderSide(
                                    width: (tab_index == 2) ? 3 : 0,
                                    color: Color(
                                      0xFF01C5A6,
                                    ))))
                        : null,
                    child: Center(
                      child: Text(
                        'Reviews',
                        style:
                            TextStyle(color: Color(0xFF01C5A6), fontSize: 20),
                      ),
                    ),
                  )),
            ],
          ),
          Container(
            child: (tab_index == 2)
                ? Expanded(
                    child: Column(
                    children: [
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.only(top: 16.0, left: 24),
                        child: Text(
                          "Student Reviews",
                          style: TextStyle(fontSize: 20),
                        ),
                      ),
                      Expanded(
                        child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: widget.reviews.length,
                            itemBuilder: ((context, index) {
                              return Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Container(
                                  decoration: BoxDecoration(
                                      border: Border.all(
                                          color: Color(0XFF01C5A6), width: 2),
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(24))),
                                  width: 264,
                                  padding: EdgeInsets.all(10),
                                  child: Center(
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            Text(
                                              widget.reviews[index]
                                                          ['latest_review']
                                                      .toString() +
                                                  ".0 ",
                                              style: TextStyle(
                                                  fontSize: 24,
                                                  color: Color(0xFF444444),
                                                  fontWeight: FontWeight.w700),
                                            ),
                                            Icon(
                                              Icons.star,
                                              color: Color(0xFFFFBB15),
                                              size: 24,
                                            )
                                          ],
                                        ),
                                        Text(widget.reviews[index]['comment'])
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            })),
                      )
                    ],
                  ))
                : null,
          ),
          Container(
            child: (tab_index == 1)
                ? Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Container(
                          width: double.infinity,
                          padding: const EdgeInsets.only(top: 16.0, left: 24),
                          child: Text(
                            "Lessons",
                            style: TextStyle(fontSize: 20),
                          ),
                        ),
                        Expanded(
                          child: Container(
                            padding: const EdgeInsets.only(left: 16.0),
                            child: ListView.builder(
                              itemCount: widget.lessons.length,
                              itemBuilder: (context, index) {
                                return Padding(
                                  padding: const EdgeInsets.all(12.0),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(widget.lessons[index]["lessonName"]),
                                      TextButton(
                                        onPressed: null,
                                        child: Text('Watch'),
                                      )
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
                ? Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 16.0, left: 24),
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
                      )
                    ],
                  )
                : null,
          ),
        ]),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.only(bottom: 24.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            TextButton(
                onPressed: () {
                  print('here');
                  setState(() {
                    loading = true;
                  });
                  API api = API();
                  api.buyacourse(widget.id).then((value) {
                    setState(() {
                      loading = false;
                    });
                    ScaffoldMessenger.of(context)
                        .showSnackBar(SnackBar(content: Text(value)));
                  });
                },
                child: Container(
                    decoration: BoxDecoration(
                        color: Color(0xFF01C5A6),
                        borderRadius: BorderRadius.all(Radius.circular(8))),
                    padding: EdgeInsets.only(
                        top: 12, bottom: 12, left: 46, right: 46),
                    child: Text(
                      'Buy Now',
                      style: TextStyle(color: Colors.white),
                    ))),
            TextButton(
                onPressed: () {
                  setState(() {
                    loading = true;
                  });
                  API api = API();
                  api.addtoCart(widget.id).then((value) {
                    setState(() {
                      loading = false;
                    });
                    ScaffoldMessenger.of(context)
                        .showSnackBar(SnackBar(content: Text(value)));
                  });
                },
                child: Container(
                    decoration: BoxDecoration(
                        border: Border.all(color: Color(0xFF01C5A6)),
                        borderRadius: BorderRadius.all(Radius.circular(8))),
                    padding: EdgeInsets.only(
                        top: 12, bottom: 12, left: 46, right: 46),
                    child: Text(
                      'Add to Cart',
                      style: TextStyle(color: Color(0xFF01C5A6)),
                    )))
          ],
        ),
      ),
    );
  }
}
