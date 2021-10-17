import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:time_tracker_flutter/app/home_page.dart';
import 'package:time_tracker_flutter/app/sign_in/sign_in_page.dart';

class LandingPage extends StatefulWidget {
  const LandingPage({Key? key}) : super(key: key);


  @override
  _LandingPageState createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  User? _user;

  @override
  void initState(){
    super.initState();
    _updateUser(FirebaseAuth.instance.currentUser); //check if user has signed in upon restart of the app
  }

  void _updateUser(User? user){
    setState(() {  // redraw the widget
      _user = user;  //setting private user attribute with the user value returned from firebase;
    });
    //print('User id: ${user.uid}');
  }

  @override
  Widget build(BuildContext context) { //called several times for our interest initState and after setState call
    if(_user == null) {
      print("in here");
      return SignInPage((user) => _updateUser(user),);
    }
    return HomePage(() => _updateUser(null),); //temp holder for home page
  }
}
