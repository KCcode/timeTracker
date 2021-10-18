import 'package:flutter/material.dart';
import 'package:time_tracker_flutter/common_widgets/custom_elevated_button.dart';

class FormSubmitButton extends CustomElevatedButton{

  FormSubmitButton(VoidCallback? onPressed, String text,) : super(
    Text(text, style: TextStyle(color: Colors.white, fontSize: 20.0),),
    Colors.indigo,
    4.0,
    onPressed,
  );
}