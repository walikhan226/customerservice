import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

import 'db_repository.dart';

class AuthRepository {
  String signInError = 'User is not registered.';
  String signUpError = 'Please use different email.';

  var _auth = FirebaseAuth.instance;

  Future signUpWithEmailAndPassword(String email, String password) async {
    try {
      final user = await _auth.createUserWithEmailAndPassword(
        email: email.trim(),
        password: password,
      );
      return user;
    } on FirebaseAuthException catch (e) {
      signUpError = 'user not found';
      throw e;
    } catch (e) {
      print(e);
    }
  }

  Future signInWithEmailAndPassword(String email, String password) async {
    try {
      final user = await _auth.signInWithEmailAndPassword(
        email: email.trim(),
        password: password,
      );
      return user;
    } on FirebaseAuthException catch (e) {
      signInError = 'user not found';
      throw e;
    } catch (e) {
      print(e);
    }
  }

  Future<UserCredential> signInWithGoogle() async {
    // Trigger the authentication flow
    final GoogleSignInAccount googleUser = await GoogleSignIn().signIn();

    // Obtain the auth details from the request
    final GoogleSignInAuthentication googleAuth =
        await googleUser.authentication;

    // Create a new credential
    final GoogleAuthCredential credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    UserCredential result = await _auth.signInWithCredential(credential);
    if (result.additionalUserInfo.isNewUser) {
      if (result.user != null) {
        //save user to db
        await DbRepository().saveUserToDb(
          email: result.user.email,
          name: result.user.displayName,
          number: result.user.phoneNumber,
        );
      }
    } else {
      //Ex: Go to HomePage()
    }
    return result;
  }

  Future signOut() async {
    await _auth.signOut();
    await GoogleSignIn().signOut();
    await FacebookAuth.instance.logOut();
  }
}
