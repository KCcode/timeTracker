import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:time_tracker_flutter/services/authBase.dart';

class SignInManager {
  SignInManager({required this.auth, required this.isLoading});

  final AuthBase auth;
  final ValueNotifier<bool> isLoading;

  //function that returns a future of user
  Future<User?> _signIn(Future<User?> Function() signInMethod) async{
    try{
      isLoading.value = true;
      return await signInMethod();
    }
    catch(e){ //sign in fails
      isLoading.value = false;
      rethrow;
    }
  }

  Future<User?> signInAnonymously() async => await _signIn(auth.signInAnonymously);
  Future<User?> signInWithGoogle() async => await _signIn(auth.signInWithGoogle);

}