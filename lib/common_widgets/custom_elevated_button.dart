import 'package:flutter/material.dart';

class CustomElevatedButton extends StatelessWidget {

  final Widget child;
  final double borderRadius;
  final VoidCallback onPressed;

  CustomElevatedButton(
      this.child, this.borderRadius, this.onPressed);

  @override
  Widget build(BuildContext context) {
    return  ElevatedButton(
      child: child,
      style:           ElevatedButton.styleFrom(
        primary: Colors.red,
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
