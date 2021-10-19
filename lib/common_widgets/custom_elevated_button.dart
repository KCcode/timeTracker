import 'package:flutter/material.dart';

class CustomElevatedButton extends StatelessWidget {
  final Widget child;
  final Color buttonColor;
  final double borderRadius;
  final VoidCallback? onPressed;

  CustomElevatedButton(this.child, this.buttonColor, this.borderRadius, this.onPressed);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      //RaisedButton > ElevatedButton
      child: child,
      //style: ButtonStyle TODO
      style: ElevatedButton.styleFrom(
        primary: buttonColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(borderRadius),
          ),
        ),
      ),
      onPressed: onPressed,
    );
  }
}
