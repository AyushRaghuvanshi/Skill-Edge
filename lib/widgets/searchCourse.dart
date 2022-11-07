import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class SearchCourse extends StatefulWidget {
  const SearchCourse(
      {super.key,
      this.rating,
      this.edu_name,
      this.topic,
      this.short_description,
      this.thumbnail,
      this.price});
  final topic;
  final rating;
  final edu_name;
  final short_description;
  final thumbnail;
  final price;
  @override
  State<SearchCourse> createState() => _SearchCourseState();
}

class _SearchCourseState extends State<SearchCourse> {
  @override
  Widget build(BuildContext context) {
    return Container(
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
            padding: const EdgeInsets.only(left: 8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Image.network(widget.thumbnail),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    widget.topic,
                    style: TextStyle(fontSize: 16),
                    overflow: TextOverflow.fade,
                  ),
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
                      widget.rating.toString(),
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
                    TextButton(
                        onPressed: () {},
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
                        )),
                    Padding(
                      padding: const EdgeInsets.only(left: 24.0),
                      child: Text(
                        '\$' + widget.price.toString(),
                        style: TextStyle(fontSize: 24),
                      ),
                    )
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
