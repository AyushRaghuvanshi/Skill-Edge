import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  int id = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return Center(
                  child: Text(snapshot.data!.getInt('id').toString()));
            }
            return Center(child: CircularProgressIndicator());
          },
          future: SharedPreferences.getInstance()),
    );
  }
}
