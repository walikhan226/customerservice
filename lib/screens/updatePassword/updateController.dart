import 'package:customerservice/localization/keys.dart';
import 'package:customerservice/repositories/auth_repositories.dart';
import 'package:flutter/material.dart';
import 'package:flutter_translate/global.dart';
import 'package:get/get.dart';

class UpdateController extends GetxController {
  final TextEditingController oldPassword = TextEditingController();
  final TextEditingController newPassword = TextEditingController();
  final TextEditingController confirmPassword = TextEditingController();
  var showLoader = false.obs;
  var _repo = AuthRepository();

  void updatePassword() {
    /* if (oldPassword.text.isEmpty) {
      Get.snackbar("Alert!", "Enter old password");
      return;
    }*/

    if (newPassword.text.isEmpty) {
      Get.snackbar(translate(Keys.alert), translate(Keys.enterNewPass));
      return;
    }

    if (confirmPassword.text.isEmpty) {
      Get.snackbar(translate(Keys.alert), translate(Keys.enterConPass));
      return;
    }

    if (confirmPassword.text != newPassword.text) {
      Get.snackbar(translate(Keys.alert), translate(Keys.passNotMatched));
      return;
    }
    showLoader.value = true;
    _repo.updatePassword(confirmPassword.text);
    Future.delayed(Duration(seconds: 3), () {
      showLoader.value = false;
    });
  }
}
