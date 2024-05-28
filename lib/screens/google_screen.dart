import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:voice_assistant/screens/signin_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:google_sign_in/google_sign_in.dart';

class GoogleSignInProvider {
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  Future<UserCredential> signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      if (googleUser != null) {
        final GoogleSignInAuthentication googleAuth =
        await googleUser.authentication;
        final AuthCredential credential = GoogleAuthProvider.credential(
          accessToken: googleAuth.accessToken,
          idToken: googleAuth.idToken,
        );
        final UserCredential userCredential =
        await _firebaseAuth.signInWithCredential(credential);
        return userCredential;
      }
    } catch (e) {
      print(e);
    }
    return Future.error('Sign-in failed.');
  }

  Future<void> signOutWithGoogle() async {
    await _googleSignIn.signOut();
    await _firebaseAuth.signOut();
  }
}
class AuthServices{

  final _auth = FirebaseAuth.instance;

  singUp({
    required String email,
    required String password,
  })async{
    try {
      UserCredential user = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);

      if (user != Null) {
        return user;
      }
    } on FirebaseAuthException catch(e){
      print(e.code.toString());
    }
  }

  /// Improved login function
  Future<UserCredential?> signIn({
    required String email,
    required String password,
  }) async {
    try {
      final UserCredential user = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      if (user != null) {
        final SharedPreferences sp = await SharedPreferences.getInstance();
        sp.setString("email", email);
        return user;
      }
    } on FirebaseException catch (e) {
      print('Error signing in: $e');
    }
    return null; // Return null if login fails
  }
  //
  /// Improved logout function
  Future<void> logOut(BuildContext context) async {
    try {
      final SharedPreferences sp = await SharedPreferences.getInstance();
      sp.remove('email');
      await _auth.signOut();
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (_) => SignInScreen()), // Replace with your actual login screen
            (route) => false,
      );
    } catch (e) {
      print('Error logging out: $e');
    }
  }
}