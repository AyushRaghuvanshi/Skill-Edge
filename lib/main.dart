import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

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
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  static const MaterialColor main = MaterialColor(
    _bluePrimaryValue,
    <int, Color>{
      50: Color(0xFFE3F2FD),
      100: Color(0xFFBBDEFB),
      200: Color(0xFF90CAF9),
      300: Color(0xFF64B5F6),
      400: Color(0xFF42A5F5),
      500: Color(_bluePrimaryValue),
      600: Color(0xFF1E88E5),
      700: Color(0xFF1976D2),
      800: Color(0xFF1565C0),
      900: Color(0xFF0D47A1),
    },
  );
  static const int _bluePrimaryValue = 0XFF01C5A6;

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Skill Edge',
      theme: ThemeData(
        scaffoldBackgroundColor: Color(0xFFFFFFFF),
        primarySwatch: main,
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
  void initState() {
    // TODO: implement initState
    super.initState();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
  }
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: SharedPreferences.getInstance(),
        builder: ((context, snapshot) {
          
          if (snapshot.connectionState == ConnectionState.done) {
            
            Timer(Duration(seconds: 3), () async {
              var k = await snapshot.data!.getString("token");
       
              if (k != null) if (k != "") {
                token = k;
                API api = API();
                await api.verifycheck().then((value) {
                  if (value == true) {
                    api.getprofile();
                    print(token);
                    Navigator.pushReplacement(context,
                        MaterialPageRoute(builder: ((context) => Dashboard())));
                  } else {
                    Navigator.pushReplacement(context,
                        MaterialPageRoute(builder: ((context) => Dashboard())));
                  }
                });
              } else {
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: ((context) => GettingStarted())));
                ;
              }
              else {
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: ((context) => GettingStarted())));
              }
            });
          }
          return Splash();
        }));
  }
}
