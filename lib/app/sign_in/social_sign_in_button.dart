import 'package:flutter/material.dart';
import 'package:time_tracker_flutter/common_widgets/custom_elevated_button.dart';

class SocialSignInButton extends CustomElevatedButton {
  SocialSignInButton(String assetName, String text, Color textColor,
      Color buttonColor, VoidCallback onPressed)
      : super(
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Image.asset(assetName),
              Flexible(
                child: Text(
                  text,
                  style: TextStyle(color: textColor, fontSize: 15.0),
                ),
              ),
              Opacity(
                opacity: 0.0,
                child: Image.asset(assetName),
              ),
            ],
          ),
          buttonColor,
          4.0,
          onPressed,
        );
}
