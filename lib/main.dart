import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:time_tracker_flutter/app/landing_page.dart';
import 'package:time_tracker_flutter/services/auth.dart';
import 'package:time_tracker_flutter/services/auth_provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized(); //ensure the framework has been attached to flutter
  await Firebase.initializeApp();
  runApp(TimeTrackerApp());
}

class TimeTrackerApp extends StatelessWidget {
  const TimeTrackerApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AuthProvider(
      auth: Auth(),
      child: MaterialApp(
        title: "Time Tracker",
        theme: ThemeData(
            primarySwatch: Colors.indigo
        ),
        home: LandingPage(),
      ),
    );
  }
}
