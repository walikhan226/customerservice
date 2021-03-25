import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/user_model.dart';

class DbRepository {
  static final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  static final CollectionReference _userCollection =
      _firestore.collection('users');

  Future saveUserToDb({var currentUser, String number, String name}) async {
    try {
      UserModel user = UserModel(
        email: currentUser.email,
        username: currentUser.displayName ?? name,
        number: currentUser.phoneNumber ?? number,
      );
      await _userCollection.doc(currentUser.uid).set(user.toMap(user));
    } catch (e) {
      print(e);
    }
  }
}
