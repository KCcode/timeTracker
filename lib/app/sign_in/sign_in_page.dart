import 'package:flutter/material.dart';
import 'package:time_tracker_flutter/app/sign_in/email_sign_in_page.dart';
import 'package:time_tracker_flutter/app/sign_in/sign_in_button.dart';
import 'package:time_tracker_flutter/app/sign_in/social_sign_in_button.dart';
import 'package:time_tracker_flutter/services/authBase.dart';

class SignInPage extends StatelessWidget {
  final AuthBase auth;

  SignInPage(this.auth); //required property of this class

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Time Tracker"),
        elevation: 2.0,
      ),
      body: _buildContainer(context),
      backgroundColor: Colors.grey[200],
    );
  }

  Future<void> _signInAnonymously() async {
    try {
      await auth.signInAnonymously();
    } catch (e) {
      print(e.toString());
    }
  }

  Future<void> _signInWithGoogle() async {
    try {
      await auth.signInWithGoogle();
    } catch (e) {
      print(e.toString());
    }
  }

  void _signInWithEmail(BuildContext context) {
    Navigator.of(context).push( //look for navigator in ancestor once returned navigator push the route
      MaterialPageRoute<void>(
        fullscreenDialog: true,  //how page is presented specific to iOS true : from bottom false : slide from side
        builder: (context) => EmailSignInPage(auth),
      ),
    );
  }

  Widget _buildContainer(BuildContext context) {
    //private method
    return Padding(
      padding: EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            "Sign In",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 32.0,
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(
            height: 8.0,
          ),
          SocialSignInButton("images/google-logo.png", "Sign in with Google",
              Colors.black87, Colors.white, _signInWithGoogle),
          SizedBox(
            height: 8.0,
          ),
          SocialSignInButton("images/facebook-logo.png",
              "Sign in with Facebook", Colors.white, Colors.blue.shade800, () {
            print("pressed facebook button");
          }),
          SizedBox(
            height: 8.0,
          ),
          SignInButton(
            Text(
              'Sign in with Email',
              style: TextStyle(
                color: Colors.white,
                fontSize: 15.0,
              ),
            ),
            Colors.teal,
            () => _signInWithEmail(context),
          ),
          SizedBox(
            height: 8.0,
          ),
          Text(
            "or",
            style: TextStyle(
              color: Colors.black87,
              fontSize: 16.0,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(
            height: 8.0,
          ),
          SignInButton(
            Text(
              'Go anonymous',
              style: TextStyle(
                color: Colors.black87,
                fontSize: 15.0,
              ),
            ),
            Colors.yellow.shade600,
            _signInAnonymously,
          ),
        ],
      ),
    );
  }
}
