// import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
// import 'package:flutter/src/widgets/container.dart';
// import 'package:flutter/src/widgets/framework.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:skilledge/EducatorScreens/coursepreview.dart';
// import 'package:skilledge/EducatorScreens/Addsection.dart';
import 'package:skilledge/EducatorScreens/editnewLesson.dart';
import 'package:skilledge/screens/Screens/CoursePreview.dart';
import 'package:skilledge/screens/dashboard.dart';
import 'package:skilledge/services/api_services.dart';

class EduCourses extends StatefulWidget {
  const EduCourses(
      {super.key,
      this.rating,
      this.id,
      this.edu_name,
      this.topic,
      this.short_description,
      this.thumbnail,
      this.price});
  final topic;
  final rating;
  final edu_name;
  final id;
  final short_description;
  final thumbnail;
  final price;
  @override
  State<EduCourses> createState() => _EduCoursesState();
}

class _EduCoursesState extends State<EduCourses> {
  bool loading = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 150,
      width: double.infinity,
      margin: EdgeInsets.all(10),
      decoration: BoxDecoration(
          color: Color(0xFFF6FAFA),
          borderRadius: BorderRadius.all(Radius.circular(10))),
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
                Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        child: (loading)
                            ? Center(
                                child: CircularProgressIndicator(),
                              )
                            : TextButton(
                                onPressed: () {
                                  if (screentouch == true) {
                                    return;
                                  }
                                  setState(() {
                                    loading = true;
                                  });
                                  screentouch=true;
                                  API api = API();
                                  api.getLessons(widget.id).then((value1) {
                                    api.getReviews(widget.id).then((value) {
                                      setState(() {
                                        loading = false;
                                      });
                                      screentouch=false;
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) => CoursePreviewEdu(
                                                id: widget.id,
                                                topic: widget.topic,
                                                thumbnail: widget.thumbnail,
                                                desc: widget.short_description,
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
                                  padding: EdgeInsets.only(
                                      left: 16, right: 16, top: 4, bottom: 4),
                                  decoration: BoxDecoration(
                                      // border: Border.all(color: ),
                                      color: Color(0xFF01C5A6),
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(5))),
                                  // padding: EdgeInsets.all(4),
                                  child: Text(
                                    'View',
                                    style: TextStyle(color: Colors.white),
                                  ),
                                )),
                      ),
                      TextButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: ((context) =>
                                        EditAddSection(id: widget.id))));
                          },
                          child: Container(
                            padding: EdgeInsets.all(4),
                            child: Text(
                              'Add New Lesson',
                              style: TextStyle(color: Colors.black),
                            ),
                          )),
                    ],
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
