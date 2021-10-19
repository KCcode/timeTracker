import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:time_tracker_flutter/common_widgets/show_alert_dialog.dart';

Future<void> showExceptionAlertDialog(
  BuildContext context, {
  required String title,
  required Exception exception,
}) =>
    showAlertDialog(
      context,
      title: title,
      content: _message(exception),
      defaultActionText: 'OK',
    );

//Guarantee that you can pass the human readable part of the firebase exception
//if it is present otherwise use the non FirebaseException as a fallback
String _message(Exception exception){
  if(exception is FirebaseException){
    return exception.message!;
  }
  return exception.toString();
}