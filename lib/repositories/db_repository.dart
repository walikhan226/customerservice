import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:customerservice/models/order_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

import '../models/user_model.dart';

class DbRepository {
  static final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  static final CollectionReference _userCollection =
      _firestore.collection('users');
  static final CollectionReference _activeOrders =
      _firestore.collection('activeOrders');
  static final CollectionReference _pastOrders =
      _firestore.collection('pastOrders');

  Future saveUserToDb({String email, String number, String name}) async {
    try {
      UserModel user = UserModel(
        email: email,
        username: name,
        number: number,
      );
      await _userCollection
          .doc(FirebaseAuth.instance.currentUser.uid)
          .set(user.toMap(user));
    } catch (e) {
      print(e);
    }
  }

  Future saveActiveOrder(OrderModel orderModel) async {
    try {
      orderModel.userId = FirebaseAuth.instance.currentUser.uid;
      // orderModel.userId = "1234";
      await _activeOrders
          .doc(orderModel.orderId)
          .set(orderModel.toMap(orderModel))
          .whenComplete(() {
        print("Saved Successfully");
        Get.snackbar("Success!", "Your order is saved to active orders");
      }).catchError((error) => print("ERR: $error"));
    } catch (e) {
      print(e);
    }
  }

  Future<List<QueryDocumentSnapshot>> getActiveOrders() async {
    var snapshot = await _activeOrders
        .where(
          'userId',
          isEqualTo: FirebaseAuth.instance.currentUser.uid,
        )
        .get();
    if (snapshot.size > 0) {
      return snapshot.docs;
    } else {
      return Future.error("No active order found");
    }
  }

  Future<List<QueryDocumentSnapshot>> getOrderHistory() async {
    var snapshot = await _pastOrders
        .where(
          'userId',
          isEqualTo: FirebaseAuth.instance.currentUser.uid,
        )
        .get();
    if (snapshot.size > 0) {
      return snapshot.docs;
    } else {
      return Future.error("No order found");
    }
  }

  Future<void> updateOrderStatus(OrderModel model, int status) async {
    FirebaseAuth.instance.currentUser.uid;
    model.orderStatus = status;
    _activeOrders.doc(model.orderId).delete();
    await _pastOrders
        .doc(model.orderId)
        .set(model.toMap(model))
        .whenComplete(() {
      Get.snackbar("Success!", "Status updated successfully");
    }).catchError((error) {
      Get.snackbar("Error!", error.toString());
    });
  }

  Future<UserModel> getUserDetail(userId) async {
    var snapshot = await _userCollection.doc(userId).get();
    if (snapshot.exists) {
      return UserModel.fromMap(snapshot.data());
    } else {
      return Future.error("No user found");
    }
  }
}
