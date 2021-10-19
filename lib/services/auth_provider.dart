import 'package:flutter/material.dart';
import 'package:time_tracker_flutter/services/authBase.dart';

class AuthProvider extends InheritedWidget{
  final AuthBase auth;
  final Widget child;

  AuthProvider({required this.auth, required this.child}) : super(child: child);

  @override
  bool updateShouldNotify(covariant InheritedWidget oldWidget) => false;
    // TODO: implement updateShouldNotify
    //throw UnimplementedError();
  static AuthBase? of(BuildContext context){
    AuthProvider? provider = context.dependOnInheritedWidgetOfExactType<AuthProvider>();
    return provider?.auth;
  }

}