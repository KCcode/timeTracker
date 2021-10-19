import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:time_tracker_flutter/common_widgets/custom_elevated_button.dart';

class SignInButton extends CustomElevatedButton {
  SignInButton(Widget child, Color buttonColor, VoidCallback? onPressed)
      : super(child, buttonColor, 4.0, onPressed);
}
