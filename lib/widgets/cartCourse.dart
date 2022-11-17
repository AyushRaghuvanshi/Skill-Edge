import 'package:flutter/material.dart';

import 'package:flutter_mobx/flutter_mobx.dart';

import 'package:skilledge/Stores/cart.dart';
import 'package:skilledge/screens/Screens/course_bought.dart';
import 'package:skilledge/services/api_services.dart';

import '../screens/dashboard.dart';

class CartCourses extends StatefulWidget {
  const CartCourses(
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
  State<CartCourses> createState() => _CartCoursesState();
}

class _CartCoursesState extends State<CartCourses> {
  var cart = Cart();

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
                Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Observer(builder: (context) {
                        if (cart.bloading) {
                          return Center(
                            child: CircularProgressIndicator(),
                          );
                        } else
                          return TextButton(
                              onPressed: () {
                                print(screentouch);
                                if (screentouch == true) {
                                  return;
                                }

                                screentouch = true;
                                API api = API();
                                api.buyacourse(widget.id).then((value) {
                                  screentouch = false;
                               
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
                                  'Buy Now',
                                  style: TextStyle(color: Colors.white),
                                ),
                              ));
                      }),
                      Observer(builder: (_) {
                        if (cart.loading) {
                          return Center(
                            child: CircularProgressIndicator(),
                          );
                        } else
                          return TextButton(
                              onPressed: () {
                                print(screentouch);
                                if (screentouch) {
                                  return;
                                }
                                cart.setLoading();
                                API api = API();
                                api.removefromCart(widget.id).then((value) {
                                  cart.setLoading();
                                  ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(content: Text(value)));
                                });
                              },
                              child: Container(
                                padding: EdgeInsets.all(4),
                                child: Text(
                                  'Remove',
                                  style: TextStyle(color: Colors.black),
                                ),
                              ));
                      }),
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
