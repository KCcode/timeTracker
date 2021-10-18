import 'package:firebase_auth/firebase_auth.dart';
import 'authBase.dart';

class Auth implements AuthBase {
  late FirebaseAuth _firebaseAuth;// final _firebaseAuth = FirebaseAuth.instance;

  Auth(){
    _firebaseAuth = FirebaseAuth.instance;
  }

  @override
  Stream<User?> authStateChanges() => _firebaseAuth.authStateChanges();

  @override
  User? get currentUser => _firebaseAuth.currentUser;

  @override
  Future<User?> signInAnonymously() async {
    final userCredential = await _firebaseAuth.signInAnonymously();
    return userCredential.user;
  }

  @override
  Future<void> signOut() async {
    await _firebaseAuth.signOut();
  }
}
