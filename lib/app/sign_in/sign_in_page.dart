import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:time_tracker_flutter/app/sign_in/sign_in_button.dart';
import 'package:time_tracker_flutter/app/sign_in/social_sign_in_button.dart';
import 'package:time_tracker_flutter/services/authBase.dart';

class SignInPage extends StatelessWidget {
  final void Function(User) onSignIn;  //make function a property of sign in page so it has no body
  final AuthBase auth;

  SignInPage(this.onSignIn, this.auth); //required property of this class

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Time Tracker"),
        elevation: 2.0,
      ),
      body: _buildContainer(),
      backgroundColor: Colors.grey[200],
    );
  }

  Future<void> _signInAnonymously() async {
    try {
      final user = await auth.signInAnonymously();
      onSignIn(user!);

    } catch (e) {
      print(e.toString());
    }
  }

  Widget _buildContainer() {
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
              Colors.black87, Colors.white, () {
            print("pressed google button");
          }),
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
            () {
              print('button email pressed');
            },
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
