import 'package:customerservice/repositories/db_repository.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DetailController extends GetxController {
  var showLoader = false.obs;
  var _repo = DbRepository();

  void updateOrderStatus(model, status) {
    _repo.updateOrderStatus(model, status).then((value) {
      showLoader.value = true;
      // Get.snackbar("Success!", value);
    }).catchError((error) {
      showLoader.value = false;
      // Get.snackbar("Error!", error.toString());
    });
  }
}
