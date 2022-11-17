import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

import 'package:skilledge/screens/AuthScreens/Login.dart';
import 'package:skilledge/screens/BrowsePage/Dashboard.dart';

class GettingStarted extends StatelessWidget {
  const GettingStarted({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Center(
                child: CarouselSlider(
                  options: CarouselOptions(
                    autoPlay: true,
                    // height: MediaQuery.of(context).size.height * 0.8
                  ),
                  items: [
                    ['go.png', 'Take Video Courses'],
                    ['learn.png', 'Learn From The Best'],
                    ['take.png', "Let's get started"],
                  ].map((i) {
                    return Builder(
                      builder: (BuildContext context) {
                        return SingleChildScrollView(
                          child: Container(
                            // height: 5000,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Image.asset('assets/${i[0]}'),
                                Padding(
                                  padding: const EdgeInsets.only(
                                    top: 16.0,
                                  ),
                                  child: Center(
                                    child: Text(
                                      i[1].toUpperCase(),
                                      style: const TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.w500),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        );
                      },
                    );
                  }).toList(),
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Container(
        height: 64,
        decoration: const BoxDecoration(color: Color(0xFF1D1E21)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            SizedBox(
              width: MediaQuery.of(context).size.width / 2,
              height: 64,
              child: TextButton(
                  onPressed: (() {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => BrowseDash(),
                        ));
                  }),
                  child: const Text(
                    'Browse',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontFamily: 'Roboto'),
                  )),
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width / 2,
              height: 64,
              child: TextButton(
                  onPressed: (() {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Login()),
                    );
                  }),
                  child: const Text(
                    'Sign In',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontFamily: 'Roboto'),
                  )),
            )
          ],
        ),
      ),
    );
  }
}
