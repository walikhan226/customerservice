import 'package:customerservice/models/user_model.dart';
import 'package:customerservice/screens/home_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:sign_in_with_apple/src/authorization_credential.dart';

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
      final user = await _auth
          .signInWithEmailAndPassword(
            email: email.trim(),
            password: password,
          )
          .whenComplete(() {})
          .catchError((error) => print("ERR: $error"));
      return user;
    } on FirebaseAuthException catch (e) {
      signInError = 'user not found';
      throw e;
    } catch (e) {
      print(e);
    }
  }

  void forgotPassword(String email) {
    _auth
        .sendPasswordResetEmail(
      email: email.trim(),
    )
        .whenComplete(() {
      print("SSSSS");
      Get.back(result: 1);
    }).catchError((error) => Get.snackbar("Error!", error.toString()));
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

    var user = await DbRepository().getUserDetail(result.user.uid);
    saveDataLocal(user);
    return result;
  }

  void saveDataLocal(UserModel user) {
    var box = GetStorage();
    box.write("email", user.email);
    box.write("name", user.username);
    box.write("number", user.number);
    box.write("islogin", true);
  }

  Future signOut() async {
    await _auth.signOut();
    await GoogleSignIn().signOut();
    await FacebookAuth.instance.logOut();
  }

  void updatePassword(password) {
    var user = _auth.currentUser;
    user.updatePassword(password).whenComplete(() {
      Get.back(result: 1);
    }).catchError((error) => Get.snackbar("Error!", error.toString()));
  }

  Future<UserModel> getUserDetail(userId) {
    return DbRepository().getUserDetail(userId);
  }

  Future saveAppleUserToFirebase(
      AuthorizationCredentialAppleID appleIdCredential) async {
    final oAuthProvider = OAuthProvider('apple.com');
    final credential = oAuthProvider.credential(
      idToken: appleIdCredential.identityToken,
      accessToken: appleIdCredential.authorizationCode,
    );
    final authResult = await _auth.signInWithCredential(credential);

    if (authResult.additionalUserInfo.isNewUser) {
      if (authResult.user != null) {
        //save user to db
        await DbRepository().saveUserToDb(
          email: authResult.user.email,
          name: authResult.user.displayName,
          number: authResult.user.phoneNumber,
        );
      }
    } else {
      //Ex: Go to HomePage()
    }

    var user = await DbRepository().getUserDetail(authResult.user.uid);
    saveDataLocal(user);
  }

  Future loginUsingFirebase(
      Map<String, dynamic> userData, AccessToken accessToken) async {
    final facebookAuthCredential =
        FacebookAuthProvider.credential(accessToken.token);
    final authResult = await _auth.signInWithCredential(facebookAuthCredential);
    print("AUTH: ${authResult.user.displayName}");
    if (authResult.additionalUserInfo.isNewUser) {
      if (authResult.user != null) {
        //save user to db
        await DbRepository().saveUserToDb(
          email: authResult.user.email,
          name: authResult.user.displayName,
          number: authResult.user.phoneNumber,
        );
      }
    } else {
      //Ex: Go to HomePage()
    }

    var user = await DbRepository().getUserDetail(authResult.user.uid);
    print("USER: ${user.username}");
    saveDataLocal(user);
  }
}
