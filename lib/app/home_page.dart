import 'package:flutter/material.dart';
import 'package:time_tracker_flutter/services/authBase.dart';

class HomePage extends StatelessWidget {
  final VoidCallback onSignOut;
  final AuthBase auth;

  HomePage(this.onSignOut, this.auth);

  Future<void> _signOut() async {
    try {
      await auth.signOut(); //no longer have a reference to the firebase user after sign out
      onSignOut();
    } catch (e) {
      print(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home Page'),
        actions: <Widget>[
          TextButton(
            //FlatButton > TextButton
            child: Text(
              'Logout',
              style: TextStyle(
                fontSize: 18.0,
                color: Colors.white,
              ),
            ),
            onPressed: _signOut,
          ),
        ],
      ),
    );
  }
}
