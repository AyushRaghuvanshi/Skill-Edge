import 'dart:async';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:skilledge/screens/AuthScreens/Login.dart';
import 'package:skilledge/screens/AuthScreens/Register.dart';
import 'package:skilledge/screens/AuthScreens/otp.dart';
import 'package:skilledge/screens/Getting_started/gettingstarted.dart';
import 'package:skilledge/screens/OnboardingUI/onBordingQnA.dart';
import 'package:skilledge/screens/Splash.dart';
import 'package:skilledge/screens/dashboard.dart';
import 'package:skilledge/services/api_services.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      routes: {
        '/login': (context) => const Login(),
        '/register': (context) => const Register(),
        '/mainpage': (context) => const Dashboard(),
        '/otp': ((context) => const OtpScreen()),
        '/onboarding': ((context) => const OnboardingQA()),
      },
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: SharedPreferences.getInstance(),
        builder: ((context, snapshot) {
          if (snapshot.hasData) {
            Timer(Duration(seconds: 5), ()  {
              if (snapshot.data!.getString("token") != null) {
                token = snapshot.data!.getString("token");
                API api = API();
                api.getprofile();
                print(token);
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: ((context) => Dashboard())));
              } else {
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: ((context) => GettingStarted())));
                ;
              }
            });
          }
          return Splash();
        }));
  }
}
