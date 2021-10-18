import 'package:firebase_auth/firebase_auth.dart';

abstract class AuthBase {
  Stream<User?> authStateChanges();
  User? get currentUser;
  Future<User?> signInAnonymously();
  Future<User?> signInWithGoogle();
  Future<void> signOut();
}
