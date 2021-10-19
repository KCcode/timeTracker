import 'dart:core';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:time_tracker_flutter/app/sign_in/email_sign_in_page.dart';
import 'package:time_tracker_flutter/app/sign_in/sign_in_button.dart';
import 'package:time_tracker_flutter/app/sign_in/social_sign_in_button.dart';
import 'package:time_tracker_flutter/common_widgets/show_exception_alert_dialog.dart';
import 'package:time_tracker_flutter/services/authBase.dart';

class SignInPage extends StatefulWidget {

  @override
  _SignInPageState createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {

  bool _isLoading = false;

  void _showSignInError(BuildContext context, Exception exception){
    if(!(exception is FirebaseException && exception.code == 'ERROR_ABORTED_BY_USER')) { //code in auth class
      showExceptionAlertDialog(
          context, title: 'Sign in Failed', exception: exception);
    }
  }

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

  Future<void> _signInAnonymously(BuildContext context) async {
    try {
      setState(() => _isLoading = true);
      final auth = Provider.of<AuthBase>(context, listen: false);
      await auth.signInAnonymously();
    } on Exception catch (e) {
      _showSignInError(context, e);
    }
    finally{
      setState(() => _isLoading = false);
    }
  }

  Future<void> _signInWithGoogle(BuildContext context) async {
    try {
      setState(() => _isLoading = true);
      final auth = Provider.of<AuthBase>(context, listen: false);
      await auth.signInWithGoogle();
    } on Exception catch (e) {
      _showSignInError(context, e);
    }
    finally{
      setState(() => _isLoading = false);
    }
  }

  void _signInWithEmail(BuildContext context) {
    Navigator.of(context).push( //look for navigator in ancestor once returned navigator push the route
      MaterialPageRoute<void>(
        fullscreenDialog: true,  //how page is presented specific to iOS true : from bottom false : slide from side
        builder: (context) => EmailSignInPage(),
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
          SizedBox(height: 50.0, child: _buildHeader(),),
          SizedBox(
            height: 8.0,
          ),
          SocialSignInButton("images/google-logo.png", "Sign in with Google",
              Colors.black87, Colors.white, _isLoading ? null : () => _signInWithGoogle(context)),
          SizedBox(
            height: 8.0,
          ),
          SocialSignInButton("images/facebook-logo.png",
              "Sign in with Facebook", Colors.white, Colors.blue.shade800, _isLoading ? null :
              () => print("pressed facebook button")
          ),
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
              _isLoading ? null : () => _signInWithEmail(context),
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
            _isLoading ? null : () => _signInAnonymously(context),
          ),
        ],
      ),
    );
  }

  Widget _buildHeader(){
    if(_isLoading){
      return Center(
        child: CircularProgressIndicator(),
      );
    }
    else{
      return Text(
        "Sign In",
        textAlign: TextAlign.center,
        style: TextStyle(
          fontSize: 32.0,
          fontWeight: FontWeight.w600,
        ),
      );
    }
  }
}
