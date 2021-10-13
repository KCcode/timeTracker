import 'package:flutter/material.dart';
import 'package:time_tracker_flutter/app/sign_in/sign_in_page.dart';

void main(){
  runApp(TimeTrackerApp());
}

class TimeTrackerApp extends StatelessWidget {
  const TimeTrackerApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Time Tracker",
      theme: ThemeData(
          primarySwatch: Colors.indigo
      ),
      home: SignInPage(),
    );
  }
}
