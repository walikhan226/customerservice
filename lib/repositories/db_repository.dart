import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../models/user_model.dart';

class DbRepository {
  static final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  static final CollectionReference _userCollection =
      _firestore.collection('users');

  Future saveUserToDb({String email, String number, String name}) async {
    try {
      UserModel user = UserModel(
        email:email,
        username:  name,
        number:  number,
      );
      await _userCollection.doc(FirebaseAuth.instance.currentUser.uid).set(user.toMap(user));
    } catch (e) {
      print(e);
    }
  }
}
