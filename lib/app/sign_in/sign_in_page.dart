import 'package:flutter/material.dart';
import 'package:time_tracker_flutter/common_widgets/custom_elevated_button.dart';

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
        ElevatedButton(
          child: Text(
            'Sign in with google',
            style: TextStyle(
              color: Colors.black87,
              fontSize: 15.0,
            ),
          ),
          style: ElevatedButton.styleFrom(
            primary: Colors.red,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(16.0),
              ),
            ),
          ),
          onPressed: () {
            print('button pressed');
          },
        ),
        SizedBox(
          height: 8.0,
        ),
        CustomElevatedButton(
          Text(
            'Sign in with google',
            style: TextStyle(
              color: Colors.black87,
              fontSize: 15.0,
            ),
          ),
          8.0,
          () {
            print('button pressed');
          },
        ),
      ],
    ),
  );
}

class SignInPage extends StatelessWidget {
  const SignInPage({Key? key}) : super(key: key);

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
}
