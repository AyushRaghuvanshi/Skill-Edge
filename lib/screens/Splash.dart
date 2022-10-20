
import 'package:flutter/material.dart';

class Splash extends StatefulWidget {
  const Splash({super.key});

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
              width: 96,
              height: 96,
              child: Image.asset(
                'assets/splash_black.png',
                height: 96,
                width: 96,
              )),
          const Padding(
            padding: EdgeInsets.all(24.0),
            child: Text(
              'SKILL EDGE',
              style: TextStyle(
                  fontFamily: 'Roboto',
                  fontWeight: FontWeight.w700,
                  fontSize: 32),
            ),
          )
        ],
      ),
    ));
  }
}
