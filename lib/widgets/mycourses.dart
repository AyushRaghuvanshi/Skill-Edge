import 'package:flutter/material.dart';

import 'package:flutter_mobx/flutter_mobx.dart';

import 'package:skilledge/Stores/courses.dart';
import 'package:skilledge/screens/Screens/BoughtCourse.dart';

import 'package:skilledge/screens/dashboard.dart';
import 'package:skilledge/services/api_services.dart';

class MyCourse extends StatefulWidget {
  const MyCourse(
      {super.key,
      this.rating,
      this.desc,
      this.edu_name,
      this.id,
      this.topic,
      this.short_description,
      this.thumbnail,
      this.price});
  final topic;
  final rating;
  final edu_name;
  final id;
  final desc;
  final short_description;
  final thumbnail;
  final price;
  @override
  State<MyCourse> createState() => _MyCourseState();
}

class _MyCourseState extends State<MyCourse> {
  bool loading = false;
  var courses = Courses();
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Color(0xFFF6FAFA),
          borderRadius: BorderRadius.all(Radius.circular(10))),
      margin: EdgeInsets.only(top: 16),
      height: 150,
      width: double.infinity,
      child: Row(
        children: [
          Center(
            child: Container(
              width: 96,
              height: 97,
              child: Image.network(
                widget.thumbnail,
                fit: BoxFit.fill,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 8.0, top: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Image.network(widget.thumbnail),
                Text(
                  widget.topic,
                  style: TextStyle(fontSize: 16),
                  overflow: TextOverflow.fade,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    // '*Something*',
                    widget.edu_name,
                    style: TextStyle(fontSize: 10, color: Color(0xFF979898)),
                    overflow: TextOverflow.fade,
                  ),
                ),
                Row(
                  children: [
                    Icon(
                      Icons.star_rate,
                      color: Color(0xFFF48C06),
                    ),
                    Text(
                      // '4.0',
                      (widget.rating.toString().length > 4)
                          ? widget.rating.toString().substring(0, 3)
                          : widget.rating.toString(),
                      style: TextStyle(
                        fontSize: 16,
                      ),
                      overflow: TextOverflow.fade,
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Observer(builder: (_) {
                      if (courses.loading) {
                        return Center(child: CircularProgressIndicator());
                      } else
                        return IgnorePointer(
                          ignoring: screentouch,
                          child: TextButton(
                              onPressed: () {
                                if (screentouch == true) {
                                  return;
                                }
                                screentouch = true;
                                courses.setLoading();
                                API api = API();
                                api.getLessons(widget.id).then((value1) {
                                  api.getReviews(widget.id).then((value) {
                                    courses.setLoading();
                                    screentouch = false;
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => BoughtCourse(
                                              id: widget.id,
                                              topic: widget.topic,
                                              thumbnail: widget.thumbnail,
                                              desc: widget.desc,
                                              price: widget.price,
                                              rating: widget.rating,
                                              educator: widget.edu_name,
                                              lessons: value1,
                                              reviews: value),
                                        ));
                                  });
                                });
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                    border:
                                        Border.all(color: Color(0xFF01C5A6)),
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(5))),
                                padding: EdgeInsets.all(4),
                                child: Text(
                                  'Continue',
                                  style: TextStyle(color: Color(0xFF01C5A6)),
                                ),
                              )),
                        );
                    }),
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
