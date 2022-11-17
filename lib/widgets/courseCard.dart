import 'package:flutter/material.dart';

import 'package:flutter_mobx/flutter_mobx.dart';

import 'package:skilledge/Stores/home.dart';
import 'package:skilledge/screens/Screens/CoursePreview.dart';
import 'package:skilledge/screens/dashboard.dart';
import 'package:skilledge/services/api_services.dart';

class CourseCard extends StatefulWidget {
  const CourseCard(
      {super.key,
      required this.loading,
      this.topic,
      this.edu_name,
      this.catog,
      this.desc,
      this.id,
      this.price,
      this.thumbnail,
      this.rating,
      this.edu});

  final rating;
  final void Function() loading;
  final topic;
  final edu_name;
  final catog;
  final desc;
  final id;
  final price;
  final thumbnail;
  final edu;
  @override
  State<CourseCard> createState() => _CourseCardState();
}

class _CourseCardState extends State<CourseCard> {
  bool loading = false;
  final home = Home();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        width: 234,
        decoration: BoxDecoration(
            color: Color(0xFFF6FAFA),
            borderRadius: BorderRadius.all(Radius.circular(10))),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                  height: 128,
                  width: 234,
                  child: Center(
                    child: Image.network(
                      widget.thumbnail,
                      fit: BoxFit.fill,
                    ),
                  )),
              Padding(
                padding: const EdgeInsets.all(4.0),
                child: Text(
                  widget.topic,
                  style: TextStyle(fontSize: 16),
                  overflow: TextOverflow.fade,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(4.0),
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
                    if (!home.loading) {
                      return TextButton(
                          onPressed: () {
                            print(screentouch);
                            if (screentouch == true) {
                              return;
                            }
                            home.setLoading();
                            screentouch = true;
                            API api = API();
                            api.getLessons(widget.id).then((value1) {
                              api.getReviews(widget.id).then((value) {
                                home.setLoading();
                                screentouch = false;
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => CoursePreview(
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
                                border: Border.all(color: Color(0xFF01C5A6)),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(5))),
                            padding: EdgeInsets.all(4),
                            child: Text(
                              'Preview',
                              style: TextStyle(color: Color(0xFF01C5A6)),
                            ),
                          ));
                    } else {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                  }),
                  Text(
                    (widget.price == 0)
                        ? "Free"
                        : '₹' + widget.price.toString(),
                    style: TextStyle(fontSize: 24),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
