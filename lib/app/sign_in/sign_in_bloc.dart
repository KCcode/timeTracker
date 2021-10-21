import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:time_tracker_flutter/services/authBase.dart';

class SignInBloc {
  SignInBloc({required this.auth});

  final AuthBase auth;
  final StreamController<bool> _isLoadingController = StreamController<bool>();
  Stream<bool> get isLoadingStream => _isLoadingController.stream; //input stream

  void dispose(){
    _isLoadingController.close();
  }

  void _setIsLoading(bool isLoading) => _isLoadingController.add(isLoading);

  //function that returns a future of user
  Future<User?> _signIn(Future<User?> Function() signInMethod) async{
    try{
      _setIsLoading(true);
      return await signInMethod();
    }
    catch(e){ //sign in fails
      _setIsLoading(false);
      rethrow;
    }
  }

  Future<User?> signInAnonymously() async => await _signIn(auth.signInAnonymously);
  Future<User?> signInWithGoogle() async => await _signIn(auth.signInWithGoogle);

}