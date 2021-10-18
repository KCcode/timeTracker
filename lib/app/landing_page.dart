import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:time_tracker_flutter/app/home_page.dart';
import 'package:time_tracker_flutter/app/sign_in/sign_in_page.dart';
import 'package:time_tracker_flutter/services/authBase.dart';

class LandingPage extends StatefulWidget {
  final AuthBase auth;

  LandingPage(this.auth);

  @override
  _LandingPageState createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  User? _user;

  @override
  void initState() {
    super.initState();
    _updateUser(widget.auth.currentUser); //check if user has signed in upon restart of the app
  }

  void _updateUser(User? user) {
    setState(() { // redraw the widget, and call build again after setState
      _user = user; //setting private user attribute with the user value returned from firebase;
    });
  }

  @override
  Widget build(BuildContext context) {
    //called several times for our interest initState and after setState call
    if (_user == null) {
      print("in here");
      return SignInPage((user) => _updateUser(user), widget.auth);
    }
    else {
      return HomePage(
            () => _updateUser(null),
        widget.auth,
      ); //temp holder for home page
    }
  }
}
