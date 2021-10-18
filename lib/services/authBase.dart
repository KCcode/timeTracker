import 'package:firebase_auth/firebase_auth.dart';

abstract class AuthBase {
  Stream<User?> authStateChanges();
  User? get currentUser;
  Future<User?> signInWithEmailAndPassword(String email, String password);
  Future<User?> createUserWithEmailAndPassword(String email, String password);
    Future<User?> signInAnonymously();
  Future<User?> signInWithGoogle();
  Future<void> signOut();
}
